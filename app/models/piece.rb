class Piece
  def initialize(board:, row:, column:, player:, is_king:)
    @board = board
    @row = row
    @column = column
    @player = player
    @is_king = is_king
  end

  attr_reader :board, :player
  attr_accessor :row, :column, :is_king

  def at_position?(row, column)
    self.row == row && self.column == column
  end

  def next_moves
    moves = []

    # try diagonal left
    if (board.get_piece(next_row, column - 1).nil? rescue false)
      moves << { row: next_row, column: column - 1 }
    end

    # try diagonal right
    if (board.get_piece(next_row, column + 1).nil? rescue false)
      moves << { row: next_row, column: column + 1 }
    end

    # TODO: king moves

    moves
  end

  def to_s
    "#{player}#{'k' if is_king}"
  end

  private

    def direction
      player == 'x' ? -1 : 1
    end

    def next_row(skip_rows = 0)
      row + (skip_rows + 1) * direction
    end
end
