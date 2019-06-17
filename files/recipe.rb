class Recipe
  def initialize(name, description, cooking_time = 0, marked)
    @name = name
    @description = description
    @cooking_time = cooking_time
    @marked = false
  end
  attr_accessor :name, :description, :cooking_time, :marked
end
