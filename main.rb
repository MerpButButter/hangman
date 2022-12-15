require_relative "hangman"
require_relative "styles"
require_relative "save_load"

def repeat_game
  puts(display_game_selection)
  mode_input = gets.chomp

  case mode_input
  when "0"
    ::Hangman.new
  when "1"
    data = ::SaveLoad.new.get_data

    if data.nil?
      repeat_game
      return 
    else
      ::Hangman.new(data)
    end
  else
    puts(display_error(" Enter '0' or '1'."))
    repeat_game
  end

  print(display_play_again)
  again_input = gets.chomp
  repeat_game if again_input == "y"
  puts("Thanks for playing!".style("orange", "bold"))
end

def display_play_again
  "\nEnter 'y' if you want to play again #{'>'.style('blue', 'bold')} "
end

def display_error(info = "")
  "ERROR: Wrong Input.#{info}".style("red", "bold")
end

def display_game_selection
  "\nEnter '0' to start a #{'NEW'.style('blue', 'bold')} game OR\nEnter '1' to start a #{'SAVED'.style('purple', 'bold')} game"
end

repeat_game