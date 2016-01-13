require_relative 'display'
require_relative 'board'
require_relative "pieces/import_pieces"
require_relative 'errors'



class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @current_player = :white
  end

  def play_turn
    begin
      @display.render
      @display.messages = "Black is checked." if @board.in_check?(:black)
      @display.messages = "White is checked." if @board.in_check?(:white)
      @display.messages = "Black is checkmated." if @board.checkmate?(:black)
      @display.messages = "White is checkmated." if @board.checkmate?(:white)

      # puts "#{@current_player}'s turn."
      cursor_start = get_next_cursor_pos
      current_piece = @board[cursor_start]
      if current_piece.enemy?(@current_player)
        raise WrongTurnError.new("It's #{@current_player}'s turn.")
      end
      if current_piece.is_a?(Null)
        raise InvalidMoveError.new("Can't move from here.")
      end

      cursor_end = get_next_cursor_pos
      @board.try_move(cursor_start,cursor_end)


      @display.messages << "Black in check" if @board.in_check?(:black)
      @display.messages << "White in check" if @board.in_check?(:white)
      @display.messages << "Black is checkmated" if @board.checkmate?(:black)
      @display.messages << "White is checkmated" if @board.checkmate?(:white)

    rescue WrongTurnError => e
      @display.messages << e.message
      retry
    rescue InvalidMoveError => e
      @display.messages << e.message
      retry
    end
  end

  def get_next_cursor_pos
    @display.render
    puts "#{@current_player.to_s.capitalize}'s turn."
    cursor_pos = @display.get_input
    until cursor_pos
      @display.render
      puts "#{@current_player.to_s.capitalize}'s turn."
      cursor_pos = @display.get_input
    end
    cursor_pos
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def play
      while true
        play_turn
        switch_player
        @display.messages = []
      end

  end
end

if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.play
end
