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
      rating = element.search('.rating-star.active').count

      # prep time
      prep_time = parse_prep_time(element)

      Recipe.new({ name: name, description: description, rating: rating, prep_time: prep_time })
    end
  end

  def parse_prep_time(element)
    url = element.search('.card__titleLink').attribute('href').value
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    text = doc.search('.two-subcol-content-wrapper').text.strip

    match_data = text.match(/total:\s+(\d+\s+\w+)/)
    return '' if match_data.nil?

    return match_data[1]
  end
end
