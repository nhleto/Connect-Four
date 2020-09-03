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
        allow_any_instance_of(Board).to receive(:setup)
        allow_any_instance_of(Error).to receive(:puts)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Az12__', '#12$s131', 'Henry')
        # Assert
        expect(game).to receive(:gets).exactly(4).times
        # Act
        game.set_players
      end
    end
  end
  describe 'initialization' do
    context 'when game begins' do
      it 'creates a new player struct' do
        # Assert
        expect(game.player1.symbol).to be('☢')
      end
    end
    context 'when game begins' do
      it 'creates a new player struct' do
        # Assert
        expect(game.player2.symbol).to be('☮')
      end
    end
    context 'when game begins' do
      it 'creates a new board instance' do
        # Assert
        expect(game.board).to be_instance_of(Board)
      end
    end
  end
end
