----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local options =
{
	channel = 1, --The channel (between 1 and 32) tou want to play the audio on
	loops =  -1, --"-1" is infinite, "0" is not at all, "1" is loop once, so "2" is play twice etc.
}


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
function playgame1( event )
	if event.phase == "ended" then
	storyboard.gotoScene("game1")
	end
end

function playgame2( event )
	if event.phase == "ended" then
	storyboard.gotoScene("game2")
	end
end

function playgame3( event )
	if event.phase == "ended" then
	storyboard.gotoScene("game3")
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	background = display.newImageRect( "sceneBG.png", 768,1024)
	background.x = display.contentWidth/2
	background.y = display.contentHeight/2
	group:insert(background)

	message = display.newText( "Main Menu", 250, 250, nil, 60)
	message.x = display.contentWidth/2
	message.y = display.contentHeight/12
	group:insert(message)

	game1 = display.newImageRect( "game1.png", 241,48)
	game1.x = display.contentWidth/2
	game1.y = display.contentHeight* 4/12
	group:insert(game1)

	game2 = display.newImageRect( "game2.png", 241,48)
	game2.x = display.contentWidth/2
	game2.y = display.contentHeight* 6/12
	group:insert(game2)

	game3 = display.newImageRect( "game3.png", 241,48)
	game3.x = display.contentWidth/2
	game3.y = display.contentHeight* 8/12
	group:insert(game3)


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

	-- audio

	sound1 = audio.loadSound("loop1.wav")
	audio.play(sound1, options)
	

	game1:addEventListener ("touch", playgame1)
	game2:addEventListener ("touch", playgame2)
	game3:addEventListener ("touch", playgame3)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	audio.stop()
	sound1 = nil

	
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