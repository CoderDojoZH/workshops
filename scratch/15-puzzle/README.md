# The 15-Puzzle

Looking for a visual solution.

- a scratch implementation with one sprite per tile. the solution is by keeping track of the coordinates of the hole.
- writing text by using costumes on a sprite: https://scratch.mit.edu/projects/10843117
- another text writing: https://scratch.mit.edu/projects/1900050/#editor

The simple solution is probably:
- creating the 15 tiles by hand and hard code the start position of the hole.
- create the movement code in one sprite and then duplicate it in the 15 other sprites

The fine solution:
- clone 15 times the base tile, place it at the right place and show the numbers as custumes
- have a generic move code and replace the hole with the tile's position before moving.
