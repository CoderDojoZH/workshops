# Animated sprites with Löve

What if you want to animate your sprites? a walking character, an exploding rock, a blooming flower, ...

The best way to animate a sprite is by creating a _sprite sheet_: A _sprite sheets_ is a wide image containing a collection of sprites, each of which is a a part of the animation. The sub-images can be rendered by modifying the sprite coordinates, essentially telling it which part of the sheet should be displayed ([Wikipedia](https://en.wikipedia.org/wiki/Texture_atlas)).

## Drawing your own wprite

### Gimp

- [How to set up GIMP for pixel art](https://www.youtube.com/watch?v=oAaoh49yf5A)

### Directly drawing a sprite sheet

To be completed

### Drawing in stacked layers

To be completed

- Duplicate the layer 
- ...
- Filter > Animation > Playback

### Piskel

Piskel is a free online editor for animated sprites & pixel art:

http://www.piskelapp.com/

### Goya

Goya is an online pixel art studio for creating animated sprites:

https://jackschaedler.github.io/goya/

## From an animated image to a sprite sheet

More often than not, you've got an animated Gif from the internet... or have created a stacked animation as explained above.

If You load your image(s) in Gimp, as layers of a singe file, then you can use a script to create the sprite sheet.

### Opening a Gif

If you have an animated Gif, you can simply open it with Gimp and each frame of the animation will be in its own layer.

### Opening a stack of images

If you have a Zip file, with an image per frame, you can use the Gimp command `File > Open as layers" to open all the images in one single file.

If the layers are in the reverse order, you can use the command "Layer > Stack > Reverse Layer Order" to get the correct order.

### Creating the sprite sheet

Once you have all your frames in one file, there is a Gimp script for creating sprite sheets from layers that you can download from [Sprite Sheet](http://registry.gimp.org/node/20943) script:

- Download the script from the [Sprite Sheet script](http://registry.gimp.org/node/20943) registry.
- Copy to your own Gimp scripts:
  - On Linux it's ~/.gimp-2.8/scripts/.
- Run `Filters > Script-Fu > Refresh Scripts` to see the new script.
- Open your animated image.
- Run `Filters > Sprite-Sheet` and you'll get a new image with the all the frames in a row.
- Export the image to a wide PNG

## Animating the sprite in Löve

~~~.lua
debug = true

player = { x = 100, y = 100, img = nil, imgFrames = 12, imgQuads = {}, imgTimer = 0, imgSpeed = 20 }

function love.load(arg)
    player.img = love.graphics.newImage('assets/runner-sheet.png')

    local imgWidth, imgHeight = player.img:getWidth(), player.img:getHeight()
    local spriteWidth = imgWidth / player.imgFrames
    for i = 0, player.imgFrames - 1 do
        table.insert(player.imgQuads, love.graphics.newQuad(i * spriteWidth, 0, spriteWidth, imgHeight, imgWidth, imgHeight))
    end
end

function love.update(dt)
    player.imgTimer = player.imgTimer + dt * player.imgSpeed
end

function love.draw()
    love.graphics.draw(player.img, player.imgQuads[(math.floor(player.imgTimer) % player.imgFrames) + 1], player.x, player.y)
end
~~~

## References

- [How to set up GIMP for pixel art](https://www.youtube.com/watch?v=oAaoh49yf5A)
- https://love2d.org/forums/viewtopic.php?t=82302

## Todo

- Onion skinning in Gimp
  - https://answers.yahoo.com/question/index?qid=20110220000323AAbB379
- Fitting layers to canvas (making sure all layers have the same size)
  - `Image > Fit canvas to Layers`
  - `Image > Canvas size`, do not change the size but select the matching "Scale layers" option.
- How to make sprites in GIMP 2. Yes.: https://www.youtube.com/watch?v=9Ym4-h2Gfko
- An animation library for LÖVE: https://github.com/kikito/anim8
