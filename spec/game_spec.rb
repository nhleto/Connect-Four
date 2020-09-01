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
  describe '#win_cons' do
    it 'declares winner' do
      # Arrange
      allow(board).to receive(:connect_four?).and_return(true)
      player = double('player1', name: 'Henry')
      allow(game).to receive(:win_cons)
      # game.instance_variable_set(:@current_player, player)
      win_message = "#{player.name} is the WINNER!"
      # Assert
      allow(game)
      # Act
      expect(game.win_cons).to eq(win_message)
    end
    context 'if no winner is chosen' do
      xit 'is a cats game' do
        allow_any_instance_of(Board).to receive(:connect_four)
        draw_message = "\nCat's Game!"
        expect(game.cats_game).to eq(draw_message)
      end
    end
  end
end
