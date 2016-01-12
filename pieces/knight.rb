class Knight < Piece
  def to_s
    return " ♘ " if @color == :white
    return " ♞ "  if @color == :black
  end

  def moves
    start_pos = @board.find_piece(self)
    positions = []
    raw_directions = [[1, 2],[-1, -2], [1, -2], [-1, 2]]
    raw_directions.each do |dir|
      positions << apply_dir(start_pos, dir)
      positions << apply_dir(start_pos, dir.reverse)
    end
    positions.select do |position|
      in_bounds?(position) && (@board[position].is_a?(Null) || @board[position].enemy?(@color))
    end
  end

  def dup(new_board)
    Knight.new(new_board,@color)
  end
end
