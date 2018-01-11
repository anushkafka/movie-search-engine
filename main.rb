require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'pry'

get '/' do
  erb :index
end
$page_no = 1
get '/movie_list' do
  search_key = params["movies"]
  @input = search_key
  
  url = 'http://www.omdbapi.com/?s='+search_key+'&page='+$page_no.to_s+'&apikey=ef858bce'

  response = HTTParty.get(url)

  @movie_list = Array.new
  response.parsed_response["Search"].each do |movie|
      # @title_list << movie["Title"]
      @list = Hash.new
      @list = {
        "title" => movie["Title"], 
        "poster" => movie["Poster"],
        "year" => movie["Year"]
      }
      @movie_list << @list
   
  end
  erb :search_results
end

get '/movie_page' do
  search_key = params["movie"]
 
  response = HTTParty.get('http://www.omdbapi.com/?t='+search_key+'&apikey=ef858bce')

  @no_error = response.parsed_response["Response"]

  @title = response.parsed_response["Title"]
  @year = response.parsed_response["Year"]
  @poster = response.parsed_response["Poster"]
  @rating = response.parsed_response["imdbRating"]
  @plot = response.parsed_response["Plot"]

  @released = response.parsed_response["Released"]
  @runtime = response.parsed_response["Runtime"]
  @genre = response.parsed_response["Genre"]
  @language = response.parsed_response["Language"]

  @director = response.parsed_response["Director"]
  @writer = response.parsed_response["Writer"]
  @actors = response.parsed_response["Actors"]


  erb :movie
end





