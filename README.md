# Chess

Written in Ruby, played in the command line

![screenshot]

## How to Play
1. Install Ruby, the bundler gem, and git if you haven't already ([Ruby](https://www.ruby-lang.org/en/documentation/installation/),  [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
2. Open the terminal and run these commands:
  * `cd ~/[insert desired download path here]`
  * `git clone https://github.com/ted-eckel/chess.git`
  * `cd chess`
  * `gem install colorize`
  * `ruby game.rb`
3. Use arrow keys to move the cursor, and 'space' or 'enter' to select and place pieces

## Features
* Modular design: each piece inherits from super classes that contain broader functions, which keeps the code DRY
* Displays potential moves when a piece is selected
* colorize gem allows use of arrow keys for navigation

## Some cool code
```
  if potential_board.in_check?(piece.color)
    raise InvalidMoveError.new("That would put you in check.") unless called_by_checkmate
    return false
  end
```

This bit of logic, which is part of a method that checks to see if a move is valid, sees if a piece is in check or not, which is:

```
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
```


[screenshot]: images/chess.jpg
