function love.load()
  love.window.setTitle( "DangerTetris" )
  print( love.graphics.getWidth() )
  print( love.graphics.getHeight() )

  --  GLOBALS   --
  HALF_WIDTH = love.graphics.getWidth() / 2
  HALF_HEIGHT = love.graphics.getHeight() / 2

  whole_rotation = 360 -- in degrees
  dr = math.rad( whole_rotation / 4 )
  dx = 100
  dy = 100

  --  INIT PHYSICS  --
  meter = 24
  love.physics.setMeter( meter )
  world = love.physics.newWorld( 0, 10 * meter, true )
  world:setCallbacks( beginContact, endContact, preSolve, postSolve )

  --  specs of squares that comprise polygons   --
  square_width = 24
  square_height = 24
  half_square_width = square_width / 2
  half_square_height = square_height / 2

  --  square center positions within polygon   --
  tetromino_templates = {}
  tetrromino__templates[1].squares =  {}
  tetrromino__templates[1].squares[1] = { 0 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetrromino__templates[1].squares[2] = { 1 * square_width + half_square_width, 0 * square_height + half_square_height }
  tetrromino__templates[1].squares[3] = { 1 * square_width + half_square_width, 1 * square_height + half_square_height }
  tetrromino__templates[1].squares[4] = { 1 * square_width + half_square_width, 2 * square_height + half_square_height }
  table.insert( tetromino_templates, squares )

  --  create one tetromino  --
  tetromino = {}
  tetromino.body = love.physics.newBody( world, HALF_WIDTH, HALF_HEIGHT, "dynamic" )
  tetromino.shapes = {}
  tetromino.fixtures = {}
  tetromino.shapes[1] = love.physics.newRectangleShape( squares[1][1], squares[1][2], square_width, square_height )
  tetromino.shapes[2] = love.physics.newRectangleShape( squares[2][1], squares[2][2], square_width, square_height )
  tetromino.shapes[3] = love.physics.newRectangleShape( squares[3][1], squares[3][2], square_width, square_height )
  tetromino.shapes[4] = love.physics.newRectangleShape( squares[4][1], squares[4][2], square_width, square_height )
  tetromino.fixtures[1] = love.physics.newFixture( tetromino.body, tetromino.shapes[1], 1 )
  tetromino.fixtures[2] = love.physics.newFixture( tetromino.body, tetromino.shapes[2], 1 )
  tetromino.fixtures[3] = love.physics.newFixture( tetromino.body, tetromino.shapes[3], 1 )
  tetromino.fixtures[4] = love.physics.newFixture( tetromino.body, tetromino.shapes[4], 1 )

  --  this is where new tetrominos go   --
  tetrominos = {}

  walls = {}
  --  create left wall  --
  left_wall_x = HALF_WIDTH - 6 * square_width + half_square_width
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
  tetromino_dx, tetromino_dy = tetromino.body:getLinearVelocity()
  love.graphics.print( "speed: " .. tostring( tetromino_dx ) .. ", " .. tostring( tetromino_dy ), 0, 0 )
  drawTetromino()
  drawBoundaries()
end

function drawTetromino()
  love.graphics.setColor( 255, 255, 255 )
  --  draw all shapes in tetromino  --
  for i = 1, #tetromino.shapes do
    love.graphics.polygon( "fill", tetromino.body:getWorldPoints( tetromino.shapes[i]:getPoints() ) )
  end
end

function drawBoundaries()
  love.graphics.setColor( 255, 255, 255 )
  for i = 1, #walls do
    love.graphics.polygon( "fill", walls[i].body:getWorldPoints( walls[i].shape:getPoints() ) )
  end
end

function newTetromino()
  new_tetromino = {}
  new_tetromino.body = love.physics.newBody( world, NEW_TETROMINO_X, NEW_TETROMINO_Y, "dynamic" )
  new_tetromino.shapes = {}
  new_tetromino.fixtures = {}
  tetrominos.shapes[1] = love.physics.newRectangleShape( squares[1][1], squares[1][2], square_width, square_height )
  tetromino.shapes[2] = love.physics.newRectangleShape( squares[2][1], squares[2][2], square_width, square_height )
  tetromino.shapes[3] = love.physics.newRectangleShape( squares[3][1], squares[3][2], square_width, square_height )
  tetromino.shapes[4] = love.physics.newRectangleShape( squares[4][1], squares[4][2], square_width, square_height )
  tetromino.fixtures[1] = love.physics.newFixture( tetromino.body, tetromino.shapes[1], 1 )
  tetromino.fixtures[2] = love.physics.newFixture( tetromino.body, tetromino.shapes[2], 1 )
  tetromino.fixtures[3] = love.physics.newFixture( tetromino.body, tetromino.shapes[3], 1 )
  tetromino.fixtures[4] = love.physics.newFixture( tetromino.body, tetromino.shapes[4], 1 )
  table.insert( tetrominos, new_tetromino )
end
--  CONTROLS  --
function checkKeyPresses( dt )
  if love.keyboard.isDown( "up" ) then
    tetromino.body:setLinearVelocity( 0, dy )
  end
  if love.keyboard.isDown( "down" ) then
    tetromino.body:setLinearVelocity( 0, -dy )
  end
  if love.keyboard.isDown( "left" ) then
    tetromino.body:setAngularVelocity( -dr )
  end
  if love.keyboard.isDown( "right" ) then
    tetromino.body:setAngularVelocity( dr )
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
