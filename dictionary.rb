module Dictionary
  WORDS = File.readlines("dictionary.txt").select { |word| word.chomp!.length.between?(5, 12) }
  public_constant :WORDS
end