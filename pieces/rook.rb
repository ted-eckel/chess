class Rook < SlidingPiece
  def to_s
    return " ♖ " if @color == :white
    return " ♜ " if @color == :black
  end

  def moves(pos)
    p super.class
    # super.moves(pos, :horizontal, :vertical)
  end
end
