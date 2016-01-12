class Piece
  attr_reader :color
  def initialize(board, color = nil)
    @board = board
    @color = color
  end

  def to_s
    "   "
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

  def blocked?(pos)
    return true unless pos[0].between?(0,7) && pos[1].between?(0,7)
    return true unless @board[pos].is_a?(Null)
    false
  end
end

class SlidingPiece < Piece
  def moves(start_pos, *directions)
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

  # def diagonal_moves(pos)
  #   moves = []
  #
  #   diag_directions = [[-1,1],[-1,-1],[1,1],[1,-1]]
  #   current_pos = pos
  #   diag_directions.each do |dir|
  #     while true
  #       if blocked?(current_pos)
  #         moves << current_pos if enemy_at?(current_pos)
  #         break
  #       else
  #         moves << current_pos
  #       end
  #       current_pos[0] += dir[0]
  #       current_pos[1] += dir[1]
  #     end
  #     current_pos = pos
  #   end
  #
  #   moves
  # end

  def move_rec_helper(pos, direction, enemy_last)
    return [] unless pos.all? { |c| c.between?(0,7) }
    p "Ally found at #{pos}" if ally?(@board[pos].color)
    return [] if ally?(@board[pos].color)
    return [pos] if enemy_last

    new_pos = [pos[0] + direction[0], pos[1] + direction[1]]
    [pos] + move_rec_helper(new_pos, direction,@board[pos].enemy?(@color))
  end

  def move_rec(pos, direction)
    move_rec_helper(pos, direction, false) - [pos]
  end
end

# super.moves([0,0], :horizontal, :vertical)

class SteppingPiece < Piece
end

module Horizontal
  def horizontal_moves
  end
end

module Vertical
end

module Diagonal
end
