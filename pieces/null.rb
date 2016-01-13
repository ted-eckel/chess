class Null < Piece
  def initialize(board)
    super(board,nil)
  end

  def moves
    []
    # raise InvalidMoveError.new("Can't move from here.")
  end

  def dup(new_board)
    Null.new(new_board)
  end
end
