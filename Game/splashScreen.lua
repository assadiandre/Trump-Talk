local composer = require( "composer" )
local scene = composer.newScene()
--------------------------------------------

function scene:create( event )
	local screenW, screenH = display.contentWidth,display.contentHeight
	local sceneGroup = self.view

	composer.loadScene("menu")
	local logo = display.newImage("images/logo.png",screenW/2,screenH/2 -5)

	local load = display.newRect(90,logo.y + 154,2,3)
	load:setFillColor(0.7,0.7,0.7)
	load.alpha = 0.7
	load.anchorX = 0

	local loadBack = display.newRect(screenW/2,logo.y + 154,140,3)
	loadBack:setFillColor(0,0,0,0)
	loadBack.stroke = {0.6,0.6,0.6}
	loadBack.strokeWidth = 1

	local m = 0

	timer.performWithDelay(10,function() m = m + 1 load.width = 2*m end,70)
	timer.performWithDelay(3000,function() composer.gotoScene("menu","fade",300) end,1)
	timer.performWithDelay(4500,function() composer.removeScene("splashScreen") end,1)
	sceneGroup:insert(logo)
	sceneGroup:insert(load)
	sceneGroup:insert(loadBack)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene