require 'nokogiri'
require 'open-uri'
require 'yaml'

# Get the top 5 films urls
url = "https://www.imdb.com/chart/top"

html = open(url).read

doc = Nokogiri::HTML(html)

urls = doc.search('.titleColumn a').first(5).map do |title|
    "https://www.imdb.com" + title.attribute('href').value
end

# p urls
# Get all the information
movies = urls.map do |url|
    html = open(url).read
    doc = Nokogiri::HTML(html)
    title = doc.search('h1').text.strip
    year = doc.search('.jedhex').first.text.strip
    storyline = doc.search('.iywpty .ipc-html-content div').text.strip
    director = doc.search('.cbPPkN .ipc-metadata-list-item__list-content-item').first.text.strip
    actors = doc.search('.eyqFnv').first(3).map do |actor|
        actor.text.strip
    end
    {
        title: title,
        year: year,
        storyline: storyline,
        director: director,
        cast: actors
    }
end

p movies

# Write in the yml file

File.open('movies.yml', 'w') {|f| f.write movies.to_yaml } 

