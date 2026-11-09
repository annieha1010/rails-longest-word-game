class GamesController < ApplicationController
  def new
    @letters = ("a"..."z").to_a.sample(10)
  end

  def score
    @dictionary = { "found" => false }
    if params[:word]
      # raise
      letters = params[:letters].split(" ")
      if params[:word].chars.all? { |letter| letters.count(letter) >= params[:word].count(letter) }
        require "json"
        require "open-uri"
        url = "https://dictionary.lewagon.com/#{params[:word]}"
        json = URI.parse(url).read
        @dictionary = JSON.parse(json)
        if @dictionary["found"] ==  true
          @result = "#{params[:word]} is an English word"
        else
          @result = "#{params[:word]} is not an English word"
        end
      else
        @result = "Please provide correct word from the grid"
      end
    end
  end
end
