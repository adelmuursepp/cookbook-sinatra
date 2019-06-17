require 'csv'
class Cookbook
  attr_reader :recipes
  def initialize(csv_file_for_data)
    @database = csv_file_for_data # recipes.csv
    @recipes = []
    puts @recipes
    load_csv
  end

  # For list action, 1st step. getting data

  def load_csv
    CSV.foreach(@database) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
    return @recipes
  end

  def all
    @recipes
  end

  # For create action, 2nd step. saving recipe

  def add_recipe(new_recipe)
    # array << new_recipe.name << new_recipe.description
    @recipes << new_recipe
    CSV.open(@database, 'wb') do |row|
      @recipes.each do |obj|
        row << [obj.name, obj.description, obj.cooking_time, obj.marked]
      end
    end
    @recipes
  end

  # For destroy action, 2nd step.
  def remove_recipe(index)
    @recipes.delete_at(index)
    CSV.open(@database, 'wb') do |row|
      @recipes.each do |obj|
        row << [obj.name, obj.description, obj.cooking_time, obj.marked]
      end
    end
    return @recipes
  end

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.marked = true
    CSV.open(@database, 'wb') do |row|
      @recipes.each do |obj|
        row << [obj.name, obj.description, obj.cooking_time, obj.marked]
      end
    end
  end
end
