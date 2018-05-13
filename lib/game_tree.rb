require "pry"
require_relative "./game_state"

class GameTree
  def generate
    initial_game_state = GameState.new("B", Array.new(25))

    generate_moves(initial_game_state)
    initial_game_state
  end

  def generate_moves(game_state)
    [21, 22, 23, 24].each do |position|
      player_at_position = game_state.board[position]

      until player_at_position.nil? || position < 5
        position -= 5
        player_at_position = game_state.board[position]
      end

      unless player_at_position
        next_board = game_state.board.dup
        next_board[position] = game_state.current_player

        p next_board

        next_game_state = GameState.new(game_state.next_player, next_board)

        game_state.moves << next_game_state
        generate_moves(next_game_state)
      end
    end
  end
end

a = GameTree.new
a.generate
binding.pry
