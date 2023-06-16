# frozen_string_literal: true

require_relative './word_list'
require 'pry'

class InputChecker
  def initialize(correct_word:)
    @correct_word = correct_word
    @alphabet_colors = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
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
        comparison.push('3')
        correct_letters[index] = '-'
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = '3'
        end
      elsif !correct_letters.index(letter).nil? && guess_letters[correct_letters.index(letter)] != letter
        comparison.push('2')
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = '2'
        end
        correct_letters[correct_letters.index(letter)] = '-'
      else
        if alphabet_colors.index(letter)
          alphabet_colors[alphabet_colors.index(letter)] = '1'
        end
        comparison.push('x')
      end
    end

    comparison
  end
end
