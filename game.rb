require_relative 'display'
require_relative 'board'
require_relative "pieces/import_pieces"



class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @last_selected = nil
  end

  def play
    while true
      @display.render
      cursor_pos = @display.get_input
      if cursor_pos
        if @last_selected
          moves = @last_selected.moves
          @display.message = [moves, cursor_pos]
          @last_selected.move!(@last_cursor_pos,cursor_pos) if moves.include?(cursor_pos)
          @last_selected = nil
        else
          @display.message = cursor_pos
          @last_selected = @board[cursor_pos]
          @last_cursor_pos = cursor_pos
        end
      end
      @display.message = "Black in check" if @board.in_check?(:black)
      @display.message = "White in check" if @board.in_check?(:white)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.play
end
