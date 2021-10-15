require_relative 'recipe'
require_relative 'cookbook'
require_relative 'controller'

cheesecake = Recipe.new('cheesecake', 'delicious dessert')
cookbook = Cookbook.new('lib/recipes.csv')

controller = Controller.new(cookbook)
