# frozen_string_literal: true

require_relative './word_list'
require 'pry'

# InputChecker
class InputChecker
  def initialize(correct_word:)
    @alphabet_colors = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @correct_letters = correct_word.split('')
  end

  attr_reader :alphabet_colors, :correct_letters

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
    guess_letters.each_with_index do |letter, index|
      color = compare_letters(letter: letter, index: index)
      comparison.push(color)
    end

    comparison
  end
end

def compare_letters(letter: string, index: number, guess_letters: %w[])
  color_assignment = '1'
  if letter == correct_letters[index]
    correct_letters[index] = '-'
    color_assignment = '3'
  elsif !correct_letters.index(letter).nil? && guess_letters[correct_letters.index(letter)] != letter
    correct_letters[correct_letters.index(letter)] = '-'
    color_assignment = '2'
  end

  assign_alphabet_colors(letter: letter, color: color_assignment)
  color_assignment
end

def assign_alphabet_colors(letter: string, color: string)
  alphabet_colors[alphabet_colors.index(letter)] = color if alphabet_colors.index(letter)
end
