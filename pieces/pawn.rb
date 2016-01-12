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
      possible_moves << [1,0]
      capture_moves.concat([[1, -1], [1, 1]])
      possible_moves << [2,0] if @first_move == true
    elsif @color == :white
      possible_moves << [-1,0]
      capture_moves.concat([[-1, 1], [-1, -1]])
      possible_moves << [-2,0] if @first_move == true
    end
    capture_moves.map! { |dir| apply_dir(start_pos,dir)}
    capture_moves.select! {|move| in_bounds?(move)}
    possible_moves.map! { |dir| apply_dir(start_pos,dir)}
    possible_moves.select! {|move| in_bounds?(move)}

    all_moves = capture_moves.select { |move| @board[move].enemy?(self.color) }
    all_moves += possible_moves.select { |move| @board[move].is_a?(Null) }
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

  def dup(new_board)
    Pawn.new(new_board,@color)
  end
end
