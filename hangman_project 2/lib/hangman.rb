require 'byebug'
class Hangman
  attr_reader :remaining_incorrect_guesses, :guess_word, :attempted_chars, :remaining_incorrect_guesses
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word 
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    idxs = []
    @secret_word.each_char.with_index do |ltr, i|
      if char == ltr
        idxs << i
      end
    end 
    idxs
  end

  def fill_indices(char, arr)
    @guess_word.each do |blank|
      arr.each do |i2|
        @guess_word[i2] = char
      end
    end
  end

  def try_guess(char)
    tried = self.already_attempted?(char)
    match = self.get_matching_indices(char)
    fill = self.fill_indices(char, match)

    if tried
      p 'that has already been attempted'
      return false
    end
    if match.length == 0
      @remaining_incorrect_guesses -=1
    end
    @attempted_chars << char
    true
  end

  def ask_user_for_guess
    p "Enter a char: "
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    if @guess_word.join('') == @secret_word
      p "WIN"
      return true
    else
      return false
    end
  end

  def lose? 
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word
      return true
    else
      return false
    end
  end
end
