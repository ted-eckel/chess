class Bishop < SlidingPiece
  def to_s
    return " ♗ " if @color == :white
    return " ♝ " if @color == :black
  end

  def moves
    super(:diagonal)
  end
end
