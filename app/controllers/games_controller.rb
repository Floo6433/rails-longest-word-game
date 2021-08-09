require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def score
   # raise
    @word = params[:word].upcase.split("")
    @letters_test = params[:letters].upcase.split("")
    @letters = @letters_test
    # @message = "Sorry but #{@word.upcase} can't be built out of #{@letters}"
    word_test = true
    @letters_test.each_with_index do |w, i|
      if @word.include?(w)
        word_test = true
        @letters_test.delete_at(i)
      else
        word_test = false
      end
      break if word_test == false
    end

    if word_test = true && english_word(params[:word])
      @message = "mot bon"
    else
      @message = "mot mauvais"
    end
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end
end
