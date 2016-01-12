class Bishop < SlidingPiece
  def to_s
    return " ♗ " if @color == :white
    return " ♝ " if @color == :black
  end

  def moves
    super(:diagonal)
  end

  def dup(new_board)
    Bishop.new(new_board,@color)
  end
end
