class Rook < SlidingPiece
  def to_s
    return " ♖ " if @color == :white
    return " ♜ " if @color == :black
  end

  def moves
    super(:horizontal, :vertical)
  end

  def dup(new_board)
    Rook.new(new_board,@color)
  end
end
