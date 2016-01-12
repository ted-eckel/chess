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
        @last_selected = @board[cursor_pos]
        moves = @last_selected.moves(cursor_pos)
        p moves
      end
    end
  end
end
