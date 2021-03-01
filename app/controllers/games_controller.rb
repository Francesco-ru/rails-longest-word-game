require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = []
    10.times { @grid << ("a".."z").to_a[rand(26)] }
    # @grid.each do |letter|
    #   @letter = letter
    # end
  end

  def in_grid?(word, grid)
    word.chars.all? do |let|
      word.count(let) <= grid.count(let)
    end
  end

  def real_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api = open(url).read
    boolean = JSON.parse(api)
    boolean["found"]
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    @in_grid = in_grid?(@word, @grid)
    @eng_word = real_word?(@word)
  end
end
