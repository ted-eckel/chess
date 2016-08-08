require "colorize"
require_relative "cursorable"

class Display
  attr_accessor :messages
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @messages = []
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j, piece)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j, piece)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif piece.highlighted?
      bg = :yellow
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :light_white

    end

    { background: bg, color: :black}
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    puts "White: " + @board.white_graveyard.join("")
    puts "Black: " + @board.black_graveyard.join("")
    side_grid = %w[1 2 3 4 5 6 7 8].to_a
    current_grid = build_grid
    # current_grid.reverse! if @board.reverse

    current_grid.each_with_index { |row,i| puts row.join + " " + side_grid[i] }
    bottom_grid = %w[a b c d e f g h].to_a
    puts " " + bottom_grid.join("  ")
    puts @messages
  end
end
