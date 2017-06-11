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
