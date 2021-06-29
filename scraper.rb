require 'open-uri'
require 'nokogiri'

# Get the link of top 5 movies
def movie_urls
  url = "https://www.imdb.com/chart/top"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.titleColumn a')[0..4].map do |result|
    url = "https://www.imdb.com" + result.attribute('href').value
  end
end

# Get the information for every single movie
# Top 3 casts / director / storyline / title / year
def scrape_movie(url)
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  infos =  html_doc.search('h1').text.strip.split("(")
  title = infos[0][0..-2]
  year = infos[1][0..-2]
  storyline = html_doc.search('.summary_text').text.strip
  director = html_doc.search('.credit_summary_item a').first.text.strip
  cast = html_doc.search('.primary_photo img').first(3).map do |result|
    result.attribute('alt').value
  end
  {title: title, year: year, storyline: storyline, director: director, cast: cast}
end


