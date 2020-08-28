# frozen_string_literal: true

# holding for game board and board error checking
class Board
  attr_accessor :game_board, :move
  def initialize
    @game_board = Array.new(6) { Array.new(7) { '.' } }
    @move = move
  end

  def game
    loop do
      puts 'YOOOOOOOOO'
      move = gets.chomp.to_i
      place_piece(move, 'X')
      display_board
      win_check_by_row?
      hi
    end
  end

  def place_piece(move, symbol)
    row = game_board.size - 1
    column = move - 1
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
    puts '1 2 3 4 5 6 7'.center(80)
    game_board.each do |row|
      puts row.join(' ').center(80)
    end
  end

  def hi
    puts(win_check_by_row? == true ? 'nice' : 'fuck')
  end

  def win_check_by_row?
    game_board.each do |row|
      output = row.each_cons(4).find { |index| index.uniq.size == 1 && index.first != '.' }
      return true unless output.nil?
    end
    false
  end

  # def win_check_by_column?
  #   win_check_by_row?(game_board.transpose)
  # end
end

ttt = Board.new
ttt.game
