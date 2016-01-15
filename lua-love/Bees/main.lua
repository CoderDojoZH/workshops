debug = true

player = { x = 175, y = 500, speed = 150, img = nil, score = 0, alive = true }
drop = { speed = 250, img = nil, interval = 0.2, intervalTimer = 0 }
drops = {} -- List of bullets currently being drawn and updated
flame = { speed = 200, img = nil, interval = 0.4, intervalTimer = 0 }
flames = {} -- List of flames currently being drawn and updated
honey = { speed = 250, img = nil}
honeys = {} -- List of flames currently being drawn and updated

--[[
Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
Returns true if two boxes overlap, false if they don't
x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
x2,y2,w2 & h2 are the same, but for the second box
--]]
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return
        x1 < x2+w2 and
        x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end

--[[
Called when the program starts: allows us to load the assets
--]]
function love.load(arg)
    player.img = love.graphics.newImage('assets/head.png')
    drop.img = love.graphics.newImage('assets/flower.png')
    flame.img = love.graphics.newImage('assets/bee.png')
    honey.img = love.graphics.newImage('assets/honey.png')

    love.graphics.setBackgroundColor(135, 206, 250)
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
    
	-- Scroll down the position of the honey
	for i, honey in ipairs(honeys) do
		honey.y = honey.y + (honey.speed * dt)

        if honey.y > love.graphics.getHeight() then -- Remove honey when they pass off the screen
            table.remove(honeys, i)
        end
	end

    --[[
	Collision detection
	Since there will be fewer flames on screen than bullets we'll loop them first
    --]]
	for i, flame in ipairs(flames) do
		for j, drop in ipairs(drops) do
			if checkCollision(flame.x, flame.y, flame.img:getWidth(), flame.img:getHeight(), drop.x, drop.y, drop.img:getWidth(), drop.img:getHeight()) then
				table.remove(drops, j)
				table.remove(flames, i)
                newHoney = { x = flame.x, y = flame.y, speed = honey.speed, img = honey.img }
                table.insert(honeys, newHoney)
			end
		end

		if checkCollision(flame.x, flame.y, flame.img:getWidth(), flame.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
		and player.alive then
			table.remove(flames, i)
			player.alive = false
		end
    end

    for i, honey in ipairs(honeys) do
end

    for i, honey in ipairs(honeys) do
		if checkCollision(honey.x, honey.y, honey.img:getWidth(), honey.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) then
            player.score = player.score + 1
			table.remove(honeys, i)
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

	if not player.alive and love.keyboard.isDown('r') then
		-- remove all drops and flames
		drops = {}
		flames = {}
		honeys = {}
        player.score = 0

		-- reset timers
		drop.intervalTimer = drop.interval
		flame.intervalTimer = flame.interval

		-- move player back to default position
		player.x = 175
		player.y = 500

		-- reset our game state
		player.alive = true
	end
end

--[[
Called for each frame
--]]
function love.draw()
    if player.alive then
        for i, drop in ipairs(drops) do
            love.graphics.draw(drop.img, drop.x, drop.y)
        end
        for i, flame in ipairs(flames) do
            love.graphics.draw(flame.img, flame.x, flame.y)
        end
        for i, honey in ipairs(honeys) do
            love.graphics.draw(honey.img, honey.x, honey.y)
        end
        love.graphics.draw(player.img, player.x, player.y)
    else
        love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("SCORE: " .. tostring(player.score), 300, 10)
end
