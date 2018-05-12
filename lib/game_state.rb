class GameState
  attr_accessor :current_player, :board, :moves

  def initialize(current_player, board)
    @current_player = current_player
    @board = board
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
    @winner ||= winning_positions.map do |positions|
      winning_row?(positions) || nil
    end.compact.first
  end

  private

    def winning_positions
      [
        # Horizontal wins
        (0..3).to_a,
        (1..4).to_a,
        (5..8).to_a,
        (6..9).to_a,
        (10..13).to_a,
        (11..14).to_a,
        (15..18).to_a,
        (16..19).to_a,
        (20..23).to_a,
        (21..24).to_a,

        # Vertical wins
        (0..15).step(5).to_a,
        (1..16).step(5).to_a,
        (2..17).step(5).to_a,
        (3..18).step(5).to_a,
        (4..19).step(5).to_a,
        (5..20).step(5).to_a,
        (6..21).step(5).to_a,
        (7..22).step(5).to_a,
        (8..23).step(5).to_a,
        (9..24).step(5).to_a,

        # Diagonal wins
        (3..15).step(4).to_a,
        (4..16).step(4).to_a,
        (8..20).step(4).to_a,
        (9..21).step(4).to_a,
      ]
    end

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
