function love.load()
  love.window.setTitle( "DangerTetris" )
  print( love.graphics.getWidth() )
  print( love.graphics.getHeight() )

  --  GLOBALS   --
  HALF_WIDTH = love.graphics.getWidth() / 2
  HALF_HEIGHT = love.graphics.getHeight() / 2
  --  specs of squares that comprise polygons   --
  square_width = 24
  square_height = 24
  half_square_width = square_width / 2
  half_square_height = square_height / 2

  --  MORE GLOBALS  --
  NEW_TETROMINO_X = HALF_WIDTH
  NEW_TETROMINO_Y = 2 * square_width

  whole_rotation = 360 -- in degrees
  dr = math.rad( whole_rotation / 4 )
  dx = 100
  dy = 100

  --  INIT PHYSICS  --
  meter = 24
  love.physics.setMeter( meter )
  world = love.physics.newWorld( 0, 10 * meter, true )
  world:setCallbacks( beginContact, endContact, preSolve, postSolve )

  --  container for all tetromino square positions  --
  tetromino_templates = {}
  --  square center positions within tetromino one   --
  tetromino_one =  {}
  tetromino_one.squares = {}
  tetromino_one.squares[1] = { 0 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_one.squares[2] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_one.squares[3] = { 2 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_one.squares[4] = { 3 * square_width + half_square_width, 0 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_one )

  --  square center positions within tetromino one   --
  tetromino_two = {}
  tetromino_two.squares =  {}
  tetromino_two.squares[1] = { 0 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_two.squares[2] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_two.squares[3] = { 2 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_two.squares[4] = { 2 * square_width + half_square_width, 0 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_two )

  --  square center positions within tetromino one   --
  tetromino_three = {}
  tetromino_three.squares =  {}
  tetromino_three.squares[1] = { 0 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_three.squares[2] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_three.squares[3] = { 2 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_three.squares[4] = { 2 * square_width + half_square_width, 1 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_three )

  --  square center positions within tetromino one   --
  tetromino_four = {}
  tetromino_four.squares =  {}
  tetromino_four.squares[1] = { 0 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_four.squares[2] = { 0 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_four.squares[3] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_four.squares[4] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_four )

  --  square center positions within tetromino one   --
  tetromino_five = {}
  tetromino_five.squares =  {}
  tetromino_five.squares[1] = { 0 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_five.squares[2] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_five.squares[3] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_five.squares[4] = { 2 * square_width + half_square_width, 1 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_five )

  --  square center positions within tetromino one   --
  tetromino_six = {}
  tetromino_six.squares =  {}
  tetromino_six.squares[1] = { 0 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_six.squares[2] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_six.squares[3] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_six.squares[4] = { 2 * square_width + half_square_width, 1 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_six )

  --  square center positions within tetromino one   --
  tetromino_seven = {}
  tetromino_seven.squares =  {}
  tetromino_seven.squares[1] = { 0 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_seven.squares[2] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetromino_seven.squares[3] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetromino_seven.squares[4] = { 2 * square_width + half_square_width, 0 * square_height + half_square_height }
  table.insert( tetromino_templates, tetromino_seven )

  --  this is where new tetrominos go   --
  tetrominos = {}
  active_tetromino = 0
  newTetromino()

  --  this is where walls go  --
  walls = {}
  --  create left wall  --
  left_wall_x = HALF_WIDTH - 6 * square_width + half_square_width - 8
  left_wall_y = 20 / 2 * square_width + half_square_width
  left_wall_width = square_width
  left_wall_height = 21 * square_height
  walls[1] = {}
  walls[1].body = love.physics.newBody( world, left_wall_x, left_wall_y, "static" )
  walls[1].shape = love.physics.newRectangleShape( left_wall_width, left_wall_height )
  walls[1].fixture = love.physics.newFixture( walls[1].body, walls[1].shape, 1 )

  --  create right wall   --
  right_wall_x = HALF_WIDTH + 5 * square_width + half_square_width
  right_wall_y = 20 / 2 * square_width + half_square_width
  right_wall_width = square_width
  right_wall_height = 21 * square_height
  walls[2] = {}
  walls[2].body = love.physics.newBody( world, right_wall_x, right_wall_y, "static" )
  walls[2].shape = love.physics.newRectangleShape( right_wall_width, right_wall_height )
  walls[2].fixture = love.physics.newFixture( walls[2].body, walls[2].shape, 1 )

  --  create floor  --
  floor_x = HALF_WIDTH
  floor_y = 20 * square_width + half_square_width
  floor_width = 12 * square_width
  floor_height = square_height
  walls[3] = {}
  walls[3].body = love.physics.newBody( world, floor_x, floor_y, "static" )
  walls[3].shape = love.physics.newRectangleShape( floor_width, floor_height )
  walls[3].fixture = love.physics.newFixture( walls[3].body, walls[3].shape, 1 )


end

function love.update( dt )
  world:update( dt )
  checkKeyPresses( dt )
end

function love.draw()
  --tetromino_dx, tetromino_dy = active_tetromino.body:getLinearVelocity()
  love.graphics.print( "speed: " .. tostring( tetromino_dx ) .. ", " .. tostring( tetromino_dy ), 0, 0 )
  drawAllTetrominos()
  drawBoundaries()
end

function drawAllTetrominos()
  for t = 1, #tetrominos do
  	love.graphics.setColor( 255, 255, 255 )
  	if t == active_tetromino then
  		love.graphics.setColor( 255, 0, 0 )
  	end
    for s = 1, 4 do
      love.graphics.polygon( "fill", tetrominos[t].body:getWorldPoints( tetrominos[t].shapes[s]:getPoints() ) )
    end
  end
end

function drawBoundaries()
  love.graphics.setColor( 255, 255, 255 )
  for i = 1, #walls do
    love.graphics.polygon( "fill", walls[i].body:getWorldPoints( walls[i].shape:getPoints() ) )
  end
end

function newTetromino()
  --  pick a random number between 1 and the number of tetromino templates  --
  math.randomseed( os.time() )
  math.random(); math.random(); math.random();
  tetromino_type = math.random( 1, #tetromino_templates )

  new_tetromino = {}
  new_tetromino.body = love.physics.newBody( world, NEW_TETROMINO_X, NEW_TETROMINO_Y, "dynamic" )
  new_tetromino.shapes = {}
  new_tetromino.fixtures = {}
  for i = 1, 4 do
    local new_tetromino_x = tetromino_templates[tetromino_type].squares[i][1]
    local new_tetromino_y = tetromino_templates[tetromino_type].squares[i][2]
    new_tetromino.shapes[i] = love.physics.newRectangleShape( new_tetromino_x, new_tetromino_y, square_width, square_height )
    new_tetromino.fixtures[i] = love.physics.newFixture( new_tetromino.body, new_tetromino.shapes[i], 1 )
  end
  table.insert( tetrominos, new_tetromino )
  active_tetromino = active_tetromino + 1
end

--  CONTROLS  --
function checkKeyPresses( dt )
	--tdx = dx * dt
	--tdy = dy * dt
	--tdr = dr * dt

  if love.keyboard.isDown( "up" ) then
  	tetrominos[active_tetromino].body:setLinearVelocity( 0, dy )
    --moveAllTetrominos( 0, -tdy, 0 )
  end
  if love.keyboard.isDown( "down" ) then
    tetrominos[active_tetromino].body:setLinearVelocity( 0, -dy )
    --moveAllTetrominos( 0, tdy, 0 )
  end
  if love.keyboard.isDown( "left" ) then
    tetrominos[active_tetromino].body:setAngularVelocity( -dr )
    --moveAllTetrominos( 0, 0, -tdr )
  end
  if love.keyboard.isDown( "right" ) then
    tetrominos[active_tetromino].body:setAngularVelocity( dr )
    --moveAllTetrominos( 0, 0, tdr )
  end

  --[[
  if love.keyboard.isDown( "space" ) then
    newTetromino()
  end
  ]]
end

--[[
function moveAllTetrominos( dx, dy, dr )
	for i = 1, #tetrominos do
		local cdx, cdy = tetrominos[i].body:getLinearVelocity()
		local cdr = tetrominos[i].body:getAngularVelocity()
		local ndx = cdx + dx
		local ndy = cdy + dy
		local ndr = cdr + dr

		tetrominos[i].body:setLinearVelocity( ndx, ndy )
		tetrominos[i].body:setAngularVelocity( ndr )
	end
end
]]

function love.keypressed( key )
  if( key == "space" ) then
    newTetromino()
  end
  if( key == "2" ) then
  	changeActiveTetromino( 1 )
  end
  if( key == "1" ) then
  	changeActiveTetromino( -1 )
  end
end

function changeActiveTetromino( direction )
	active_tetromino = active_tetromino + direction
	if active_tetromino < 0 then
		active_tetromino = 0
	end
	if active_tetromino >= #tetrominos then
		active_tetromino = #tetrominos
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
