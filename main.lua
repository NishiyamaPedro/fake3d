if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

function math.clamp(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function love.load()
	width, height = love.graphics.getDimensions()
	centerX = width/2
	centerY = height/2
	
	pitch = 1
    pitch_min = 1
    pitch_max = 0.5
    pitch_to = pitch

    angle = 0
    angle_to = angle

	quad = love.graphics.newQuad(0,0,width+1024,height+1024,32,32)
	tx = love.graphics.newImage('tile.png')
	tx:setWrap('repeat', 'repeat')
end

function love.update(dt)
	local x, y = love.mouse.getPosition()
	local right = love.mouse.isDown(1)
	if love.keyboard.isDown("d") or (x > 400 and right) then
        angle_to = angle_to - 0.05
		love.mouse.setX(400)
    end

    if love.keyboard.isDown("a") or (x < 400 and right) then
        angle_to = angle_to + 0.05
		love.mouse.setX(400)
    end

    if love.keyboard.isDown("s") or (y > 300 and right) then
        pitch_to = pitch_to + 0.05
		love.mouse.setY(300)
    end

    if love.keyboard.isDown("w") or (y < 300 and right) then
        pitch_to = pitch_to - 0.05
		love.mouse.setY(300)
    end

	pitch_to = math.clamp(pitch_to, pitch_max, pitch_min);
	
	pitch = math.lerp(pitch, pitch_to, 0.1);
	angle = math.lerp(angle, angle_to, 0.1);
end

function love.draw()
	love.graphics.push()
		love.graphics.scale(1, 1*pitch)
		love.graphics.translate(centerX, height/((pitch)*2))
		love.graphics.scale(1.5)
		love.graphics.rotate(angle)
		love.graphics.draw(tx, quad, -centerX-512, -centerY-512)
		love.graphics.setColor(0, 0, 255, 155)
		love.graphics.rectangle('fill', -60, -100, 40, 40)
		love.graphics.rectangle('fill', -150, 100, 40, 40)
		love.graphics.rectangle('fill', -150, 0, 40, 40)
		love.graphics.rectangle('fill', 40, 40, 40, 40)
		love.graphics.circle('fill', 0, 0, 20, 20)	
		love.graphics.setColor(255, 255, 255)
	love.graphics.pop()
end