function love.load()
	love.graphics.setBackgroundColor(0,0,0)
	love.mouse.setVisible(false)
	require("character")
	character.new(1)
	print("spawned " .. character.all[1].name)
	character.new(2)
	print("player 2 spawned")
	character.new(3)
	print("player 3 spawned")
	character.new(4)
	print("player 4 spawned")
end

function love.draw()
	character.draw()
end

function love.update(dt)
	character.update(dt)
end

function love.quit()
end