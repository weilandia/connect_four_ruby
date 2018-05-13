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

  def next_player
    "R"
  end

  private

    def winning_positions
      [
        horizontal_wins,
        vertical_wins,
        diagonal_wins
      ].flatten(1)
    end

    def horizontal_wins
      0.step(35, 7).map do |row_start|
        row_start.upto(row_start + 3).map do |n|
          (n..n + 3).to_a
        end
      end.flatten(1)
    end

    def vertical_wins
      0.upto(20).map { |n| (n..n + 21).step(7).to_a }
    end

    def diagonal_wins
      3.upto(20).map { |n| (n..n + 19).step(6).to_a }
      3.upto(17).map { |n| (n..n + 25).step(8).to_a }
      []
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
