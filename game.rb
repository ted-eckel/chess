require_relative 'display'
require_relative 'board'
require_relative "pieces/import_pieces"
require_relative 'errors'



class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @last_cursor_pos = nil
    @current_player = :white
  end

  def play_turn
    begin
      @display.render
      @display.message = ""
      # puts "#{@current_player}'s turn."
      cursor_pos = get_next_cursor_pos
      if @board[cursor_pos].enemy?(@current_player)
        raise WrongTurnError.new("It's #{@current_player}'s turn.")
      end

      if @last_cursor_pos
        @board.try_move(@last_cursor_pos,cursor_pos)
        @last_cursor_pos = nil
      else
        @last_cursor_pos = cursor_pos
      end


      @display.message = "Black in check" if @board.in_check?(:black)
      @display.message = "White in check" if @board.in_check?(:white)
      @display.message = "Black is checkmated" if @board.checkmate?(:black)
      @display.message = "White is checkmated" if @board.checkmate?(:white)

    rescue WrongTurnError => e
      @last_cursor_pos = nil
      @display.message = e.message
      retry
    rescue InvalidMoveError => e
      @last_cursor_pos = nil
      @display.message = e.message
      retry
    end
  end

  def get_next_cursor_pos
    @display.render
    puts "#{@current_player}'s turn."
    cursor_pos = @display.get_input
    until cursor_pos
      @display.render
      puts "#{@current_player}'s turn."
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
      end

  end
end

if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.play
end
