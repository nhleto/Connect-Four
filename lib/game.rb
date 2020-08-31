# frozen_string_literal: true

require './board'

# holds player choices and game decisions
class Game
  attr_reader :player1, :player2, :p1symbol, :p2symbol
  def initialize
    @player1 = player1
    @p1symbol = p1symbol
    @p2symbol = p2symbol
    @player2 = player2
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
    p @p1symbol, @p2symbol
  end

  def start_game
    intro_text
  end

  def set_players
    puts "\nPlayer 1, please enter your name..."
    @player1 = set_name
    puts "\n\nPlayer 1, please enter your name..."
    @player2 = set_name
  end

  protected

  def set_name
    user_input = gets.chomp
    if valid_name?(user_input)
      puts "Nice to meet you, #{user_input}!"
    else
      puts 'Please enter a valid name (a-z)...'
      set_name
    end
  end

  def valid_name?(user_input)
    user_input.match?(/[a-zA-Z]/)
  end
end

c4 = Game.new
c4.intro_text
