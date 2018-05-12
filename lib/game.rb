class Game
  def render_board
    output = "#{"-" * 23}\n"
    0.upto(24) do |position|
      if position <= 4
        output << " #{position}  "
      else
        output << "    "
      end

      if position % 5 == 4
        output << "\n#{"-" * 23}\n"
      else
        output << "|"
      end
    end
    puts output
  end

  private
end

Game.new.render_board
