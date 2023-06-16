# frozen_string_literal: true

require 'colorize'

require_relative './word_list'
require_relative './input_checker'
require_relative './word_generator'

class MainPage
  def initialize
    # @correct_word = WordGenerator.new.select_word
    @correct_word = WordGenerator.new.select_word
    @input_checker = InputChecker.new(correct_word: @correct_word)
  end

  def play_game
    correct_comparison = []
    guesses = 6

    puts 'Guess a five letter word'

    until correct_comparison == %w[g g g g g] || guesses == 0
      puts "  #{guesses} guesses remaining"
      user_guess = gets.chomp
      user_guess_result = user_guess.split('')
      correct_comparison = guess(guess: user_guess)
      if correct_comparison.is_a? String
        puts correct_comparison
      else
        show_letters(paint_scheme: correct_comparison, string_to_be_painted: user_guess_result)
        guesses -= 1
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

  def show_letters(paint_scheme:, string_to_be_painted:)
    paint_scheme.each_with_index do |letter, i|
      if letter == 'g'
        print(string_to_be_painted[i].colorize(:green))
      elsif letter == 'r'
        print(string_to_be_painted[i].colorize(:red))
      else
        print(string_to_be_painted[i])
      end
    end
  end
end
