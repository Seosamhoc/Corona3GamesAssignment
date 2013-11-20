----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local w , h = display.viewableContentWidth , display.viewableContentHeight

local blahx , blahy = w/2 , h/2
local blah
local ground

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
local function returnmainmenu( event )
	if event.phase == "ended" then
	storyboard.gotoScene("mainmenu")
	end
end

function moveright( event )
	if event.phase == "ended" then
		if blahx<w-w/5 then
			transition.to(blah,{x=w/10,y=0,time=200, delta=true})
			blahx=blahx+w/10
		 	blah:setFillColor(255,0,255)
		else
			transition.to(blah,{x=w-w/20,y=y,time=180})
			blahx=w-w/5
			
		end
	end
end

function moveleft( event )
	if event.phase == "ended" then
		if blahx>0 then
			transition.to(blah,{x=0-w/10,y=0,time=200, delta=true})
			blahx=blahx-w/10
		 	blah:setFillColor(0,255,255)
		 	print(blahx)
		else
			transition.to(blah,{x=w/20,y=y,time=200})
			blahx=0
		end
	end
end

function moveup( event )
	if event.phase == "ended" then
		if blahy>=display.topStatusBarContentHeight+w/5 then
			transition.to(blah,{x=0,y=-w/10,time=200, delta=true})
			blahy=blahy-w/10
		 	blah:setFillColor(0,0,255)
		else
			transition.to(blah,{x=x,y=display.topStatusBarContentHeight+w/20,time=180})
			blahy=display.topStatusBarContentHeight+w/20
		end
	end
end

function movedown( event )
	if event.phase == "ended" then
		if blahy<((h*20/24)-w/5) then
			transition.to(blah,{x=0,y=w/10,time=200, delta=true})
			blahy=blahy+w/10
		 	blah:setFillColor(100,100,100)
		 else
		 	transition.to(blah,{x=x,y=((h*20/24)-w/20),time=180})
		 	blahy=((h*20/24)-w/20)
		 end
	end
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

	message = display.newText( "Game 1", 250, 250, nil, 60)
	message.x = w/2
	message.y = h/12
	group:insert(message)

	mainmenu = display.newImageRect( "mainmenu.png", 45,48)
	mainmenu.x = w/24
	mainmenu.y = h* 23/24
	group:insert(mainmenu)


	rightarrow = display.newImageRect( "rightarrow.png", 35,35)
	rightarrow.x = w* 23/24
	rightarrow.y = h* 22/24
	group:insert(rightarrow)

	leftarrow = display.newImageRect( "leftarrow.png", 35,35)
	leftarrow.x = w* 19/24
	leftarrow.y = h* 22/24
	group:insert(leftarrow)

	downarrow = display.newImageRect( "downarrow.png", 35,35)
	downarrow.x = w* 21/24
	downarrow.y = h* 23/24
	group:insert(downarrow)

	uparrow = display.newImageRect( "uparrow.png", 35,35)
	uparrow.x = w* 21/24
	uparrow.y = h* 21/24
	group:insert(uparrow)

	ground = display.newRect(0,h*20/24,w,10)
	ground:setFillColor(0,255,0)
	group:insert(ground)

	blah = display.newRect(blahx,blahy,w/10,w/10)
	blah:setFillColor(0,0,255)
	group:insert(blah)
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

	--return to mainmenu event listener
	mainmenu:removeEventListener ("touch", returnmainmenu)
	mainmenu:addEventListener ("touch", returnmainmenu)


	--rightarrow event listener
	rightarrow:removeEventListener ("touch", moveright)
	rightarrow:addEventListener ("touch", moveright)

	--leftarrow event listener
	leftarrow:removeEventListener ("touch", moveleft)
	leftarrow:addEventListener ("touch", moveleft)

	--downarrow event listener
	downarrow:removeEventListener ("touch", movedown)
	downarrow:addEventListener ("touch", movedown)

	--uparrow event listener
	uparrow:removeEventListener ("touch", moveup)
	uparrow:addEventListener ("touch", moveup)



	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
			--return to mainmenu event listener
	mainmenu:removeEventListener ("touch", returnmainmenu)


	--rightarrow event listener
	rightarrow:removeEventListener ("touch", moveright)

	--leftarrow event listener
	leftarrow:removeEventListener ("touch", moveleft)

	--downarrow event listener
	downarrow:removeEventListener ("touch", movedown)

	--uparrow event listener
	uparrow:removeEventListener ("touch", moveup)


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