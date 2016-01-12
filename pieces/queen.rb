class Queen < SlidingPiece
  def to_s
    return " ♕ " if @color == :white
    return " ♛ " if @color == :black
  end

  def moves(pos)
    super(pos, :horizontal, :vertical, :diagonal)
  end
end
