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
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_white
    else
      bg = :light_black
    end
    { background: bg, color: :black}
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    puts @messages
  end
end
