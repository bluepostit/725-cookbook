# State
#  - repository (cookbook)
#  - view
# Behavior
#  - list
#  - create
#  - destroy

require_relative 'view'
require_relative 'scrape_all_recipes_service'

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
    rating = @view.ask_user_for('rating')
    prep_time = @view.ask_user_for('preparation time')
    recipe = Recipe.new({ name: name, rating: rating, description: description, prep_time: prep_time })
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

  def import
    keyword = @view.ask_user_for('ingredient')
    results = ScrapeAllRecipesService.new(keyword).call
    @view.display(results)

    index = @view.ask_user_for_index
    recipe = results[index]
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    list
    index = @view.ask_user_for_index
    @cookbook.mark_as_done(index)
  end
end
