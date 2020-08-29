# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }
  describe '#game_board' do
    context 'when game begins' do
      it 'creates a connect four board' do
        expect(board.game_board).to eq([%w[. . . . . . .],
                                        %w[. . . . . . .],
                                        %w[. . . . . . .],
                                        %w[. . . . . . .],
                                        %w[. . . . . . .],
                                        %w[. . . . . . .]])
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
    context 'if there is a 4 in 1 array on the board' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X X X X . . .]]
      end
      it 'returns true' do
        expect(board.win_check_by_row?(board.game_board)).to be(true)
      end
    end
    context 'if there is not 4 in a row in 1 array' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X X . X . . .]]
      end
      it 'returns false' do
        expect(board.win_check_by_row?(board.game_board)).to be(false)
      end
    end
  end
  describe '#win_check_by_column?' do
    context 'if there is 4 in a row in a column' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X . . . . . .],
                            %w[X . . . . . .],
                            %w[X . . . . . .],
                            %w[X X . X . . .]]
      end
      it 'returns true' do
        expect(board.win_check_by_column?).to eq(true)
      end
    end
    context 'if no columns have 4 in a row' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X . . . . . .],
                            %w[. . . . . . .],
                            %w[X . . . . . .],
                            %w[X X . X . . .]]
      end
      it 'returns false' do
        expect(board.win_check_by_column?).to be(false)
      end
    end
  end
  describe '#win_check_by_diagonal?' do
    context 'if there are 4 in a row diagonal' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . X . . .],
                            %w[X . X X X . .],
                            %w[. X . X X . .],
                            %w[X . X . . X .],
                            %w[. X . X . . X]]
      end
      it 'returns true' do
        expect(board.win_check_by_left_diagonals?).to be(true)
      end
    end
    # context 'when there are not four in a row diagonal' do
    #   before do
    #     board.game_board = [%w[. . . . . . .],
    #                         %w[. . . . . . .],
    #                         %w[X . . . X . .],
    #                         %w[. . . X . . .],
    #                         %w[X . X . . . .],
    #                         %w[X X . X . . .]]
    #   end
    #   it 'returns false' do
    #     expect(board.win_check_by_diagonal?).to be(false)
    #   end
    # end
  end
end
