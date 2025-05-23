# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'open-uri'
require "json"

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.parse(url).read
movies = JSON.parse(movies_serialized)["results"]

Movie.destroy_all
Bookmark.destroy_all
List.destroy_all

movies.each do |movie_data|
  movie = Movie.create!(
    title: movie_data["original_title"],
    overview: movie_data["overview"],
    poster_url: movie_data["poster_path"],
    rating: movie_data["vote_average"]
  )
  puts "Created #{movie.title}"
end

10.times do |index|
  list = List.create!(
    name: Faker::Book.title,
    image_url: "https://source.unsplash.com/random/300x200?movie"
  )
  puts "Created #{list.name} list"
end

puts "Finito pipo! #{Movie.count} movies created"
puts "Finito pipo! #{List.count} lists created"
