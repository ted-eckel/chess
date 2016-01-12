class Pawn < Piece
  def initialize(board,color,first_move = true)
    super(board,color)
    @first_move = first_move
  end

  def moves
    start_pos = @board.find_piece(self)
    possible_moves = []
    capture_moves = []
    if @color == :black
      possible_moves << [ 1,0]
      capture_moves.concat([[1, -1], [1, 1]])
      if @first_move == true
        possible_moves << [2,0]
      end
    elsif @color == :white
      possible_moves << [-1,0]
      capture_moves.concat([[-1, 1], [-1, -1]])
      if @first_move == true
        possible_moves << [-2,0]
      end
    end
    capture_moves = capture_moves.map { |dir| apply_dir(start_pos,dir)}
    possible_moves = possible_moves.map { |dir| apply_dir(start_pos,dir)}

    all_moves = capture_moves.select { |move| in_bounds?(move) && @board[move].enemy?(self.color) }
    all_moves += possible_moves.select { |move| in_bounds?(move) && @board[move].is_a?(Null) }
    all_moves
  end

  def move!(start,end_pos)
    @first_move = false
    super(start,end_pos)
  end

  def to_s
    return " ♙ " if @color == :white
    return " ♟ " if @color == :black
  end
end
