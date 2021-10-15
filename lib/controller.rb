# State
#  - repository (cookbook)
#  - view
# Behavior
#  - list
#  - create
#  - destroy

require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # get info from repository
    # display it with the view
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    # get recipe info from user (view)
    # create a new Recipe instance with that info
    # add that to the cookbook (repository)
    name = @view.ask_user_for('name')
    description = @view.ask_user_for('description')
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # list recipes
    # get index from user
    # remove from cookbook (repository)
    list
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index)
  end
end
