# frozen_string_literal: true

require './error'
require 'colorize'

# holding for game board and board error checking
class Board
  attr_accessor :game_board, :move, :error
  def initialize
    setup
  end

  def place_piece(move, symbol)
    move -= 1
    row = 5
    until game_board[row][move] == '.'
      return unless game_board[0][move] == '.'

      row -= 1
    end
    system('clear')
    game_board[row][move] = symbol
  end

  def display_board
    puts "\n\n"
    puts "\t 1 2 3 4 5 6 7".yellow
    game_board.each do |row|
      puts "\t|#{row.first}".red + "|#{row[1]}".red + "|#{row[2]}".red + "|#{row[3]}".red + "|#{row[4]}".red + "|#{row[5]}".red + "|#{row.last}|".red 
    end
    puts "\n\n"
  end

  def clear_board
    game_board.clear
    setup
  end

  def column_not_full?(move)
    move -= 1
    columns = game_board.transpose
    columns[move].any? { |cell| cell == '.' }
  end

  def board_full?
    game_board.all? { |row| row.all?(/[☢☮]/) }
  end

  def connect_four?(symbol)
    win_check_by_row?(game_board) ||
      win_check_by_column? ||
      win_check_by_diagonals?(symbol)
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

  def win_check_by_diagonals?(symbol)
    row = 0
    until row > 5
      col = 0
      until col > 6
        return true if diag_check?(row, col, symbol)

        col += 1
      end
      row += 1
    end
    false
  end

  def diag_check?(row, col, symbol)
    shift = []
    shift[0] =  1 if row.between?(0, 2)
    shift[0] = -1 if row.between?(3, 5)
    shift[1] =  1 if col.between?(0, 3)
    shift[1] = -1 if col.between?(3, 6)
    diagonal_equals?(row, col, symbol, shift)
  end

  def diagonal_equals?(row, col, symbol, shift)
    diagonal = []
    0.upto(3) { |n| diagonal << game_board[row + (shift[0] * n)][col + shift[1] * n] }
    diagonal.all?(symbol)
  end

  private

  def setup
    @game_board = Array.new(6) { Array.new(7, '.') }
  end
end

# ttt = Board.new
# ttt.display_board
