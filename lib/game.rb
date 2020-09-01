# frozen_string_literal: true

require './board'
require './error'
require 'pry'
require 'colorize'

# holds player choices and game decisions
class Game
  Player = Struct.new(:name, :symbol)

  attr_accessor :board
  attr_reader :player1, :player2, :current_player, :error, :move
  def initialize
    @player1 = Player.new(:name, "\u2622")
    @player2 = Player.new(:name, "\u262E")
    @board = Board.new
    @error = Error.new
    @current_player = nil
    @move = move
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
    play_game
  end

  def set_players
    puts "\nWelcome Player 1! Please enter your name..."
    player1.name = set_name
    puts "\nWelcome Player 2! Please enter your name..."
    player2.name = set_name
    puts "\nWelcome, #{player1.name} and #{player2.name}!"
    sleep(2)
  end

  def play_game
    random_turn_picker
    loop do
      board.display_board
      puts "\n#{current_player.name}, Please make a guess"
      get_guess
      # error.column_full_error(move)
      board.place_piece(move, current_player.symbol)
      win_cons
      turn_switcher
    end
  end

    def win_cons
      if board.connect_four?
        "#{@current_player.name} is the WINNER!"
        # reset_answer
        # replay
      elsif cats_game?
        puts "\nCat's Game!"
        # replay
      end
    end

  private

  def cats_game?
    return false unless board.board_full?

    true
  end

  def random_turn_picker
    @current_player = [player1, player2].sample
    puts "\n#{current_player.name}, you were selected to go first. Good luck!"
    @current_player
  end

  def turn_switcher
    @current_player = @current_player == player1 ? player2 : player1
  end

  def get_guess(default_input = gets.chomp)
    @move = begin
              Integer(default_input)
            rescue StandardError
              false
            end
    return @move if @move && good_int?(move)

    error.guess_error
    get_guess
  end

  def good_int?(move)
    move.between?(0, 6)
  end

  def set_name
    user_input = gets.chomp
    loop do
      break if valid_name?(user_input)

      error.name_error
      user_input = gets.chomp
    end
    user_input
  end

  def valid_name?(user_input)
    user_input.match?(/[a-zA-Z]/)
  end
end

# c4 = Game.new
# c4.start_game
