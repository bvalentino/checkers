class GameController < ApplicationController
  before_action :set_state
  before_action :set_board
  before_action :set_turn
  before_action :set_next_moves

  def index
  end

  private
    DEFAULT_SIZE = 8

    def set_state
      @state = params[:state].presence || default_state
    end

    def set_board
      @board = Board.new(
        state: @state.split.collect { |row| row.split(',') },
        size: (params[:board_size] || DEFAULT_SIZE).to_i
      )
    end

    def set_turn
      @turn = (params[:turn] || 'o').downcase
    end

    def set_next_moves
      @next_moves = @board.next_moves_of_player(@turn)
    end

    def default_state
      File.read(Rails.root.join('default_state.txt')).strip
    end
end
