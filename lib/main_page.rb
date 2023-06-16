# frozen_string_literal: true

require 'colorize'
require 'pry'

require_relative './word_list'
require_relative './input_checker'
require_relative './word_generator'

# MainPage
class MainPage
  def initialize
    @correct_word = WordGenerator.new.select_word
    @input_checker = InputChecker.new(correct_word: @correct_word)
  end

  def play_game
    correct_comparison = []
    remaining_guesses = 6

    puts 'Guess a five letter word'

    until correct_comparison == %w[g g g g g] || guesses.zero?
      puts " #{remaining_guesses} guesses remaining"
      remaining_guesses = process_guess(remaining_guesses)
    end

    end_game(correct_comparison)
  end

  def process_guess(remaining_guesses)
    user_guess = gets.chomp
    user_guess_result = user_guess.split('')
    correct_comparison = guess(guess: user_guess)
    if correct_comparison.is_a? String
      puts correct_comparison
    else
      post_guess_print_output(text_colors: correct_comparison, text: user_guess_result)
      remaining_guesses -= 1
    end
    remaining_guesses
  end

  def guess(guess:)
    assessment = @input_checker.valid_guess(attempt: guess)
    return assessment unless assessment == guess

    @input_checker.guess(guess: guess)
  end

  def post_guess_print_out(text_colors:, text:)
    show_letters(paint_scheme: text_colors, string_to_be_painted: text)
    puts
    show_letters(paint_scheme: @input_checker.alphabet_colors,
                 string_to_be_painted: %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z])
  end

  def show_letters(paint_scheme:, string_to_be_painted:)
    paint_scheme.each_with_index do |letter, i|
      case letter
      when '3'
        print(string_to_be_painted[i].colorize(:green))
      when '2'
        print(string_to_be_painted[i].colorize(:red))
      when '1'
        print(string_to_be_painted[i].colorize(:cyan))
      else
        print(string_to_be_painted[i])
      end
    end
  end

  def end_game(end_state)
    if end_state == %w[3 3 3 3 3]
      'Congrats'
    else
      'Too bad. Try a new game.'
    end
  end
end
