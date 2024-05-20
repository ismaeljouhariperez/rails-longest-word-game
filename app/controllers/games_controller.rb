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
    letters = params["letters"]
    testu = check_word(@word, letters) if word_exist?(@word)
    raise
  end

  def check_word(word, grid)
  end

  def word_exist?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    res = URI.open(url).read
    JSON.parse(res)
  end

end
