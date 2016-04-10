debug = true

player = { x = 175, y = 500, speed = 150, img = nil }
drop = { speed = 250, img = nil, interval = 0.2, intervalTimer = 0 }
drops = {} -- List of bullets currently being drawn and updated
flame = { speed = 200, img = nil, interval = 0.4, intervalTimer = 0 }
flames = {} -- List of flames currently being drawn and updated

--[[
Called whe the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/fireboat.png')
    drop.img = love.graphics.newImage('assets/drop.png')
    flame.img = love.graphics.newImage('assets/flame.png')
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

	-- Scroll up the position of the drops
	for i, drop in ipairs(drops) do
		drop.y = drop.y - (drop.speed * dt)

		if drop.y < 0 then -- Remove bullets when they pass off the screen
			table.remove(drops, i)
		end
	end

    -- Scroll down the position of the flames
    for i, flame in ipairs(flames) do
        flame.y = flame.y + (flame.speed * dt)

        if flame.y > love.graphics.getHeight() then -- Remove bullets when they pass off the screen
            table.remove(flames, i)
        end
    end

	-- Decrease the drop interval timer before the next drop/flame
	drop.intervalTimer = drop.intervalTimer - (1 * dt)
	flame.intervalTimer = flame.intervalTimer - (1 * dt)

    -- Create a flame at the top with a random x position if intervalTimer got back to zero
    if flame.intervalTimer < 0 then
        randomX = math.random(10, love.graphics.getWidth() - 10)
        newFlame = { x = randomX, y = -10, speed = flame.speed, img = flame.img }
        table.insert(flames, newFlame)
        flame.intervalTimer = flame.interval
    end

    -- Create a drop on space at the boat position if intervalTimer got back to zero
	if love.keyboard.isDown(' ', 'space') and drop.intervalTimer < 0 then
		newDrop = { x = player.x + (player.img:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
		table.insert(drops, newDrop)
        drop.intervalTimer = drop.interval
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
	for i, flame in ipairs(flames) do
		love.graphics.draw(flame.img, flame.x, flame.y)
	end
    love.graphics.draw(player.img, player.x, player.y)
end
