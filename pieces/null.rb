class Null < Piece
  def initialize(board)
    super(board,nil)
  end

  def moves
    raise "Can't move from here"
  end
end
