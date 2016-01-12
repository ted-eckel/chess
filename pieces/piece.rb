require 'byebug'

class Piece
  attr_reader :color
  def initialize(board, color = nil)
    @board = board
    @color = color
  end

  def to_s
    "   "
  end

  def move!(start,end_pos)
    p start
    p end_pos
    @board[start] = Null.new(@board)
    @board[end_pos] = self
  end

  def enemy_at?(pos)
    return true unless @board[pos].is_a?(Null) || @board[pos].color == @color
  end

  def ally?(color)
    @color == color
  end

  def enemy?(color)
    return true if @color == :black && color == :white
    return true if @color == :white && color == :black
    false
  end

  def in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def apply_dir(pos,dir)
    [pos[0] + dir[0], pos[1] + dir[1]]
  end
end

class SlidingPiece < Piece
  def moves(*directions)
    start_pos = @board.find_piece(self)
    # debugger
    direction_hash = {
      diagonal: [[-1,1],[-1,-1],[1,1],[1,-1]],
      vertical: [[-1, 0], [1, 0]],
      horizontal: [[0, 1], [0, -1]]
    }
    possible_moves = []

    directions.each do |direction|
      possible_moves += direction_hash[direction]
    end

    possible_moves.map do |move|
      move_rec(start_pos, move)
    end.flatten(1)
  end

  def move_rec_helper(pos, direction)
    return [] unless in_bounds?(pos)
    p "Ally found at #{pos}" if ally?(@board[pos].color)
    return [] if ally?(@board[pos].color)
    return [pos] if enemy?(@board[pos].color)

    # new_pos = [pos[0] + direction[0], pos[1] + direction[1]]
    new_pos = apply_dir(pos,direction)
    [pos] + move_rec_helper(new_pos, direction)
  end

  def move_rec(pos, direction)
    move_rec_helper(apply_dir(pos, direction), direction)
  end
end