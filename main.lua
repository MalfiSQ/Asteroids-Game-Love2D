require('src/player')
require('src/asteroid')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    asteroids.load()
    player.load()

    sprites = {}
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.asteroid = love.graphics.newImage('sprites/asteroid.png')

    gameState = 1
end

function love.update(dt)
    if gameState == 2 then
        asteroids.update(dt)
        player.update(dt)
    end
end

function love.draw()
    if gameState == 2 then
        asteroids.draw()
        player.draw()
    end

    if gameState == 1 then
        love.graphics.print("Press E to start", 320, 300, nil, 2)
    end
end

-- Functions 

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function love.keypressed(key)
    if key == 'e' and gameState == 1 then
        gameState = 2
    end
end