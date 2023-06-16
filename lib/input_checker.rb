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
        assign_alphabet_colors(letter: letter, color: '3')
      elsif !correct_letters.index(letter).nil? && guess_letters[correct_letters.index(letter)] != letter
        comparison.push('2')
        assign_alphabet_colors(letter: letter, color: '2')
        correct_letters[correct_letters.index(letter)] = '-'
      else
        assign_alphabet_colors(letter: letter, color: '1')
        comparison.push('x')
      end
    end

    comparison
  end
end

def assign_alphabet_colors(letter: string, color: string)
  alphabet_colors[alphabet_colors.index(letter)] = color if alphabet_colors.index(letter)
end
