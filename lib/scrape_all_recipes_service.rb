require 'nokogiri'
require 'open-uri'

require_relative 'recipe'


class ScrapeAllRecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  # Scrape and return an array of Recipe objects
  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)

    doc.search('.card__detailsContainer').first(5).map do |element|
      name = element.search('.card__title').text.strip
      description = element.search('.card__summary').text.strip
      Recipe.new(name, description)
    end
  end
end
