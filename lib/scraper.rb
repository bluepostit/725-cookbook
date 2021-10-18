require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

url = 'https://www.allrecipes.com/search/results/?search=chocolate'
html = URI.open(url).read
doc = Nokogiri::HTML(html)

results = doc.search('.card__detailsContainer').map do |element|
  name = element.search('.card__title').text.strip
  description = element.search('.card__summary').text.strip
  Recipe.new(name, description)
end

p results

# results = ???
