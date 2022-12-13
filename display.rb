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