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
      # 'Convert' from string value from CSV, to a boolean
      row[:done] = row[:done] == 'true'
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

  # We do this from the cookbook/repository so that we can
  # call `save_csv` right afterwards; this keeps the CSV in sync.
  def mark_as_done(index)
    @recipes[index].mark_as_done!
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[name description rating prep_time done]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating,
                recipe.prep_time, recipe.done?]
      end
    end
  end
end
