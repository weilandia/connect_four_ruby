class Game
  def render_board
    output = "#{"-" * 33}\n"
    0.upto(41) do |position|
      if position <= 9
        output << " #{position}  "
      else
        output << " #{position} "
      end

      if (position + 1) % 7 == 0
        output << "\n#{"-" * 33}\n"
      else
        output << "|"
      end
    end
    puts output
  end

  private
end

a = Game.new
a.render_board
