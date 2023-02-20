require "json"
require "open-uri"

class GamesController < ApplicationController

  before_action :reset_session, :set_score

  def new
    all_letters = ('A'..'Z').to_a
    @letters = []

    10.times do
      @letters << all_letters.sample
    end

    @letters
  end

  def score
    @word = params[:word]
    @user_letters = params[:letters]
    word_letters = @word.upcase.chars
    contains = true
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @answer = nil

    word_letters.each do |word_letter|
      contains = false unless @user_letters.include?(word_letter)
    end

    if contains == true
      user_serialized = URI.open(url).read
      user = JSON.parse(user_serialized)
      if user["found"] == true
        cookies[:score] = cookies[:score].to_i + @word.length
        @score = cookies[:score]
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry but #{@word} does not seems to be a valid English word..."
      end
    else
      @answer = "Sorry but #{@word} can't be build out of #{@user_letters}"
    end
  end

  def set_score
    cookies[:score] = 0 if cookies[:score].nil?
  end

end
