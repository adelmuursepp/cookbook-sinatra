require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "./files/cookbook.rb"
require_relative "./files/parsing.rb"
require_relative "./files/recipe.rb"
require_relative "./DB/recipes.csv"
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = "./DB/recipes.csv"
cookbook = Cookbook.new(csv_file)

get "/" do
  @recipes = cookbook.all
  erb :index
end


