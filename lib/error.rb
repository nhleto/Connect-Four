# frozen_string_literal: true

require './board'
require 'colorize'

# responsible for handling error messages
class Error
  attr_reader :board, :move
  def initialize
    @board = Board.new
  end

  def guess_error
    puts 'Please enter a valid move.'.red
  end

  def name_error
    puts 'Please enter a valid name (a-z)...'.red
  end
end
