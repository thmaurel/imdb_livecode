require_relative "scraper"
require 'yaml'


# Get the top 5 movies
puts 'Getting the top 5 movies'
urls = movie_urls

# Scrape the movies to retrieve all infos
movies = urls.map do |url|
  puts "Scraping #{url}.."
  scrape_movie(url)
end

# movies = [{title: "azeza", year: "1987", director...}, {}]

# Save these information into a yml file
puts 'Writing in movies.yml file'
File.open('movies.yml', 'w') {|f| f.write movies.to_yaml }
