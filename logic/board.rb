require_relative '../pieces/piece'
require_relative '../pieces/pawn'

class Board
  attr_accessor  :reverse
  attr_reader :rows, :white_graveyard, :black_graveyard

  def initialize(do_populate = true)
    @rows = Array.new(8) { Array.new(8){ Null.new(self)}}
    @white_graveyard = []
    @black_graveyard = []
    @reverse = false
    populate if do_populate
  end

  def populate
    populate_pawns
    populate_black
    populate_white
  end

  def populate_white
    @rows[7] = populate_color(:white)
  end

  def populate_black
    @rows[0] = populate_color(:black)
  end

  def populate_color(color)
    pieces = []
    pieces << Rook.new(self,color)
    pieces << Knight.new(self,color)
    pieces << Bishop.new(self,color)
    pieces << Queen.new(self,color)
    pieces << King.new(self,color)
    pieces << Bishop.new(self,color)
    pieces << Knight.new(self,color)
    pieces << Rook.new(self,color)
    pieces
  end

  def dup
    duped_board = Board.new(false)
    @rows.each_with_index do |row,row_i|
      row.each_with_index do |board_piece,col_i|
        duped_board[[row_i,col_i]] = board_piece.dup(duped_board)
      end
    end
    duped_board
  end

  def valid_move?(start_pos,end_pos,called_by_checkmate = false)
    piece = self[start_pos]
    potential_moves = piece.moves

    if piece.is_a?(Null)
      raise InvalidMoveError.new("Can't move from here.") unless called_by_checkmate
    end

    unless potential_moves.include?(end_pos)
      raise InvalidMoveError.new("Can't move there!") unless called_by_checkmate
      return false
    end

    potential_board = self.dup
    potential_board.move!(start_pos,end_pos)

    if potential_board.in_check?(piece.color)
      raise InvalidMoveError.new("That would put you in check.") unless called_by_checkmate
      return false
    end
    true
  end

  def try_move(start_pos,end_pos)
    valid = valid_move?(start_pos,end_pos)
    move!(start_pos,end_pos) if valid
    return true if valid
  end

  def move!(start_pos,end_pos)
    dead_piece = self[end_pos]
    unless dead_piece.is_a?(Null)
      white_graveyard << dead_piece if dead_piece.color == :white
      black_graveyard << dead_piece if dead_piece.color == :black
    end
    self[start_pos].move!(start_pos,end_pos)

  end

  def populate_pawns
    @rows[1].length.times do |idx|
      @rows[1][idx] = Pawn.new(self,:black)
    end

    @rows[6].length.times do |idx|
      @rows[6][idx] = Pawn.new(self,:white)
    end
  end

  # def mark(pos)
  #   x, y = pos
  #   @rows[x][y] = Piece.new
  # end

  def find_piece(piece)
    @rows.each_with_index do |row,row_i|
      row.each_with_index do |board_piece,col_i|
        return [row_i,col_i] if board_piece == piece
      end
    end
    nil
  end

  def in_check?(color)
    @rows.each do |row|
      row.each do |piece|
        if piece.enemy?(color)
          possible_moves = piece.moves
          possible_moves.each do |pos|
            return true if self[pos].is_a?(King)
          end
        end
      end
    end
    return false
  end

  def checkmate?(color)
    if in_check?(color)
      @rows.each do |row|
        row.each do |piece|
          if piece.ally?(color)
            possible_moves = piece.moves
            possible_moves.each do |pos|
              return false if valid_move?(find_piece(piece), pos,true)
            end
          end
        end
      end
      return true
    else
      return false
    end
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  # def full?
  #   @rows.all? do |row|
  #     row.all? { |piece| piece.present? }
  #   end
  # end

  def highlight_moves(piece)
    possible_moves = piece.moves
    possible_moves.each do |pos|
      self[pos].highlighted = true
    end
  end

  def remove_highlight
    @rows.each do |row|
      row.each do |piece|
        piece.highlighted = false
      end
    end
  end
  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
  end
end
