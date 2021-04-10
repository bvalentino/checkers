class Board
  def initialize(size:, state:, empty_space: '_')
    @size = size
    @pieces = []

    state.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
      next if value == empty_space

      @pieces << Piece.new(
        board: self,
        row: row_index,
        column: column_index,
        player: value[0],
        is_king: value.end_with?('k')
      )
      end
    end
  end

  attr_reader :pieces, :size

  def get_piece(row, column)
    raise 'Invalid position' unless valid_position?(row, column)

    pieces.find { |piece| piece.at_position? row, column }
  end

  def next_moves_of_player(player)
    player_pieces = pieces.select { |piece| piece.player == player }

    player_pieces.collect(&:next_moves).flatten.compact
  end

  private

  def valid_position?(row, column)
    row.between?(0, size - 1) && column.between?(0, size - 1)
  end
end
