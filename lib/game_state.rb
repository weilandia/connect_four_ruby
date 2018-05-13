require "pry"
require_relative "./game"
class GameState
  attr_accessor :current_player, :board, :moves, :rows, :columns

  def initialize(current_player, board, game)
    @current_player = current_player
    @board = board || Array.new(game.total_positions)
    @rows = game.rows
    @columns = game.columns
    @moves = []
  end

  def rank
    @rank ||= final_state_rank || intermediate_state_rank
  end

  def next_move
    moves.max { |a, b| a.rank <=> b.rank }
  end

  def final_state?
    winner || draw?
  end

  def draw?
    board.compact.size == 9 && winner.nil?
  end

  def winner
    @winner ||= game.winning_positions.map do |positions|
      winning_row?(positions) || nil
    end.compact.first
  end

  def next_player
    "R"
  end

  private


    def winning_row?(positions)
      player = board[positions[0]]
      if player &&
      player == board[positions[1]] &&
      player == board[positions[2]] &&
      player == board[positions[3]]
        player
      end
    end
end
a = GameState.new("B", nil, Game.new)
binding.pry
