require_relative 'pieces/piece'
require_relative 'pieces/pawn'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(8) { Array.new(8){ Null.new(self)}}
    populate
  end

  def move(start,end_pos)

  end

  def populate
    populate_pawns
    populate_black
    populate_white
  end

  def populate_white
    @rows[7] = populate_color(:white)
  end

  def populate_black
    @rows[0] = populate_color(:black)
  end

  def populate_color(color)
    pieces = []
    pieces << Rook.new(@board,color)
    pieces << Knight.new(@board,color)
    pieces << Bishop.new(@board,color)
    pieces << Queen.new(@board,color)
    pieces << King.new(@board,color)
    pieces << Bishop.new(@board,color)
    pieces << Knight.new(@board,color)
    pieces << Rook.new(@board,color)
    pieces
  end

  def populate_pawns
    @rows[1].length.times do |idx|
      @rows[1][idx] = Pawn.new(@board,:black)
    end

    @rows[6].length.times do |idx|
      @rows[6][idx] = Pawn.new(@board,:white)
    end
  end

  # def mark(pos)
  #   x, y = pos
  #   @rows[x][y] = Piece.new
  # end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 8) }
  end

  # def full?
  #   @rows.all? do |row|
  #     row.all? { |piece| piece.present? }
  #   end
  # end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
  end
end
