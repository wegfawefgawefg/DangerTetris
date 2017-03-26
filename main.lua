function love.load()
  love.window.setTitle( "DangerTetris" )

  --  GLOBALS   --
  HALF_WIDTH = love.graphics.getWidth() / 2
  HALF_HEIGHT = love.graphics.getHeight() / 2

  --  INIT PHYSICS  --
  love.physics.setMeter( 64 )
  world = love.physics.newWorld( 0, 9.8 * 64, true )
  world:setCallbacks( beginContact, endContact, preSolve, postSolve )

  --  points on polygon   --
  points =  {
              0, 0,
              0, 100,
              100, 0,
              100, 100,
            }
  x = points[7]
  y = points[8]
  dx = 10
  dy = 10

  --  create one tetromino  --
  tetromino = {}
  tetromino.body = love.physics.newBody( world, HALF_WIDTH, HALF_HEIGHT, "dynamic" )
  tetromino.shape = love.physics.newPolygonShape( points[1], points[2], points[3], points[4], points[5], points[6], points[7], points[8] )
  tetromino.fixture = love.physics.newFixture( tetromino.body, tetromino.shape, 1 )

end

function love.update( dt )
  checkKeyPresses( dt )
  points[7] = x
  points[8] = y
  tetromino.shape = love.physics.newPolygonShape( points[1], points[2], points[3], points[4], points[5], points[6], points[7], points[8] )
end

function love.draw()
  drawTetromino()
end

function drawTetromino()
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.polygon( "line", tetromino.body:getWorldPoints( tetromino.shape:getPoints() ) )
end

--  CONTROLS  --
function checkKeyPresses( dt )
  if love.keyboard.isDown( "up" ) then
    y = y + dy * dt
  end
  if love.keyboard.isDown( "down" ) then
    y = y - dy * dt
  end
  if love.keyboard.isDown( "left" ) then
    x = x - dx * dt
  end
  if love.keyboard.isDown( "right" ) then
    x = x + dx * dt
  end
end

function beginContact()
end

function endContact()
end

function preSolve()
end

function postSolve()
end
