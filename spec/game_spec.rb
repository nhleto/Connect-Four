# frozen_string_literal: true

require './lib/game.rb'
require './lib/board.rb'

describe Game do
  subject(:game) { described_class.new }
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
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Az12', '12131', 'Henry')
        # Assert
        expect(game).to receive(:gets).thrice
        # Act
        game.set_players
      end
    end
  end
  describe '#game_loop' do
    context 'main loop for game' do
      it 'accepts player input for marker drop' do
        # Arrange
        move = 3
        allow(game).to receive(:puts)
        allow(game).to receive(:win_cons)
        allow(game).to receive(:place_piece)
        # Assert
        expect(game).to receive(:gets).and_return(move)

        # Act
        game.game_loop
      end
    end
  end
end
