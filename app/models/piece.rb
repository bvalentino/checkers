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

  def next_moves(vertical: nil, horizontal: nil)
    if vertical.nil? && horizontal.nil?
      return HORIZONTALS.product(VERTICALS).collect do |direction|
        next_moves(vertical: direction[0], horizontal: direction[1])
      end.flatten
    end

    moves = []
    return moves unless can_move_vertically?(vertical)

    row_delta = vertical == :bottom ? 1 : -1
    column_delta = horizontal == :right ? 1 : -1

    jumps = 0
    while jumps < max_jumps
      jumps += 1

      begin
        target_row = row + jumps * row_delta
        target_column = column + jumps * column_delta
        piece_at_position = board.get_piece(target_row, target_column)

        if piece_at_position.nil?
          moves << { row: target_row, column: target_column }
        elsif piece_at_position.player != player
          # we can overtake this piece if the next position is free
          target_row = row + (jumps + 1) * row_delta
          target_column = column + (jumps + 1) * column_delta
          piece_at_next_position = board.get_piece(target_row, target_column)

          if piece_at_next_position.nil?
            moves << { row: target_row, column: target_column }
          end

          break
        else
          break # we can't overtake our own pieces
        end
      rescue
        # position is out of bounds
        # nothing to do here
      end
    end

    moves
  end

  def to_s
    "#{player}#{'k' if is_king}"
  end

  private
    HORIZONTALS = %i[top bottom]
    VERTICALS = %i[left right]

    def can_move_vertically?(direction)
      return true if is_king
      return :top if player == 'x'

      :bottom
    end

    def max_jumps
      return board.size - 1 if is_king

      1
    end
end
