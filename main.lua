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
  NEW_TETROMINO_X = HALF_WIDTH - square_width
  NEW_TETROMINO_Y = 5 * square_width

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
  active_tetromino = 1

  --  this is where walls go  --
  walls = {}
  --  create left wall  --
  left_wall_width = square_width
  left_wall_height = 21 * square_height
  left_wall_x = HALF_WIDTH - 6 * square_width + half_square_width - 8
  left_wall_y = 23 * square_width - left_wall_height / 2 + half_square_width - square_width - 0.1
  walls[1] = {}
  walls[1].body = love.physics.newBody( world, left_wall_x, left_wall_y, "static" )
  walls[1].shape = love.physics.newRectangleShape( left_wall_width, left_wall_height )
  walls[1].fixture = love.physics.newFixture( walls[1].body, walls[1].shape, 1 )
  walls[1].fixture:setUserData( "left_wall" )

  --  create right wall   --
  right_wall_width = square_width
  right_wall_height = 21 * square_height
  right_wall_x = HALF_WIDTH + 5 * square_width + half_square_width
  right_wall_y = 23 * square_width - right_wall_height / 2 + half_square_width - square_width - 0.1
  walls[2] = {}
  walls[2].body = love.physics.newBody( world, right_wall_x, right_wall_y, "static" )
  walls[2].shape = love.physics.newRectangleShape( right_wall_width, right_wall_height )
  walls[2].fixture = love.physics.newFixture( walls[2].body, walls[2].shape, 1 )
  walls[2].fixture:setUserData( "right_wall" )

  --  create floor  --
  floor_width = 12 * square_width + 8
  floor_height = square_height
  floor_x = HALF_WIDTH  - 4
  floor_y = 23 * square_width - floor_height / 2 + half_square_width
  walls[3] = {}
  walls[3].body = love.physics.newBody( world, floor_x, floor_y, "static" )
  walls[3].shape = love.physics.newRectangleShape( floor_width, floor_height )
  walls[3].fixture = love.physics.newFixture( walls[3].body, walls[3].shape, 1 )
  walls[3].fixture:setUserData( "floor" )


  --  bar --
  bar_width = 11 * square_width
  bar_height = square_width
  bar_x = HALF_WIDTH - bar_width / 2
  bar_y = 10 * square_width - bar_height / 2 - 5
  bar_r = 255
  bar_g = 0
  bar_b = 0

  --  MENUS AND TEXT CONFIGING  --
  score_font_size = 20
  score_font = love.graphics.newFont( "/Resources/Fonts/8bw.ttf", score_font_size )

  --  timeRemaining timer   --
  gameTimeElapsed = 0
  showgameTimeElapsed = false
  game_time_text_x = love.graphics.getWidth() * 9 / 20
  game_time_text_y = love.graphics.getHeight() * 1 / 10
  game_time_text = love.graphics.newText( score_font, tostring( gameTimeElapsed ) )

  --	make main menu button press text object 	--
  title_prefixes = {}
  table.insert( title_prefixes, "Regular" )
  table.insert( title_prefixes, "Inconspicuous" )
  table.insert( title_prefixes, "Normal" )
  table.insert( title_prefixes, "" )
  table.insert( title_prefixes, "Danger" )
  table.insert( title_prefixes, "Plain old" )
  table.insert( title_prefixes, "Insubordinate" )
  table.insert( title_prefixes, "Hazard" )
  table.insert( title_prefixes, "Unfortunate" )

  title_prefix = ""
  title_postfix = " Tetris"

	--	make title prefix text object 	--
	title_prefix_text = love.graphics.newText( score_font, title_prefix )
	title_prefix_text_x = love.graphics.getWidth() *  3 / 10
	title_prefix_text_y = love.graphics.getHeight() * 2 / 10

	--	make title postfix text object 	--
	title_postfix_text = love.graphics.newText( score_font, title_postfix )
	title_postfix_text_x = love.graphics.getWidth() *  4 / 10
	title_postfix_text_y = love.graphics.getHeight() * 2 / 10 + score_font_size

		--	make main menu text object 	--
	main_menu_button_press_text = love.graphics.newText( score_font, "press return" )
	main_menu_button_press_text_x = love.graphics.getWidth() *  4 / 10
	main_menu_button_press_text_y = love.graphics.getHeight() * 7 / 10

		--	make game begin player text object 	--
	game_intro_text = love.graphics.newText( score_font, "GameBEGIN" )
	game_intro_text_x = love.graphics.getWidth() *  4 / 10 - half_square_width
	game_intro_text_y = love.graphics.getHeight() * 2 / 10

  --	make game outro text 	--
  winner_text = love.graphics.newText( score_font, winner_text_string )
  winner_text_x = HALF_WIDTH  - ( winner_text:getWidth() / 2 )
  winner_text_y = HALF_HEIGHT

  winner_text_color_r = 0
  winner_text_color_g = 255
  winner_text_color_b = 0

  inMainMenu = true
  isStartOfNewGame = false
  isNewGame = false
  gameInProgress = false
  gameWon = false

  gameIntroTime = 1
  gameOutroTime = 5
  gameTime = 60 * 10

  gameIntroTimeRemaining = 0
  gameTimeElapsed = 0
  gameOutroTimeRemaining = 0

  gameIntroTimerStarted = false
  gameTimerStarted = false
  gameOutroTimerStarted = false

  new_tetromino_timer_started = false
  initial_time_until_new_tetromino = 10 + 1
  time_until_new_tetromino = 0
  time_until_new_tetromino_text = love.graphics.newText( score_font, "" )
  time_until_new_tetromino_text_x = love.graphics.getWidth() * 5 / 10 - half_square_width
  time_until_new_tetromino_text_y = love.graphics.getHeight() * 1 / 10

  score_text = love.graphics.newText( score_font, "" )
  score_text_x = 30
  score_text_y = 60
  --  collision callback debug text   --
  collision_text = ""
  persisting = 0

  bar_collided = false
  floor_destroyed = false

  score = 500


end

function love.update( dt )
  world:update( dt )
  	if inMainMenu then
  		showMainMenu = true
  		if cleanedUp == false then
  			resetAll()
  			cleanedUp = true
  		end
  	end
  	if isStartOfNewGame then
      time_until_new_tetromino = initial_time_until_new_tetromino
      score = 500
  		showGameIntro = true
  		if gameIntroTimerStarted == false then
  			gameIntroTimerStarted = true
  			gameIntroTimeRemaining = gameIntroTime
  		end
  		gameTimeElapsed = 0
      updateGameTimeText()
      updateScoreText()
      updateTimeUntilNewTetrominoText()
  		gameTimerStarted = false
  		gameIntroTimeRemaining = gameIntroTimeRemaining - dt
  		if gameIntroTimeRemaining <= 0 then
  			isStartOfNewGame = false
  			showGameIntro = false
  			gameInProgress = true
  			showGameIntro = false
  			newTetromino()
  		end
      showGameElements = true
  	end
  	if gameInProgress then
      if bar_collided then
        --calculateFinalScore()
        if floor_destroyed == false then
          floor_destroyed = true
          walls[3].body:setType( "dynamic" )
        end
        gameInProgess = false
        isEndOfGame = true
      end
      if #tetrominos >= 1 then
        checkKeyPresses( dt )
      end
      checkTetrominosForBarCollision()
      calculateScore()
      updateScoreText()
  		if gameTimerStarted == false then
  			gameTimerStarted = true
  			gameTimeElapsed = 0
  		end
      if new_tetromino_timer_started == false then
        new_tetromino_timer_started = true
        time_until_new_tetromino = initial_time_until_new_tetromino
      end
  		gameTimeElapsed = gameTimeElapsed + dt
      updateGameTimeText()
      time_until_new_tetromino = time_until_new_tetromino - dt
      updateTimeUntilNewTetrominoText()
      if time_until_new_tetromino <= 1 then
        newTetromino()
        time_until_new_tetromino = initial_time_until_new_tetromino
      end
  	end
  	if isEndOfGame then
  		prepareGameOutro()
  		showGameOutro = true
  		if gameOutroTimerStarted == false then
  			gameOutroTimerStarted = true
  			gameOutroTimeRemaining = gameOutroTime
  		end
  		gameOutroTimeRemaining = gameOutroTimeRemaining - dt
  		if gameOutroTimeRemaining <= 0 then
  			isEndOfGame = false
  			showGameOutro = false
  			cleanedUp = false
  			inMainMenu = true
        showgameTimeElapsed = false
        showGameElements = false
        resetAll()
  		end
  	end

  	if string.len( collision_text ) > ( love.graphics.getHeight() * 2 ) then
          collision_text = ""
      end
end

function updateScoreText()
  score_text:set( "points  " .. tostring( score ) )
end

function updateGameTimeText()
  game_time_text:set( tostring( math.floor( gameTimeElapsed ) ) )
end

function updateTimeUntilNewTetrominoText()
  time_until_new_tetromino_text:set( tostring( math.floor( time_until_new_tetromino ) ) )
end

function resetAll()
	gameIntroTimeRemaining = gameIntroTime
	gameTimeElapsed = 0
	gameOutroTimeRemaining = 0
  time_until_new_tetromino = 0

	deleteAllTetrominos()
	resetScore()

	gameOutroTimerStarted = false
  new_tetromino_timer_started = false
	showGameElements = false
  isStartOfNewGame = false
  gameInProgress = false

  bar_collided = false
  floor_destroyed = false

	randomizeName()
  resetFloor()

  score = 0
end

function love.draw()
  	love.graphics.setColor( 255, 255, 255, 100 )
  	love.graphics.print(collision_text, 10, 10)

  	if showGameElements then
      if showGameOutro then
        drawGameOutro()
      end
      drawScoreText()
      drawBar()
      drawAllTetrominos()
      drawBoundaries()
      drawTimeUntilNewTetromino()
  	end
  	if showMainMenu then
  		drawMainMenu()

  	end
  	if showGameIntro then
  		drawGameIntro()
  	end
  	if showRoundIntro then
  		drawRoundIntro()
  	end
end

function calculateScore()
  score = math.floor( 501 - gameTimeElapsed + #tetrominos * 50 )
end

function drawAllTetrominos()
  for t = 1, #tetrominos do
  	love.graphics.setColor( 255, 255, 255 )
  	if t == active_tetromino then
  		love.graphics.setColor( 0, 0, 255 )
  	end
    for s = 1, 4 do
      love.graphics.polygon( "fill", tetrominos[t].body:getWorldPoints( tetrominos[t].shapes[s]:getPoints() ) )
    end
  end
end

function drawBar()
  love.graphics.setColor( bar_r, bar_g, bar_b )
  love.graphics.rectangle( "fill", bar_x, bar_y, bar_width, bar_height )
end

function drawScoreText()
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.draw( score_text, score_text_x, score_text_y )
end

function drawTimeUntilNewTetromino()
  love.graphics.setColor( 255, 255, 255 )
  local scale_x = 1
  local scale_y = 1
  if time_until_new_tetromino <= 4 then
    local redness = time_until_new_tetromino - math.floor( time_until_new_tetromino ) * 255
    love.graphics.setColor( 255, redness, redness )
    scale_x = 4 - time_until_new_tetromino + 1
    scale_y = 4 - time_until_new_tetromino + 1
  end
  love.graphics.draw( time_until_new_tetromino_text, time_until_new_tetromino_text_x, time_until_new_tetromino_text_y, 0, scale_x, scale_y )
end

function drawBoundaries()
  drawWalls()
  drawFloor()
end

function drawWalls()
  love.graphics.setColor( 255, 255, 255 )
  for i = 1, 2 do
    love.graphics.polygon( "fill", walls[i].body:getWorldPoints( walls[i].shape:getPoints() ) )
  end
end

function drawFloor()
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.polygon( "fill", walls[3].body:getWorldPoints( walls[3].shape:getPoints() ) )
end

function newTetromino()
  --  pick a random number between 1 and the number of tetromino templates  --
  math.randomseed( os.time() )
  math.random(); math.random(); math.random();
  tetromino_type =  4 -- math.random( 1, #tetromino_templates )

  new_tetromino = {}
  new_tetromino.body = love.physics.newBody( world, NEW_TETROMINO_X, NEW_TETROMINO_Y, "dynamic" )
  new_tetromino.shapes = {}
  new_tetromino.fixtures = {}
  for i = 1, 4 do
    local new_tetromino_x = tetromino_templates[tetromino_type].squares[i][1]
    local new_tetromino_y = tetromino_templates[tetromino_type].squares[i][2]
    new_tetromino.shapes[i] = love.physics.newRectangleShape( new_tetromino_x, new_tetromino_y, square_width, square_height )
    new_tetromino.fixtures[i] = love.physics.newFixture( new_tetromino.body, new_tetromino.shapes[i], 1 )
    new_tetromino.fixtures[i]:setUserData( "tetromino_num: " .. tostring( #tetrominos + 1 ) .. ", block: " .. tostring(i) )
  end
  table.insert( tetrominos, new_tetromino )
  active_tetromino = #tetrominos
end

--  CONTROLS  --
function checkKeyPresses( dt )
  if inMainMenu == false then
    if love.keyboard.isDown( "up" ) then
    	tetrominos[active_tetromino].body:setLinearVelocity( 0, -dy )
    end
    if love.keyboard.isDown( "down" ) then
      tetrominos[active_tetromino].body:setLinearVelocity( 0, dy )
    end
    if love.keyboard.isDown( "left" ) then
      tetrominos[active_tetromino].body:setAngularVelocity( -dr )
    end
    if love.keyboard.isDown( "right" ) then
      tetrominos[active_tetromino].body:setAngularVelocity( dr )
    end
  end
end

function love.keypressed( key )
  if( key == "space" and ( inMainMenu == false ) and ( gameInProgress == true ) and ( time_until_new_tetromino < 8 ) ) then
    newTetromino()
    time_until_new_tetromino = initial_time_until_new_tetromino
  end
  --[[
  if( key == "2" ) then
  	changeActiveTetromino( 1 )
  end
  if( key == "1" ) then
  	changeActiveTetromino( -1 )
  end
  ]]
  if ( key == "return" ) then
    if inMainMenu then
      inMainMenu = false
      showMainMenu = false
      isStartOfNewGame = true
    end
  end
end

function checkTetrominosForBarCollision()
  for t = 1, #tetrominos do
    if t ~= active_tetromino then
      for b = 1, 4 do
        vertices = { tetrominos[t].body:getWorldPoints( tetrominos[t].shapes[b]:getPoints() ) }
        if vertices[2] < ( bar_y + bar_height ) then
          bar_collided = true
        end
        if vertices[4] < ( bar_y + bar_height ) then
          bar_collided = true
        end
      end
    end
  end
end



function drawMainMenu()
	love.graphics.setColor( 255, 0, 0 )
	love.graphics.draw( title_prefix_text, title_prefix_text_x, title_prefix_text_y )
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.draw( title_postfix_text, title_postfix_text_x, title_postfix_text_y )
	love.graphics.setColor( 100, 100, 100 )
	love.graphics.draw( main_menu_button_press_text, main_menu_button_press_text_x, main_menu_button_press_text_y )
end

function resetScore()
	score = 500
end

function resetFloor()
  walls[3].body:setType( "static" )
  walls[3].body:setAngle( 0 )
  walls[3].body:setPosition( floor_x, floor_y )
end
--[[
function changeActiveTetromino( direction )
	active_tetromino = active_tetromino + direction
	if active_tetromino < 1 then
		active_tetromino = 1
	end
	if active_tetromino >= #tetrominos then
		active_tetromino = #tetrominos
	end
end
]]

function deleteAllTetrominos()
  for t = 1, #tetrominos do
    tetrominos[t].body:destroy()
  end
  tetrominos = {}
end

function prepareGameOutro()
  winner_text:set( "YOU WIN" )
  --if score above some point win_quality = " WIN PERFECTLY"
  if score >= 1500 then
    winner_text:set( "YOU ARE A GOD" )
  end
  --if score below some point win_quality = " ARE PRETTY OKAY AT THIS"
  if score then
  end
  --if score below some point win_quality = " SUCK"
  --if score below some point win_quality = " ARE GARBAGE"
  end
end

function drawGameIntro()
	love.graphics.draw( game_intro_text, game_intro_text_x, game_intro_text_y )
end

function drawGameOutro()
	--	draw winner message	--
  winner_text_x = HALF_WIDTH  - ( winner_text:getWidth() / 2 )
	love.graphics.setColor( winner_text_color_r, winner_text_color_g, winner_text_color_b )
	love.graphics.draw( winner_text, winner_text_x, winner_text_y )
end

function drawGameTimeText()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.draw( game_time_text, game_time_text_x, game_time_text_y )
end

function beginContact( a, b, coll )
    local x, y = coll:getNormal()
    collision_text = collision_text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end

function endContact( a, b, coll )
  persisting = 0
  collision_text = collision_text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end

function preSolve( a, b, coll )
    if persisting == 0 then    -- only say when they first start touching
        collision_text = collision_text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        collision_text = collision_text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve( a, b, coll, normalimpulse, tangentimpulse )
end

function randomizeName()
	--	select a prefix at random 	--
	math.randomseed(os.time())
	math.random(); math.random(); math.random()

	title_prefix = title_prefixes[ math.random( 1, #title_prefixes ) ]

	title_postfix = " Tetris"
	--	small chance of Dong instead of pong 	--
	if( love.math.random() <= 0.1 ) then
		title_postfix = " Teetris"
	end

	title_prefix_text:set( title_prefix )
	title_postfix_text:set( title_postfix )
end
