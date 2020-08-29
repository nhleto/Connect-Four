# frozen_string_literal: true

require 'pry'

# holding for game board and board error checking
class Board
  attr_accessor :game_board, :move
  attr_reader :diags, :rotated
  def initialize
    @game_board = Array.new(6) { Array.new(7) { '.' } }
    @move = move
    @diags = diags
  end

  def place_piece(move, symbol)
    row = game_board.size - 1
    column = move.to_i - 1
    while (game_board.size - row) <= game_board.size
      if game_board[row][column] == '.'
        game_board[row][column] = symbol
        row = -1
      else
        row -= 1
      end
    end
  end

  def display_board
    puts "\n\n"
    puts '1  2  3  4  5  6  7'.center(80)
    game_board.each do |row|
      puts row.join('  ').center(80)
    end
    puts "\n\n"
  end

  def win_check_by_row?(board)
    board.each do |row|
      output = row.each_cons(4).find { |index| index.uniq.size == 1 && index.first != '.' }
      return true unless output.nil?
    end
    false
  end

  def win_check_by_column?
    grid = game_board.transpose
    win_check_by_row?(grid)
  end

  def win_check_by_left_diagonals?(symbol = 'X')
    6.downto(3) do |j|
      3.downto(2) do |i|
        if game_board[i][j] == symbol && game_board[i + 1][j + 1] == symbol && game_board[i + 2][j + 2] == symbol && game_board[i + 3][j + 3] == symbol
    
        end
      end
    end
    false
  end
end

# ttt = Board.new
# # ttt.create_diags
# # ttt.win_check_by_diagonal?
# ttt. display_board
