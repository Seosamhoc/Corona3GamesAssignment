----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
storyboard.isDebug = true
local scene = storyboard.newScene()
local physics = require("physics")
physics.start() 
physics.pause()

local background
local message
local mainmenu
local ground
local platform1
local platform2
local platform3
local r1
local r2
local r3
local r4
local youwin
local youlose






w , h = display.contentWidth , display.contentHeight
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

function removePlatform1(event)
	display.remove(platform1)
end

function removePlatform2(event)
	display.remove(platform2)
end

function removePlatform3(event)
	display.remove(platform3)
end

function goBack(event)
	if r4.trans then transition.cancel( r4.trans ) end
	r4.trans = transition.to(r4,{x=0,h*20/24-w/16,time=10000, onComplete=goForward})
		if type (platform1.setFillColor) ~= "function" 
		and type (platform2.setFillColor) ~= "function"
		and type (platform3.setFillColor) ~= "function"
		and youwin.alpha ~= 1 then
			youlose.alpha=1
		end
end

function goForward(event)
	if r4.trans then transition.cancel( r4.trans ) end
	r4.trans = transition.to(r4,{x=w,h*20/24-w/16,time=10000, onComplete=goBack})

	if type (platform1.setFillColor) ~= "function" 
		and type (platform2.setFillColor) ~= "function"
		and type (platform3.setFillColor) ~= "function"
		and youwin.alpha ~= 1	 then
			youlose.alpha=1
		end
end

function onLocalCollision( self, event )
	if ( event.phase == "ended" ) then
		audio.play(sound2)
		print( self.myName .. ": collision ended with " .. event.other.myName )
		display.remove(self)
		youlose.alpha=0
		youwin.alpha= 1	
		
		if type (platform1.setFillColor) == "function" then
			display.remove(platform1)
		end
		if type (platform2.setFillColor) == "function" then
			display.remove(platform2)
		end
		if type (platform3.setFillColor) == "function" then
			display.remove(platform3)
		end

	end
end

local function replayGame(event)
	storyboard.reloadScene()
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

	message = display.newText( "Game 2", 250, 250, nil, 60)
	message.x = w/2
	message.y = h/12
	group:insert(message)

	mainmenu = display.newImageRect( "mainmenu.png", 45,48)
	mainmenu.x = w/24
	mainmenu.y = h* 23/24
	group:insert(mainmenu)

	ground = display.newRect(0,h*20/24,w,10)
	ground:setFillColor(0,255,0)
	group:insert(ground)

	platform1 = display.newRect(w/6, h * 6/24, w/7, h/60)
	physics.addBody(platform1,"kinematic")
	platform1:setFillColor(0,0,255)
	group:insert(platform1)

	platform2 = display.newRect(w * 3/6, h * 6/24, w/7, h/60)
	physics.addBody(platform2,"kinematic")
	platform2:setFillColor(0,0,255)
	group:insert(platform2)

	platform3 = display.newRect(w * 5/6, h * 6/24, w/7, h/60)
	physics.addBody(platform3,"kinematic")
	platform3:setFillColor(0,0,255)
	group:insert(platform3)

	r1 = display.newRect(w/6+w/112, h * 6/24 -w/8,w/8,w/8)
	r1:setFillColor(255,0,0)
	physics.addBody(r1,"dynamic")
	group:insert(r1)
	r1.myName = "Big Bad Block 1"

	r2 = display.newRect(w* 3/6+w/112, h * 6/24 -w/8,w/8,w/8)
	r2:setFillColor(255,0,0)
	physics.addBody(r2,"dynamic")
	group:insert(r2)
	r2.myName = "Big Bad Block 2"

	r3 = display.newRect(w* 5/6+w/112, h * 6/24 -w/8,w/8,w/8)
	r3:setFillColor(255,0,0)
	physics.addBody(r3,"dynamic")
	group:insert(r3)
	r3.myName = "Big Bad Block 3"

	r4 = display.newRect(0, h*20/24-w/16, w/16, w/16)
	r4:setFillColor(255,0,0)
	group:insert(r4)
	physics.addBody(r4,"kinematic")
	r4.trans = goForward()
	r4.collision = onLocalCollision
	r4.myName = "Red dude"

	youwin = display.newText( "YOU WIN!", 250, 250, nil, 60)
	youwin.x = w/2
	youwin.y = h/2
	youwin.alpha= 0
	group:insert(youwin)

	youlose = display.newText( "YOU LOSE!", 250, 250, nil, 60)
	youlose.x = w/2
	youlose.y = h/2
	youlose.alpha= 0
	group:insert(youlose)

	-----------------------------------------------------------------------------
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	physics.start()
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	--colour of text
	message:setTextColor( 255,0,0)

	mainmenu:addEventListener ("touch", returnmainmenu)
	if type (platform1.setFillColor) == "function" then
	platform1:addEventListener("tap", removePlatform1)
	end
	if type (platform2.setFillColor) == "function" then
		platform2:addEventListener("tap", removePlatform2)
	end
	if type (platform3.setFillColor) == "function" then
		platform3:addEventListener("tap", removePlatform3)
	end
	if type (r4.setFillColor) == "function" then
		r4:addEventListener( "collision", r4 )
	end

	sound2 = audio.loadSound("boing_wav.wav")

	storyboard.removeAll()

	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	mainmenu:removeEventListener ("touch", returnmainmenu)
	if type (platform1.setFillColor) == "function" then
		platform1:removeEventListener("tap", removePlatform1)
	end
	if type (platform2.setFillColor) == "function" then
		platform2:removeEventListener("tap", removePlatform2)
	end
	if type (platform3.setFillColor) == "function" then
		platform3:removeEventListener("tap", removePlatform3)
	end
	if type (r4.setFillColor) == "function" then
		r4:removeEventListener( "collision", r4 )
	end





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