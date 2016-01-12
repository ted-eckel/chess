require_relative 'pieces/piece'
require_relative 'pieces/pawn'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(8) { Array.new(8){ Null.new(self)}}
    populate
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
    pieces << Rook.new(self,color)
    pieces << Knight.new(self,color)
    pieces << Bishop.new(self,color)
    pieces << Queen.new(self,color)
    pieces << King.new(self,color)
    pieces << Bishop.new(self,color)
    pieces << Knight.new(self,color)
    pieces << Rook.new(self,color)
    pieces
  end

  def populate_pawns
    @rows[1].length.times do |idx|
      @rows[1][idx] = Pawn.new(self,:black)
    end

    @rows[6].length.times do |idx|
      @rows[6][idx] = Pawn.new(self,:white)
    end
  end

  # def mark(pos)
  #   x, y = pos
  #   @rows[x][y] = Piece.new
  # end

  def find_piece(piece)
    @rows.each_with_index do |row,row_i|
      row.each_with_index do |board_piece,col_i|
        return [row_i,col_i] if board_piece == piece
      end
    end
    nil
  end

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
