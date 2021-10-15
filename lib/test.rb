require_relative 'recipe'
require_relative 'cookbook'

cheesecake = Recipe.new('cheesecake', 'delicious dessert')
puts "#{cheesecake.name} - #{cheesecake.description}"

cookbook = Cookbook.new('lib/recipes.csv')
p cookbook.all

cookbook.add_recipe(cheesecake)
p cookbook.all
cookbook.remove_recipe(0)
p cookbook.all
