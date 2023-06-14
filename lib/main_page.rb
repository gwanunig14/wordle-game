# frozen_string_literal: true

require 'colorize'

require_relative './word_list'
require_relative './input_checker'
require_relative './word_generator'

class MainPage
  def initialize
    # @correct_word = WordGenerator.new.select_word
    @correct_word = 'apple'
    @input_checker = InputChecker.new(correct_word: @correct_word)
  end

  def play_game
    correct_comparison = []
    guesses = 6

    until correct_comparison == %w[g g g g g] || guesses == 0
      puts 'Guess a five letter word'
      puts guesses.to_s + ' guesses remaining'
      user_guess = gets.chomp
      user_guess_result = user_guess.split('')
      correct_comparison = guess(guess: user_guess)
      if correct_comparison.is_a? String
        puts correct_comparison
      else
        correct_comparison.each_with_index do |letter, i|
          if letter == 'g'
            print(user_guess_result[i].colorize(:green))
          elsif letter == 'y'
            print(user_guess_result[i].colorize(:red))
          else
            print(user_guess_result[i])
          end
        end
        guesses -= 1
        puts
      end
    end

    if correct_comparison == %w[g g g g g]
      'Congrats'
    else
      'Too bad. Try a new game.'
    end
  end

  def guess(guess:)
    assessment = @input_checker.valid_guess(attempt: guess)
    return assessment unless assessment == guess

    @input_checker.guess(guess: guess)
  end
end
