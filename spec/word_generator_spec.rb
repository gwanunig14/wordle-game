# frozen_string_literal: true

require_relative '../lib/word_generator'
require_relative '../lib/word_list'

describe 'Word Generator' do
  before do
    @word_generator = WordGenerator.new
  end

  it 'selects word from list of words' do
    word = @word_generator.select_word
    expect(word_list.include?(word)).to be(true)
  end
end
