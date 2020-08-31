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
  end
end
