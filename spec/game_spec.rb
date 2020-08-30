# frozen_string_literal: true

require './lib/game.rb'

describe Game do
  subject(:game) { described_class.new(player1, player2) }
  let(:player1) { double('') }
  context 'at start of game' do
    it 'initializes player1 and player2' do
      expect(player1).to be('Henry')
    end
  end
end
