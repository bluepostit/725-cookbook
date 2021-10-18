require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    csv_options = {
      headers: :first_row,
      header_converters: :symbol
    }
    CSV.foreach(csv_file_path, csv_options) do |row|
      @recipes << Recipe.new(row)
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[name description rating]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating]
      end
    end
  end
end
