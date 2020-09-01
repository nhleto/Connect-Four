# frozen_string_literal: true

require './board'
# require './game'

# responsible for handling error messages
class Error
  attr_reader :board, :move
  def initialize
    @board = Board.new
  end

  # def column_full_error(move)
  #   p 'hi'
  #   if board.column_not_full?(move) == false
  #     puts 'nooooooooo'
  #   end
  # end

  def guess_error
    puts 'Please enter an integer (0-6)'
  end

  def name_error
    puts 'Please enter a valid name (a-z)...'
  end
end
