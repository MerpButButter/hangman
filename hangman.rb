# rubocop:disable Lint/ConstantResolution
require_relative "dictionary"
require_relative "styles"
require_relative "display"
require_relative "save_load"
require "yaml"

# Hangman game in which you can start from a saved position or from scratch with a random word
class Hangman
  include Display
  include Dictionary
  def initialize(options = { word: WORDS.sample, guesses: {} })
    @word = options[:word]
    @guesses = options[:guesses]
    @round = 12 - wrong_guesses
    @won = false
    @starting = true
    start
  end

  def start
    until @round <= 0
      puts("\n\t#{replace_guesses}\t #{display_guesses(@guesses)} \n\n") if @starting
      prompt = propmt_player
      # Saves games and breaks the loop
      if prompt == "save"
        SaveLoad.new.save_data({ word: @word, guesses: @guesses })
        @won = nil
        break
      end

      add_guess(prompt)
      puts("\n\t#{replace_guesses}\t #{display_guesses(@guesses)} \n\n")
      set_round
      puts(display_chances(@round))
      if replace_guesses.scan("_").empty?
        @won = true
        break
      end
    end
    # Prints if you won or lost the game
    if @won 
      puts(display_winning)
    elsif @won == false
      puts(display_losing(@word))
    end
  end

  def set_round
    @round = 12 - wrong_guesses
  end
  
  def wrong_guesses 
    @guesses.values.count(false)
  end

  def propmt_player
    print(display_save_prompt)
    print(display_letter_prompt)
    letter = gets.chomp

    return "save" if letter == "save"
    return letter if letter.match(/[a-z]/i) && letter.length == 1 && @guesses.keys.map(&:to_s).none?(letter)
    
    if @guesses.keys.map(&:to_s).none?(letter)
      puts(display_error)
    else
      puts(display_error(" Guess already exists.")) 
    end
    propmt_player
  end

  def add_guess(guess)
    @guesses[guess.to_sym] = !@word.scan(guess).empty?
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
# rubocop:enable Lint/ConstantResolution