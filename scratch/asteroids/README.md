# Asteroids

The Asteroids game is a good project for learning how to use clones and simplify the interaction between objects.

The project is composed by three basic sprites:

- a spaceship in the middle of the space
- shots that start from the spaceship and are targetted to the meteors.
- meteors that wander around, could distroy the spaceship and that are first split into quarters and then distroyed by the shots.

![](asteroids.gif)

Further development: you can make the spaceship move around by pressing the up and down arrows.

## The spaceship

The spaceship can have any form and is placed in the middle of the screen. The left and right arrow keys make it turn to the left and to the right.

![animated gif with turning spaceship](spaceship.gif)
![spaceship script](spaceship-script.png)

## The shots

The shots are small forms that are fired by pressing the space bar and they move from the spaceship towards the borders of the screen.

When touching the boundary, the shots are destroyed.

The mother of all shots is placed behind the spaceship and stays there hidden.  
When the space bar is pressed, a clone is created which gets the same direction as the spaceship and -- after getting displayed -- it starts moving until until it touches the border.

![shots that go out of the spacehip](shot.gif)
![](shot-script.png)

## The meteors

- use the `size` private variable to track the state of the meteor.
- the clones are created at a random place, but not too close to the spaceship and go in a random direction.
- if it touches a shot, it switches the costume to the smaller meteor, create 4 clones, and delete itself.
- if one of the smaller meteor are hit by a shot, it gets deleted.

When the metheor is hit by a shot, it sends the "hit" message that is received by the shot that can now distroy itself.
