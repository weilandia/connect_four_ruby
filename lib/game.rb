require "pry"
class Game
  attr_reader :rows, :columns

  def initialize(rows: 6, columns: 7)
    @rows = rows
    @columns = columns
  end

  def winning_positions
    [
      horizontal_wins,
      vertical_wins,
      diagonal_wins
    ].flatten(1)
  end

  def render_board
    output = "#{"-" * (columns * 5 - 2)}\n"
    0.upto(rows * columns - 1) do |position|
      if position <= 9
        output << " #{position}  "
      else
        output << " #{position} "
      end

      if (position + 1) % columns == 0
        output << "\n#{"-" * (columns * 5 - 2)}\n"
      else
        output << "|"
      end
    end
    puts output
  end

  private

    def total_positions
      rows * columns
    end

    def last_index
      total_positions - 1
    end

    def horizontal_wins
      row_starts.map do |row_start|
        row_start.upto(row_start + (columns - 4)).map do |n|
          (n..n + 3).to_a
        end
      end.flatten(1)
    end

    def vertical_wins
      0.upto(last_index_for_vertical_win).map { |n| (n..n + (3 * columns)).step(columns).to_a }
    end

    def diagonal_wins
      # TODO: 
    end

    def row_starts
      0.step(last_index, columns)
    end

    def last_index_for_vertical_win
      ((rows - 3) * columns) - 1
    end
end

a = Game.new
a.render_board
binding.pry
