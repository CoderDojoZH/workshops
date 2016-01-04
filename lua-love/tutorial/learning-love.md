# Your first game with LÖVE

We are now ready to put our hands into LÖVE and create our first game: a Fireboat throwing water at flames falling from the sky.

## Setup the game and draw the fireboat

For our first game we create a `Fireboat/` directory somewhere on your computer (`Documents` is a good place for it) . This directory will contain all the files for our game.

Start the [text editor](glossary#text-editor) and create the `conf.lua` file:

~~~.lua
-- Configuration file that gets read by Löve
function love.conf(t)
    t.title = "Fireboat Tutorial"
    t.version = "0.9.1" -- The LÖVE version targetted
    t.window.width = 400
    t.window.width = 600

    t.console = true -- For debugging on windows
end
~~~

The `conf.lua` file is automatically read by LÖVE. The `love.conf(t)` function we define in `conf.lua` is automatically executed before the game starts.

The main attributes we are setting in the configuration file are the title and the size of the window where the game will be shown.

A [complete list of the attributes](http://www.love2d.org/wiki/Config_Files) you can set can be found in the LÖVE wiki.

In the same `Fireboat` directory we create another file called `main.lua` where we will write the game's logic.

~~~.lua
debug = true

playerImg = nil

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    playerImg = love.graphics.newImage('assets/fireboat.png')
end

--[[
Called for each frame
--]]
function love.draw()
    love.graphics.draw(playerImg, 175, 500) -- Draw it towards the bottom of the window
end
~~~

In the same way as LÖVe is calling the `love.conf(t)` function we have defined in `conf.lua`, LÖVe will also:

- run `love.load(arg)` when the program starts.
- run `love.draw()` each time it redraws the window.

In this very first version our game is loading the `fireboat.png` image and drawing it at the coordinates `175, 500`.

As you might have guessed, before we can run the program, we have to create an `assets/` directory inside of our game's directory and copy into there the `fireboat.png` image file.

Our application is ready to run!

As explained in the Getting started chapters for [Linux](TODO), [Mac OS X](TODO), and [Windows](TODO), depending on your operating system and your personal preferences you can now

- drag the the `Fireboat/` directory on the `Love` application icon (preferred for Windows and OS X) or
- run `love Fireoboat/` in the terminal while being in the directory above the `Fireoboat/` directory (preferred for Linux)

![The window created by LÖVE with the fireboat](images/fireboat-creating-01.png)


You can close the game by clicking on the close icons your system will have add to your window (TODO: add small screenshots for some Window managers).

The source for this first example can be found on [GitHub](TODO).

## Stearing the Fireboat

In our game, the Fireboat will move to the left and the right, avoiding the falling fire flames and throwing water at them.

The first step is to define the boat position in an object that we can manipulate:

~~~.lua
debug = true

player = { x = 175, y = 500, img = nil }

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
end

--[[
Called for each frame
--]]
function love.draw()
    love.graphics.draw(player.img, player.x, player.y) -- draw it towards at the position (x, y)
end
~~~

The `fireboat.png` image, the horizontal (`x`) and the vertical (`y`) position are now defined inside of the `player` structure. The `player`'s fields are used for loading the image `love.load()` and then for drawing it in `love.draw()` at the position defined by `player.x` and `player.y`.

A remark: the coordinates have their origin -- the `(0, 0)` point -- in the top left corner: `(175, 500)` is the distance in pixels from the top left corner of the bounding box around the image and the top left corner of the window.

![Coordinates origin is the upper left corner](images/fireboat-coordinates.png)

We are now ready for binding the boat's movements with the keyboard:

~~~.lua
debug = true

player = { x = 175, y = 500, speed = 150, img = nil }

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
end

--[[
Called for each frame
@param numeric dt time elapsed since the last call
--]]
function love.update(dt)
    -- We need a way to get out of the game...
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    -- Left arrow and 'a', to the left, right arrow and 'd' to the right...
	if love.keyboard.isDown('left','a') then
        player.x = player.x - (player.speed * dt)
	elseif love.keyboard.isDown('right','d') then
        player.x = player.x + (player.speed * dt)
	end
end

--[[
Called for each frame
--]]
function love.draw()
    love.graphics.draw(player.img, player.x, player.y) -- draw it towards at the position (x, y)
end
~~~

We are adding a `love.update()` function that triggers the `quit` event when the `ESC` key is pressed and changes the boat's `x` position  when the arrow keys or the `a` / `d` keys are pressed.

Each movement of the player is calculated by multiplying the `speed` field -- it's the new field in the player's structure -- by the "delta-time" (`dt`) variable that LÖVE is giving us as parameter to the `love.update()` function.  
`dt` is the time elapsed since the last time LÖVE has called `love.update()` and is used to make the game run at the same pace on computers with different speeds.  
If you want the boat to react faster or slower to the commands, you can modify the value of `player = { .... speed = 150 ...}`.

After each modification of your code, you should run the game and test if the changes have the expected result. If you have done so, you will have noticed that the boat can "sail" out of the window.  
When the key is pressed, we should make sure that the boat cannot go over the border: the `math.max()` and `math.min()` ensure that the boat's `x` value is never smaller than `0` nor bigger than the window's width. Since the position of the boat gets calculated by it's top left corner, for the right side check we have to add the width of the boat itself.

~~~.lua
debug = true

player = { x = 175, y = 500, speed = 150, img = nil }

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
end

--[[
Called for each frame
@param numeric dt time elapsed since the last call
--]]
function love.update(dt)
    -- We need a way to get out of the game...
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    -- Left arrow and 'a', to the left, right arrow and 'd' to the right...
	if love.keyboard.isDown('left','a') then
        player.x = math.max(player.x - (player.speed * dt), 0)
	elseif love.keyboard.isDown('right','d') then
        player.x = math.min(player.x + (player.speed * dt), love.graphics.getWidth() - player.img:getWidth())
	end
end

--[[
Called for each frame
--]]
function love.draw()
    love.graphics.draw(player.img, player.x, player.y) -- draw it towards at the position (x, y)
end
~~~

The source for this stage of the game can be found on [GitHub](TODO).

## Throwing water drops

Now that we are able to stear our boat, we can get to the next task: throw water drops.

First you need an image for drop. You can draw your own or download the one we're using for our sample code: [drop.png](https://raw.githubusercontent.com/CoderDojoZH/workshops/master/lua-love/step-03/assets/drop.png).

In `love.update()` we add the code to detect when the space bar is pressed (`love.keyboard.isDown(' ')`).  
The `newDrop` is based in the `drop` structure we define at the beginning of the program and gets inserted in the `drops` list (also newly defined at the beginning of the program):

~~~.lua
-- Create a bullet on space at the boat position
if love.keyboard.isDown(' ') then
    newDrop = { x = player.x + (player.img:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
    table.insert(drops, newDrop)
end
~~~

We also want the drop to move upwards until it reaches the top of the window: each time `love.update()` gets called, each drop moves up according to `drop.speed`:

~~~.lua
-- Scroll up the position of the drops
for i, drop in ipairs(drops) do
    drop.y = drop.y - (drop.speed * dt)

    if drop.y < 0 then -- Remove bullets when they pass off the screen
        table.remove(drops, i)
    end
end
~~~

Since the drops are moving up, we remove the speed from the current drop position.

A remark: in the `for i, drop  in ipairs(drops)` loop we are defining a local `drop` variable: it's not a problem to use the same name as the global `drop` structure, but inside of the `for` loop we cannot access the global `drop` (for more information see the short section on ["Scope"](learning-lua#scope) in the ["Learning Lua"](learning-lua) chapter.

~~~.lua
debug = true

player = { x = 175, y = 500, speed = 150, img = nil }
drop = { speed = 250, img = nil }
drops = {} -- List of bullets currently being drawn and updated

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
    drop.img = love.graphics.newImage('assets/drop.png')
end

--[[
Called for each frame
@param numeric dt time elapsed since the last call
--]]
function love.update(dt)
    -- We need a way to get out of the game...
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

	-- Scroll up the position of the drops
	for i, drop in ipairs(drops) do
		drop.y = drop.y - (drop.speed * dt)

		if drop.y < 0 then -- Remove bullets when they pass off the screen
			table.remove(drops, i)
		end
	end

    -- Create a bullet on space at the boat position
	if love.keyboard.isDown(' ') then
		newDrop = { x = player.x + (player.img:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
		table.insert(drops, newDrop)
	end

    -- Left arrow and 'a', to the left, right arrow and 'd' to the right...
	if love.keyboard.isDown('left','a') then
        player.x = math.max(player.x - (player.speed * dt), 0)
	elseif love.keyboard.isDown('right','d') then
        player.x = math.min(player.x + (player.speed * dt), love.graphics.getWidth() - player.img:getWidth())
	end
end

--[[
Called for each frame
--]]
function love.draw()
	for i, drop in ipairs(drops) do
		love.graphics.draw(drop.img, drop.x, drop.y)
	end
    love.graphics.draw(player.img, player.x, player.y)
end
~~~

At thend of this tutorial, the full code for our game will count around 200 lines of code. We are currently at about 50 lines of code right now: but it's already getting too long for the full code being reproduced at each step.  
From this point on, we will show the new code to be typed and describe where it should be inserted. Of course, we will continue providing links to the external repository where you can see to the full code at each stage, so that you can cross check your code, if you think you made an error.

The full code for this stage is on [Github](https://github.com/CoderDojoZH/workshops/blob/master/lua-love/step-03/).

## Limiting the water throughput

Right now, when you keep on pressing the space bar a big column of water is thrown out. Our next task is to enfoce a small interval between two drops.

We define the interval by extending the `drop` structure with the two fields `interval` and `intervalTimer`:

~~~.lua
drop = { speed = 250, img = nil, interval = 0.2, intervalTimer = 0 }
~~~

Each time we produce a drop, we set `drop.intervalTimer` to the value of `drop.interval` and let the `love.update()` function decrease the `drop.intervalTimer` by 1 multiplied by the `dt` parameter.  We also add a condition that only lets process the action bound to the space bar if the `drop.intervalTimer` is smaller than 0:

~~~.lua
-- Decrease the drop interval timer before the next drop
drop.intervalTimer = drop.intervalTimer - (1 * dt)

-- Create a bullet on space at the boat position if intervalTimer is not being decreased
if love.keyboard.isDown(' ', 'space') and drop.intervalTimer < 0 then
    newDrop = { x = player.x + (player.img:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
    table.insert(drops, newDrop)
    drop.intervalTimer = drop.interval
end
~~~



## Adding the falling flames



## Exercises

- Mirror the boat when turning left / right
