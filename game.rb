# rubocop:disable Lint/ConstantResolution
require_relative "dictionary"

class Hangman
  include Dictionary
  def initialize(options = { word: WORDS.sample, guesses: {} })
    @word = options[:word]
    @guesses = options[:guesses]
    @round = 12 - @guesses.length
    start
  end

  def start
    @round.times do |n|
      propmt_player
    end
  end

  def propmt_player
    print("Please enter a letter from the alphabet > ")
    letter = gets.chomp
    return letter if letter.match(/[a-z]/i) && letter.length == 1
    propmt_player
  end

  def replace_guesses
    sample = @word.clone.chars
    sample.map! do |letter|
      if @guesses[letter.to_sym]
        letter
      else
        "_"
      end
    end
    sample.join
  end
end

p Hangman.new({ word: "hen", guesses: { a: false, e: true, b: false, h: true } }).replace_guesses
# rubocop:enable Lint/ConstantResolution