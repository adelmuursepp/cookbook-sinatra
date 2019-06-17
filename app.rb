require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "./files/cookbook.rb"
require_relative "./files/parsing.rb"
require_relative "./files/recipe.rb"
set :bind, '0.0.0.0'

configure do
  set :public_folder, File.dirname(__FILE__) + '/static'
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = File.join(__dir__, "DB/recipes.csv")
cookbook = Cookbook.new(csv_file)
parser = Parsing.new

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/" do
  name = params["name"]
  description = params["description"]
  cookingtime = params["prep time"]
  recipe = Recipe.new(name, description, cookingtime)
  cookbook.add_recipe(recipe)
  @recipes = cookbook.all
  erb :index
end

get "/destroy/:index" do
  index = params[:index]
  cookbook.remove_recipe(index.to_i)
  redirect "/"
end

get "/mark/:index" do
  index = params[:index]
  cookbook.mark_as_done(index.to_i)
  redirect "/"
end

get "/inspiration" do
  erb :inspiration
end

post "/inspiration" do
  keyword = params["keyword"]
  redirect "/ideas/#{keyword}"
end

get "/ideas/:keyword" do
  keyword = params[:keyword]
  @ideas = parser.scrape(keyword)
  erb :ideas
end
