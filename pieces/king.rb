class King < Piece
  def to_s
    return " ♔ " if @color == :white
    return " ♚ " if @color == :black
  end

  def moves
    start_pos = @board.find_piece(self)
    directions = [1,-1,1,-1,0].permutation(2).to_a.uniq
    positions = directions.map { |dir| apply_dir(start_pos,dir)}
    positions.select do |position|
      in_bounds?(position) && (@board[position].is_a?(Null) || @board[position].enemy?(@color))
    end
  end

  def dup(new_board)
    King.new(new_board,@color)
  end
end
