asteroids = {}

function asteroids.load()
    maxTime = 2
    timer = maxTime
end

function asteroids.update(dt)
    asteroidMovement(dt)

    timer = timer - dt
    if timer <= 0 then
        asteroidSpawn()
        maxTime = 0.95 * maxTime
        timer = maxTime
    end
end

function asteroids.draw()
    for i, asteroid in ipairs(asteroids) do
        love.graphics.draw(sprites.asteroid, asteroid.x, asteroid.y, nil, 4, nil, 16, 16)
    end 
end

-- Asteroid functions

function asteroidSpawn()
    local asteroid = {}
    asteroid.x = 800
    asteroid.y = math.random(0, love.graphics.getHeight())
    asteroid.speed = 200
    asteroid.dead = false
    table.insert(asteroids, asteroid)
end

function asteroidMovement(dt)
    for i, asteroid in ipairs(asteroids) do
        asteroid.x = asteroid.x - asteroid.speed * dt
    end

    for i, asteroid in ipairs(asteroids) do
        if distanceBetween(asteroid.x, asteroid.y, player.x, player.y) < 70 then
            for i, asteroid in ipairs(asteroids) do
                asteroids[i] = nil
                gameState = 1
                player.x = 300
                player.y = 300
                player.score = 0
            end
        end
    end
end

function love.keypressed(key)
    if key == 'space' then
        asteroidSpawn()
    end
end