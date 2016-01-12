class King < SteppingPiece
  def to_s
    return " ♔ " if @color == :white
    return " ♚ " if @color == :black
  end
end
