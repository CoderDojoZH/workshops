# The 15-Puzzle

Looking for a visual solution.

- a scratch implementation with one sprite per tile. the solution is by keeping track of the coordinates of the hole.
- writing text by using costumes on a sprite: https://scratch.mit.edu/projects/10843117
- another text writing: https://scratch.mit.edu/projects/1900050/#editor

The simple solution is probably:
- creating the 15 tiles by hand and hardcode the start position of the hole.
- create the movement code in one sprite and then duplicate it in the 15 other sprites

The fine solution:
- clone 15 times the base tile, place it at the right place and show the numbers as custumes
- have a generic move code and replace the hole with the tile's position before moving.

How to get there:
- draw the box
- draw three tiles
- first make a sprite that phisically checks if on its side it's touching another specific tile
- then get the sprites to tell their x,y position
- move a sprite to one of the four directions
- hardcode the top, right, bottom, left limits for the coordinates
- create the code to check if it can move
- create the 15 clones with costumes for the numbers
- program the movements

Todo:
- create an SVG with the board, the main tile and the numbers as vectors (in a way that they can be placed at the right place in scratch)
