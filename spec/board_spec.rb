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
        board.place_piece(move, '☢')
        expect(board.game_board[5][move]).to eq('☢')
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
                            %w[☢ ☢ ☢ ☢ . . .]]
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
                            %w[☢ ☢ . ☢ . . .]]
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
                            %w[☢ . . . . . .],
                            %w[☢ . . . . . .],
                            %w[☢ . . . . . .],
                            %w[☢ ☢ . ☢ . . .]]
      end
      it 'returns true' do
        expect(board.win_check_by_column?).to eq(true)
      end
    end
    context 'if no columns have 4 in a row' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[☢ . . . . . .],
                            %w[. . . . . . .],
                            %w[☢ . . . . . .],
                            %w[☢ ☢ . ☢ . . .]]
      end
      it 'returns false' do
        expect(board.win_check_by_column?).to be(false)
      end
    end
  end
  describe '#win_check_by_diagonal?' do
    context 'if there are 4 in a row diagonal' do
      before do
        board.game_board = [%w[. . . . . . ☢],
                            %w[. . . . . ☢ O],
                            %w[. . . . ☢ O O],
                            %w[. . . ☢ O O O],
                            %w[. . O O O O O],
                            %w[. O O O O O O]]
      end
      it 'returns true' do
        symbol = '☢'
        expect(board.win_check_by_diagonals?(symbol)).to be(true)
      end
    end
    context 'when there are not four in a row diagonal' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X . . . X . .],
                            %w[. . . X . . .],
                            %w[X . O . . . .],
                            %w[X X . X . . .]]
      end
      it 'returns false' do
        symbol = '☢'
        expect(board.win_check_by_diagonals?(symbol)).to be(false)
      end
    end
  end
  describe '#board_full?' do
    context 'if game_board is not full' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[☢ . . . ☢ . .],
                            %w[. . . ☢ . . .],
                            %w[☢ . O . . . .],
                            %w[☢ ☢ . ☢ . . .]]
      end
      it 'returns false' do
        expect(board.board_full?).to be(false)
      end
    end
    context 'if game_board is full with no winner' do
      before do
        board.game_board = [%w[☢ ☢ ☢ ☢ ☢ ☢ ☢],
                            %w[☢ ☢ ☢ ☢ ☢ ☢ ☢],
                            %w[☢ ☢ ☢ ☢ ☢ ☢ ☢],
                            %w[☢ ☢ ☢ ☢ ☢ ☢ ☢],
                            %w[☢ ☢ ☢ ☢ ☢ ☢ ☢],
                            %w[☢ ☢ ☢ ☢ ☢ ☢ ☢]]
      end
      it 'returns true' do
        expect(board.board_full?).to be(true)
      end
    end
  end
  describe '#column_full?' do
    context 'if user input fits in column' do
      before do
        board.game_board = [%w[X . X X X X X],
                            %w[X X X X X X X],
                            %w[X X X X X X X],
                            %w[X X O X X O X],
                            %w[X X O X X O X],
                            %w[X X O X X X X]]
      end
      it 'returns true' do
        move = 1
        expect(board.column_not_full?(move)).to be(true)
      end
    end
  end
  describe '#connect_four?' do
    context 'if there is horizontal/vertical/diag win' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[☢ . . . ☢ . .],
                            %w[. . . ☢ . . .],
                            %w[☢ . ☢ . . . .],
                            %w[☢ ☢ . ☢ . . .]]
      end
      it 'returns true' do
        symbol = '☢'
        expect(board.connect_four?(symbol)).to be(true)
      end
    end
    context 'if there is horizontal/vertical/diag win' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[X . . . X . .],
                            %w[. . . X . . .],
                            %w[X . O . . . .],
                            %w[☢ ☢ ☢ ☢ . . .]]
      end
      it 'returns true' do
        symbol = '☢'
        expect(board.connect_four?(symbol)).to be(true)
      end
    end
    context 'if there is horizontal/vertical/diag win' do
      before do
        board.game_board = [%w[. . . . . . .],
                            %w[. . . . . . .],
                            %w[☢ . . . X . .],
                            %w[☢ . . X . . .],
                            %w[☢ . O . . . .],
                            %w[☢ X . X . . .]]
      end
      it 'returns true' do
        symbol = '☢'
        expect(board.connect_four?(symbol)).to be(true)
      end
    end
  end
  describe '#clear_board' do
    context 'when game ends' do
      it 'creates a fresh array' do
        new_board = Array.new(6) { Array.new(7, '.') }
        expect(board.clear_board).to eq(new_board)
      end
    end
  end
end
