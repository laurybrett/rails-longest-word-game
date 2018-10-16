require 'json'
require 'open-uri'

class GamesController < ApplicationController
  LETTERS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  def new
    @letters = LETTERS.sample(10)
  end

  def score
    @scenario = ''
    @array_letter = params[:word].chars
    @url = 'https://wagon-dictionary.herokuapp.com/:word'
    single_word = open(@url).read
    @mot = JSON.parse(single_word)
    @found = @mot["found"]

    # case 1 - not in the the grid
    if !@array_letter.all? { |letter| params[:grid].include?(letter) }
      @scenario = 'out of grid'
    # case 2 - not an english word
    elsif @found == false
      @scenario = 'not english'
    # case 3 - english and in the grid
    else
      @scenario = 'ok'
    end
  end
end
