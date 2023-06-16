# frozen_string_literal: true

require_relative './word_list'
# WordGenerator
class WordGenerator
  def select_word
    words = word_list
    word_index = rand(0...words.length)
    words[word_index]
  end
end
