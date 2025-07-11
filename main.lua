
local function len(list )
		
_len = #list	
return _len	
end

local function map_enumerate(list , fn )
		

        for i, e in ipairs(list) do 
            fn(i, e)
        end
    	
end

local snake = {body={{x=10,y=10}},dir="right",grow=false}
local gridSize = 20
local cellSize = 20
local food = {x=15,y=10}
local gameOver = false
local timer = 0
speed = 0.15
function love.load()
		
love.window.setTitle("Snake in Lua!")
	
love.window.setMode((gridSize) * (cellSize),(gridSize) * (cellSize))
	
end

function love.update(dt )
		
if not gameOver then 
		
 timer = (timer) + (dt)	
if (timer) >= (speed) then 
		
 timer = 0	
moveSnake()
	
checkCollision()
	
end
	
end
	
end

function moveSnake()
		
local head = snake.body[1]	
local newHead = {x=head.x,y=head.y}		
 newHead.x = (newHead.x) + ((((snake.dir) == ("right")) and (1)) or  ((((snake.dir) == ("left")) and (-(1))) or  (0)))	
 newHead.y = (newHead.y) + ((((snake.dir) == ("down")) and (1)) or  ((((snake.dir) == ("up")) and (-(1))) or  (0)))			
table.insert(snake.body,1,newHead)
		
if ((newHead.x) == (food.x)) and ((newHead.y) == (food.y)) then 
		
 snake.grow = true	
spawnFood()
	
end
		
if not snake.grow then 
		
table.remove(snake.body)
	
end
	
 snake.grow = false	
end

function checkCollision()
		
local head = snake.body[1]	
if ((head.x) < (0)) or  (((head.x) >= (gridSize)) or  (((head.y) < (0)) or  ((head.y) >= (gridSize)))) then 
		
 gameOver = true	
end
	
local i = 2		
while true do
		
if (i) >= (
len(snake.body)
) then 
	
break
end
		
local part = snake.body[i]	
if ((part.x) == (head.x)) and ((part.y) == (head.y)) then 
	
 gameOver = true
end
		
 i = (i) + (1)	
end
	
end

function spawnFood()
		
local valid = false	
while true do
		
if valid then 
	
break
end
		
 food.x = 
love.math.random(0,(gridSize) - (1))
	
 food.y = 
love.math.random(0,(gridSize) - (1))
	
 valid = true	
map_enumerate(snake.body,
function (i , part )
		
if ((part.x) == (food.x)) and ((part.y) == (food.y)) then 
		
 valid = false	
end
	
end
)
	
end
	
end

function love.draw()
			
map_enumerate(snake.body,
function (i , part )
		
love.graphics.setColor(0,1,0)
	
love.graphics.rectangle("fill",(part.x) * (cellSize),(part.y) * (cellSize),(cellSize) - (1),(cellSize) - (1))
	
end
)
		
love.graphics.setColor(1,0,0)
	
love.graphics.rectangle("fill",(food.x) * (cellSize),(food.y) * (cellSize),(cellSize) - (1),(cellSize) - (1))
		
if gameOver then 
		
love.graphics.setColor(1,1,1)
	
love.graphics.printf("Game Over! Press R to restart",0,(((gridSize) * (cellSize)) / (2)) - (10),(gridSize) * (cellSize),"center")
	
end
	
end

function love.keypressed(key )
		
if ((key) == ("up")) and ((snake.dir) ~= ("down")) then 
	
 snake.dir = "up"
end
	
if ((key) == ("down")) and ((snake.dir) ~= ("up")) then 
	
 snake.dir = "down"
end
	
if ((key) == ("left")) and ((snake.dir) ~= ("right")) then 
	
 snake.dir = "left"
end
	
if ((key) == ("right")) and ((snake.dir) ~= ("left")) then 
	
 snake.dir = "right"
end
	
if ((key) == ("r")) and (gameOver) then 
	
restartGame()

end
		
end

function restartGame()
		
 snake = {body={{x=10,y=10}},dir="right",grow=false}	
 food = {x=15,y=10}	
 gameOver = false	
 timer = 0	
end

