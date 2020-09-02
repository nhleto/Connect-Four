# frozen_string_literal: true

require './board'
require './error'
require 'colorize'

# holds player choices and game decisions
class Game
  Player = Struct.new(:name, :symbol)

  attr_accessor :board
  attr_reader :player1, :player2, :current_player, :error, :move, :answer
  def initialize
    @player1 = Player.new(:name, "\u2622")
    @player2 = Player.new(:name, "\u262E")
    @board = Board.new
    @error = Error.new
    @current_player = nil
    @move = move
    @answer = nil
  end

  def intro_text
    system('clear')
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
    puts 'Press ENTER when you are ready to play...'
    gets.chomp
  end

  def start_game
    set_players
    intro_text
    play_game
  end

  def set_players
    puts "\nPlayer 1, please enter your name...".green
    player1.name = set_name
    puts "\nPlayer 2, please enter your name...".green
    player2.name = set_name
    puts "\nWelcome, #{player1.name} and #{player2.name}!".green
    sleep(2)
  end
  
  def play_game
    system('clear')
    random_turn_picker
    loop do
      board.display_board
      puts "\n#{current_player.name}, Please make a guess"
      get_guess
      board.place_piece(move, current_player.symbol)
      win_cons
      turn_switcher
    end
  end

  def win_cons
    if board.connect_four?(current_player.symbol)
      puts "#{@current_player.name} is the WINNER!".green
      win_resets
    elsif cats_game?
      puts "\nCat's Game!".cyan
      replay
    end
  end

  private

  def win_resets
    board.display_board
    reset_answer
    sleep(1)
    replay
  end

  def reset_answer
    @answer = nil
  end

  def replay
    replay_text
    if @answer == 'Y'
      board.display_board
      board.clear_board
      system('clear')
      play_game
    else
      puts "\nCya"
      exit
    end
  end

  def replay_text
    puts 'Would you like to play again? Y/N'.cyan
    @answer = gets.chomp.to_s.upcase until @answer == 'Y' || @answer == 'N'
  end

  def cats_game?
    return false unless board.board_full?

    true
  end

  def random_turn_picker
    @current_player = [player1, player2].sample
    puts "\n#{current_player.name}, you were selected to go first. Good luck!".green
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
    return @move if @move && valid_move?(move)

    error.guess_error
    get_guess
  end

  def valid_move?(move)
    move.between?(1, 7) && board.column_not_full?(move)
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
    user_input.match?(/^[a-zA-Z0-9]+$/)
  end
end

# c4 = Game.new
# c4.start_game
