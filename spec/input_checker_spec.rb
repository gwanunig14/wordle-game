# frozen_string_literal: true

require_relative '../lib/input_checker'

describe 'MainPage Checker' do
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
    expect(response).to eq(%w[x x x x x])
  end

  it 'returns some letter matches' do
    response = @input_checker.guess(guess: 'oodle')
    expect(response).to eq(%w[2 x 3 x x])
  end

  it 'returns correct letter correct number of times' do
    response = @input_checker.guess(guess: 'apace')
    expect(response).to eq(%w[3 x x x x])
  end

  it 'returns word correct' do
    response = @input_checker.guess(guess: 'audio')
    expect(response).to eq(%w[3 3 3 3 3])
  end
end
