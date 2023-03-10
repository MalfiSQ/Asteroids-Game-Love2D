player = {}
bullets = {}

function player.load()
    player.x = 300
    player.y = 300
    player.speed = 400
    player.score = 0
end

function player.update(dt)
    playerMovement(dt)
    bulletMovement(dt)
    destroyBullet(dt)
    killAsteroid(dt)
end

function player.draw()
    love.graphics.draw(sprites.player, player.x, player.y, nil, 3, nil, 32, 16)

    for i, bullet in ipairs(bullets) do
        love.graphics.draw(sprites.bullet, bullet.x, bullet.y, nil, 1.5, nil, 16, 16)
    end 

    love.graphics.print("Score: " .. player.score, 350, 10, nil, 1.5)
end

-- Player functions 

function love.mousepressed(x, y, button)
    if button == 1 then
        spawnBullet()
    end
end

function playerMovement(dt)
    if love.keyboard.isDown("d") then player.x = player.x + player.speed * dt end
    if love.keyboard.isDown("a") then player.x = player.x - player.speed * dt end
    if love.keyboard.isDown('s') then player.y = player.y + player.speed * dt end
    if love.keyboard.isDown('w') then player.y = player.y - player.speed * dt end
end

function spawnBullet()
    local bullet = {}
    bullet.x = player.x + 25
    bullet.y = player.y
    bullet.speed = 600
    bullet.dead = false
    table.insert(bullets, bullet)
end

function bulletMovement(dt)
    for i, bullet in ipairs(bullets) do
        bullet.x = bullet.x + bullet.speed * dt
    end
end

function destroyBullet(dt)
    for i = #bullets, 1, -1 do
        local b = bullets[i]
        if b.x < 0 or b.x > love.graphics.getWidth() then
            table.remove(bullets, i)
        end
    end
end

function killAsteroid(dt)
    for i, asteroid in ipairs(asteroids) do
        for j, bullet in ipairs(bullets) do
            if distanceBetween(asteroid.x, asteroid.y, bullet.x, bullet.y) < 55 then
                asteroid.dead = true
                bullet.dead = true

                player.score = player.score + 1
            end
        end
    end

    for i = #bullets, 1, -1 do
        local b = bullets[i]
        if b.dead == true then table.remove(bullets, i) end
    end

    for i = #asteroids, 1, -1 do
        local a = asteroids[i]
        if a.dead == true then table.remove(asteroids, i) end
    end
end