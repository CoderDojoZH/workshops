debug = true

player = { x = 175, y = 500, speed = 150, img = nil }

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
    love.graphics.setBackgroundColor(255, 255, 255)
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
