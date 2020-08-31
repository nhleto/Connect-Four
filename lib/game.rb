# frozen_string_literal: true

require './board'
require 'pry'
require 'colorize'

# holds player choices and game decisions
class Game
  attr_accessor :board, :move
  attr_reader :player1, :player2
  def initialize
    @player1 = player1
    @p1symbol = "\u2622"
    @player2 = player2
    @p2symbol = "\u262E"
    @board = Board.new
  end

  def intro_text
    puts <<~HEREDOC
                  Welcome to Connect-Four!
        
          In this game, only the STRONG survive
        
      The board is a standard, 6 x 7 Connect Four grid      
      Players will take turn dropping tokens into a slot,
      where the game piece fills the last available space.
        
      The goal of this game is to WIN. 
      This can be done by getting 4 game pieces in a row:

      Horizonally, vertically, OR diagonally.
        

      Keep an eye on your opponent, they may be building off your pieces
      
                  for a CONNECT-FOUR
        
        
        
    HEREDOC
  end

  def start_game
    intro_text
    set_players
    game_loop
  end

  def set_players
    player1_prompt
    @player1 = set_name
    player1_greeting
    player2_welcome
    @player2 = set_name
    player2_greeting
  end

  def player1_move
    loop do
      board.display_board
      puts "\nMake your move..."
      get_guess
      p board.column_not_full?(move)
      board.valid_move?(move) ? board.place_piece(move, 'X') : player1_move
      # player2_move
    end
  end

  def player2_move
    loop do
      board.display_board
      move = gets.chomp.to_i
      board.valid_move?(move) ? board.place_piece(move, 'O') : player2_move
      player1_move
    end
  end

  protected

  def get_guess(default_input = gets.chomp)
    @move = Integer(default_input) rescue false
    return @move if @move.between?(1, 7)

    puts 'Please enter an integer (0-6).'
    get_guess
  end

  def player1_prompt
    puts "\nPlayer 1, please enter your name..."
  end

  def player1_greeting
    puts "\nNice to meet you, #{@player1}! Your game-piece is #{@p1symbol}"
  end

  def player2_welcome
    puts "\n\nPlayer 2, please enter your name..."
  end

  def player2_greeting
    puts "\nNice to meet you, #{@player2}! Your game-piece is #{@p2symbol} "
  end

  def set_name
    user_input = gets.chomp
    loop do
      break if valid_name?(user_input)

      puts 'Please enter a valid name (a-z)...'
      user_input = gets.chomp
    end
    user_input
  end

  def valid_name?(user_input)
    user_input.match?(/[a-zA-Z]/)
  end
end

c4 = Game.new
c4.player1_move
