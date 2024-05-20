require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    return @letters
  end

  def score
    @word = params["word"]
    if word_exist?(@word)
      @result = word_in_grid?(params["word"].upcase.chars, params["letters"].chars)
    else
      @result = "Sorry but #{params["word"]} does not seem to be a valid English word..."
    end
    # raise
  end

  def word_in_grid?(word_array, grid)
    array = word_array.filter { |letter| grid.include?(letter) }
    if !found_duplicates?(array.tally, grid.tally)
      return "Congratulations, you scored #{array.length} points!"
    else
      return "Sorry but #{params["word"]} can't be built out of #{params["letters"]}"
    end
  end

  def found_duplicates?(word_hashes, grid_hashes)
    word_hashes.each do |key, value|
      if grid_hashes[key] && value > grid_hashes[key]
        return true
      else
        return false
      end
    end
  end

  def word_exist?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    res = URI.open(url).read
    JSON.parse(res)["found"]
  end

end
