require_relative "styles"

module Display
  def display_letter_prompt
    "\nEnter a guess which is a letter from the alphabet #{'>'.style('blue', 'bold')} "
  end

  def display_error(info = "")
    "ERROR: Wrong Input.#{info}".style("red", "bold")
  end

  def display_chances(n)
    "You have #{String(n).color('red')} chance/s left."
  end

  def display_name_prompt
    "Choose a name not included in the list above which doesn't contain '.' and is [3-100] chars long #{'>'.style('blue', 'bold')} "
  end

  def display_created_file(name)
    "Successfully created #{(name << '.txt').style('purple', 'bold')}"
  end

  def display_saves(saves)
    "Your current saves are: #{saves.map {|name| "\n\t#{name[6..-5].mode('bold')}" }.join}"
  end

  def display_winning
    "#{'Congratulations'.style('green', 'italic')}, you won the game!"
  end

  def display_losing(word)
    "\n#{'You lost the game!'.style('red', 'underscored')}\nThe correct word was #{word.style('orange', 'bold')}"
  end

  def display_guesses(guesses)
    guesses.map do |guess|
      letter = guess[0].to_s
      contained = guess[1]
      if contained
        letter.style("green", "bold")
      else
        letter.style("red", "bold")
      end
    end.join(", ")
  end
end