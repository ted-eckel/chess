# Chess

Written in Ruby, played in the command line

![screenshot]

## How to Play
1. Install Ruby, the bundler gem, and git if you haven't already ([Ruby](https://www.ruby-lang.org/en/documentation/installation/), [bundler](http://bundler.io/), [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
2. Open the terminal and run these commands:
  * `cd ~/[insert desired download path here]`
  * `git clone https://github.com/ted-eckel/chess.git`
  * `cd chess`
  * `ruby game.rb`
3. Use arrow keys to move the cursor, and 'space' or 'enter' to select and place pieces

## Features
* Modular design: each piece inherits from super classes that contain broader functions, which keeps the code DRY
* Displays potential moves when a piece is selected
* colorize gem allows use of arrow keys for navigation




[screenshot]: chess.jpg
