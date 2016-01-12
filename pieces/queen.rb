class Queen < SlidingPiece
  def to_s
    return " ♕ " if @color == :white
    return " ♛ " if @color == :black
  end

  def moves
    super(:horizontal, :vertical, :diagonal)
  end

  def dup(new_board)
    Queen.new(new_board,@color)
  end
end
