# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }
  describe '#game_board' do
    context 'when game begins' do
      it 'creates a connect four board' do
        expect(board.game_board).to eq([['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', '.', '.', '.', '.', '.', '.'],
                                        ['.', '.', '.', '.', '.', '.', '.']])
      end
    end
  end
  describe '#place_piece' do
    context 'when user enters input' do
      it 'slides to bottom of last available space of array' do
        move = 3
        board.place_piece(move, 'X')
        expect(board.game_board[5][move - 1]).to eq('X')
      end
    end
  end
  describe '#win_check?' do
    context 'if there is a 4 in a row on the board' do
      it 'returns true' do
        expect(board.win_check_by_row?).to be(true)
      end
    end
  end
end
