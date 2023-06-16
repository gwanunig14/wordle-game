# frozen_string_literal: true

require_relative './word_list'
require 'pry'

class InputChecker
  def initialize(correct_word:)
    @correct_word = correct_word
    @alphabet_colors = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  end

  attr_reader :alphabet_colors

  def valid_guess(attempt:)
    return 'Words must be five letters long.' unless attempt.length == 5
    return 'Invalid word' unless word_list.include?(attempt)

    attempt
  end

  def guess(guess:)
    compare_guess_to_correct_word(guess: guess)
  end

  private

  def compare_guess_to_correct_word(guess:)
    comparison = []
    guess_letters = guess.split('')
    correct_letters = @correct_word.split('')
    guess_letters.each_with_index do |letter, index|
      if letter == correct_letters[index]
        comparison.push('g')
        correct_letters[index] = '-'
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = 'g'
        end
      elsif !correct_letters.index(letter).nil? && guess_letters[correct_letters.index(letter)] != letter
        comparison.push('r')
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = 'r'
        end
        correct_letters[correct_letters.index(letter)] = '-'
      else
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = 'x'
        end
        comparison.push('x')
      end
    end

    comparison
  end
end
