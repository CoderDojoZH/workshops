debug = true

boatImg = nil

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
    love.graphics.draw(playerImg, 175, 500) -- draw it towards the bottom of the window
end

