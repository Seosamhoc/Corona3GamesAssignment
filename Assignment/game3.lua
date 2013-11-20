----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


-- pre declare variables
w , h = display.contentWidth , display.contentHeight

local background
local message
local mainmenu
local house
local house2
local house3
local shadowhouse
local shadowhouse2
local shadowhouse3
----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function returnmainmenu( event )
	if event.phase == "ended" then
	storyboard.gotoScene("mainmenu")
	end
end


local function hasCollided( obj1, obj2 )
   if ( obj1 == nil ) then  --make sure the first object exists
      return false
   end
   if ( obj2 == nil ) then  --make sure the other object exists
      return false
   end

   local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
   local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
   local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
   local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

   return (left or right) and (up or down)
end

local function startDrag( event )
   local target = event.target 
   local phase = event.phase

   if ( event.phase == "began" ) then
      local parent = target.parent
      display.getCurrentStage():setFocus( target ) 
      target.isFocus = true
      target.x0 = event.x - target.x
      target.y0 = event.y - target.y
      target.xStart = target.x
      target.yStart = target.y
      target:toFront()
   elseif ( target.isFocus ) then
      if ( phase == "moved" ) then
         target.x = event.x - target.x0
         target.y = event.y - target.y0
		if ( hasCollided( event.target, shadowhouse ) ) then
			--snap in place
			transition.to( event.target, {time=250, x=shadowhouse.x, y=shadowhouse.y} )
			audio.play(sound2)
			phase="cancelled"
		else
		end
 	  elseif ( phase == "ended" or phase == "cancelled" ) then
		display.getCurrentStage():setFocus( nil )
  		target.isFocus = false


 	  end
 	end
   return true
end


local function startDrag2( event )
   local target = event.target 
   local phase = event.phase

   if ( event.phase == "began" ) then
      local parent = target.parent
      display.getCurrentStage():setFocus( target ) 
      target.isFocus = true
      target.x0 = event.x - target.x
      target.y0 = event.y - target.y
      target.xStart = target.x
      target.yStart = target.y
      target:toFront()
   elseif ( target.isFocus ) then
      if ( phase == "moved" ) then
         target.x = event.x - target.x0
         target.y = event.y - target.y0
		if ( hasCollided( event.target, shadowhouse2 ) ) then
			--snap in place
			transition.to( event.target, {time=250, x=shadowhouse2.x, y=shadowhouse2.y} )
			audio.play(sound2)
			phase="cancelled"
		else
		end
 	  elseif ( phase == "ended" or phase == "cancelled" ) then
		display.getCurrentStage():setFocus( nil )
  		target.isFocus = false


 	  end
 	end
   return true
end

local function startDrag3( event )
   local target = event.target 
   local phase = event.phase

   if ( event.phase == "began" ) then
      local parent = target.parent
      display.getCurrentStage():setFocus( target ) 
      target.isFocus = true
      target.x0 = event.x - target.x
      target.y0 = event.y - target.y
      target.xStart = target.x
      target.yStart = target.y
      target:toFront()
   elseif ( target.isFocus ) then
      if ( phase == "moved" ) then
         target.x = event.x - target.x0
         target.y = event.y - target.y0
		if ( hasCollided( event.target, shadowhouse3 ) ) then
			--snap in place
			transition.to( event.target, {time=250, x=shadowhouse3.x, y=shadowhouse3.y} )
			audio.play(sound2)
			phase="cancelled"
		else
		end
 	  elseif ( phase == "ended" or phase == "cancelled" ) then
		display.getCurrentStage():setFocus( nil )
  		target.isFocus = false


 	  end
 	end
   return true
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	background = display.newImageRect( "sceneBG.png", 768,1024)
	background.x = w/2
	background.y = h/2
	group:insert(background)

	message = display.newText( "Game 3", 250, 250, nil, 60)
	message.x = w/2
	message.y = h/12
	group:insert(message)

	mainmenu = display.newImageRect( "mainmenu.png", 45,48)
	mainmenu.x = w/24
	mainmenu.y = h* 23/24
	group:insert(mainmenu)

	house = display.newImage( "house_red.png" )
	house.x = 160
	house.y = 300
	group:insert(house)
	house.myName = "house"

	shadowhouse = display.newImage( "house_red.png" )
	shadowhouse.x = 300
	shadowhouse.y = 300
	shadowhouse:setFillColor(50,50,50)
	shadowhouse.alpha = 0.75
	group:insert(shadowhouse)
	shadowhouse.myName = "house"
	shadowhouse.collision = onLocalCollision

	house2 = display.newImage( "ball_blue.png" )
	house2.x = 160
	house2.y = 400
	group:insert(house2)
	house2.myName = "house2"

	shadowhouse2 = display.newImage( "ball_blue.png" )
	shadowhouse2.x = 300
	shadowhouse2.y = 400
	shadowhouse2:setFillColor(50,50,50)
	shadowhouse2.alpha = 0.75
	group:insert(shadowhouse2)
	shadowhouse2.myName = "house2"
	shadowhouse2.collision = onLocalCollision

	house3 = display.newImage( "soda_can.png" )
	house3.x = 160
	house3.y = 500
	group:insert(house3)
	house3.myName = "house3"

	shadowhouse3 = display.newImage( "soda_can.png" )
	shadowhouse3.x = 300
	shadowhouse3.y = 500
	shadowhouse3:setFillColor(50,50,50)
	shadowhouse3.alpha = 0.75
	group:insert(shadowhouse3)
	shadowhouse3.myName = "house3"
	shadowhouse3.collision = onLocalCollision
	-----------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	storyboard.removeAll()
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)

	--colour of text
	message:setTextColor( 255,0,0)

	sound2 = audio.loadSound("boing_wav.wav")

	--event listeners
	mainmenu:addEventListener ("touch", returnmainmenu)
	house:addEventListener( "touch", startDrag )
	shadowhouse:addEventListener( "collision", shadowhouse )
	house2:addEventListener( "touch", startDrag2 )
	shadowhouse2:addEventListener( "collision", shadowhouse2 )
	house3:addEventListener( "touch", startDrag3 )
	shadowhouse3:addEventListener( "collision", shadowhouse3 )
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	--remove event listeners
	mainmenu:removeEventListener ("touch", returnmainmenu)
	house:removeEventListener( "touch", startDrag )
	shadowhouse:removeEventListener( "collision", shadowhouse )
	house2:removeEventListener( "touch", startDrag2 )
	shadowhouse2:removeEventListener( "collision", shadowhouse2 )
	house3:removeEventListener( "touch", startDrag3 )
	shadowhouse3:removeEventListener( "collision", shadowhouse3 )
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene