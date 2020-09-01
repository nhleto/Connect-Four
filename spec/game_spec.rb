# frozen_string_literal: true

require './lib/game.rb'
require './lib/board.rb'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:error) { instance_double(Error) }

  describe '#set_players' do
    context 'when the game begins' do
      it 'prompts player 1 and 2 to choose enter names' do
        # Arrange
        player1 = 'Henry'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(player1)
        allow(game).to receive(:set_name)
        # Act
        game.set_players
        # Assert

        expect(player1).to be('Henry')
      end
    end
    context 'when incorrect input is entered' do
      it 'rejects with error message 3 times' do
        # Arrange
        allow_any_instance_of(Error).to receive(:puts)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Az12', '12131', 'Henry')
        # Assert
        expect(game).to receive(:gets).thrice
        # Act
        game.set_players
      end
    end
  end
  describe '#play_game' do
    context 'in main loop of game' do
      it 'marks board with player input' do
        # Arrange
        move = '3'
        allow(game).to receive(:turn_switcher)
        allow(game).to receive(:gets).and_return(move)
        allow(game).to receive(:gets_guess)
        allow(game).to receive(:puts)
        allow(game).to receive(:win_cons)
        allow_any_instance_of(Board).to receive(:column_not_full?)
        allow_any_instance_of(Board).to receive(:display_board)
        # Assert
        expect(board).to receive(:place_piece).with(move, 'X')
        # Act
        game.play_game
      end
    end
  end
end
