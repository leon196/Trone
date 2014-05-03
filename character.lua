-- Metatable for thing, contains all methods
local character_mt = {}
 
-- Namespace for thing-class functions
character = {}
 
-- All the things
character.all = {}

local speed = 192
local weaponX = 0
local weaponY = 0

--char = love.graphics.newImage("textures/character.png")

-- Use this function to create a new thing
function character.new( player )
	-- Creates a new object and assigns the __index metatable (Magic)
	local self = setmetatable({}, {__index=character_mt})
	
	-- Put attributes here

	self.id = player
	self.name = "character " .. self.id
	self.w = 64
	self.h = 64

	if self.id == 1 then 
		self.x = 10
		self.y = 10
	elseif self.id == 2 then
		self.x = 790 - self.w
		self.y = 10
	elseif self.id == 3 then
		self.x = 10
		self.y = 590 - self.h
	elseif self.id == 4 then
		self.x = 790 - self.w
		self.y = 590 - self.h
	end

	weaponX = self.x - self.w/2
	weaponY = self.y - self.h/2
	-- e.g:
	--self.x = 0
	--self.y = 0
	--self.w = 32
	--self.h = 32
	
	-- Adds the new thing to the collection
	table.insert(character.all, self)
	-- Returns it for further processing
	return self
end
 
-- This function updates all the things and does garbage collection
function character.update( dt )
	local i = 1
	while i<=#character.all do
		local v = character.all[i]
		if v.purge then -- If .purge is set, remove from the collection
			table.remove(character.all, i)
		else
			-- Update
			v:update(dt)
			i = i+1
		end
 
	end
end
 
-- Draws all the things
function character.draw(  )
	for i,v in ipairs(character.all) do
		v:draw()
	end
end
 
 -- Modify this function to specify how a thing is drawn
function character_mt:draw( )

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.circle("line", weaponX, weaponY, 32, 6)

end

-- Modify this function to define the behaviour of a thing
function character_mt:update( dt )
	-- e.g:
	-- self.x = self.x + dt * 100 -- Moves thing to the right
	
	-- if self.x>500 then
	--	self.purge=true -- Removes thing if it goes over 500 pixels to the right
	-- end

-- if self.id == 1 then

-- 	velocityX = 0
-- 	velocityY = 0

-- 	if love.keyboard.isDown("up") and self.y >= 0 then
--     	 velocityY = -speed
--     elseif love.keyboard.isDown("down") and self.y <= 536 then
--     	 velocityY = speed
--     elseif love.keyboard.isDown("left") and self.x >= 0 then
-- 	    velocityX = -speed
--     elseif love.keyboard.isDown("right") and self.x <= 736 then
--       	velocityX = speed 
-- 	end

--     self.x = self.x + velocityX * dt
--     self.y = self.y + velocityY * dt


-- end

if self.id == 1 then
	
	if love.keyboard.isDown("up") and self.y >= 0 then
    	self.y = self.y - speed * dt 
  
  	elseif love.keyboard.isDown("down") and self.y <= 600 - self.h then
    	self.y = self.y + speed * dt 

	elseif love.keyboard.isDown("left") and self.x >= 0 then
	    self.x = self.x - speed * dt

	elseif love.keyboard.isDown("right") and self.x <= 800 - self.w then
      self.x = self.x + speed * dt 
      
	end
end

if self.id == 2 then
	
	if love.keyboard.isDown("z") and self.y >= 0 then
    	self.y = self.y - speed * dt 
  
  	elseif love.keyboard.isDown("s") and self.y <= window.height - self.h then
    	self.y = self.y + speed * dt 

	elseif love.keyboard.isDown("q") and self.x >= 0 then
	    self.x = self.x - speed * dt

	elseif love.keyboard.isDown("ds") and self.x <= window.width - self.w then
      self.x = self.x + speed * dt 
      
	end
end

end
  
return character;
--[[ HOW TO USE
 
Let's say I want a new "class" called particle
 
Copy-paste this file into particle.lua
Search and replace "thing"->"particle" (ctrl+h)
 
Define the attributes you want in particle.new()
Redefine particle_mt:udpate(dt) and particle_mt:draw()
 
In love.load() do:
require("particle.lua")
 
In love.update(dt) do:
particle.update(dt)
 
In love.draw() do:
particle.draw()
 
Then whenever you need a new particle do particle.new()
 
 
 
--]]