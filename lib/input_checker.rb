# frozen_string_literal: true

require_relative './word_list'
require 'pry'

class InputChecker
  def initialize(correct_word:)
    @correct_word = correct_word
  end

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
      else
        comparison.push('x')
      end
    end

    guess_letters.each_with_index do |letter, index|
      if !correct_letters.index(letter).nil?
        comparison[index] = 'y'
        correct_letters[correct_letters.index(letter)] = '-'
      end
    end

    comparison
  end
end
