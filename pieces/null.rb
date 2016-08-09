class Null < Piece
  def initialize(board)
    super(board,nil)
  end

  def moves
    []
  end

  def dup(new_board)
    Null.new(new_board)
  end
end
