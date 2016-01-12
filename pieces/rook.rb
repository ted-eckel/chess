class Rook < SlidingPiece
  def to_s
    return " ♖ " if @color == :white
    return " ♜ " if @color == :black
  end

  def moves
    super(:horizontal, :vertical)
  end
end
