# frozen_string_literal: true

require_relative '../lib/input_checker'

describe 'Input Checker' do
  before do
    @input_checker = InputChecker.new(correct_word: 'audio')
  end

  it 'does not accept words of more than five letters' do
    response = @input_checker.valid_guess(attempt: 'makers')
    expect(response).to be('Words must be five letters long.')
  end

  it 'does not accept words of less than five letters' do
    response = @input_checker.valid_guess(attempt: 'make')
    expect(response).to be('Words must be five letters long.')
  end

  it 'does not accept words not in word list' do
    response = @input_checker.valid_guess(attempt: 'asdfg')
    expect(response).to be('Invalid word')
  end

  it 'does not accept five letter word in list' do
    response = @input_checker.valid_guess(attempt: 'maker')
    expect(response).to be('maker')
  end

  it 'returns no letter matches' do
    response = @input_checker.guess(guess: 'stern')
    expect(response).to eq(%w[1 1 1 1 1])
    expect(@input_checker.alphabet_colors).to eq(%w[a b c d 1 f g h i j k l m 1
                                                    o p q 1 1 1 u v w x y z])
  end

  it 'returns some letter matches' do
    response = @input_checker.guess(guess: 'oodle')
    expect(response).to eq(%w[2 1 3 1 1])
    expect(@input_checker.alphabet_colors).to eq(%w[a b c 3 1 f g h i j k 1 m n
                                                    2 p q r s t u v w x y z])
  end

  it 'returns correct letter correct number of times' do
    response = @input_checker.guess(guess: 'apace')
    expect(response).to eq(%w[3 1 1 1 1])
    expect(@input_checker.alphabet_colors).to eq(%w[3 b 1 d 1 f g h i j k l m n
                                                    o 1 q r s t u v w x y z])
  end

  it 'returns word correct' do
    response = @input_checker.guess(guess: 'audio')
    expect(response).to eq(%w[3 3 3 3 3])
    expect(@input_checker.alphabet_colors).to eq(%w[3 b c 3 e f g h 3 j k l m n
                                                    3 p q r s t 3 v w x y z])
  end
end
