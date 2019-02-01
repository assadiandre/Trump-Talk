local composer = require( "composer" )
local scene = composer.newScene()
--------------------------------------------

function scene:create( event )
	local screenW, screenH = display.contentWidth,display.contentHeight
	local sceneGroup = self.view

	local funFacts = {
	"Donald Trump has gone bankrupt more than 4 times",
	"Donald Trump has been married 3 times",
	"Donald Trump has never smoked or drank, but has his own line of vodka",
	"Donald Trump has controlling interest in over 500 different buisnesses", 
	"Trump has an estimated net worth of 3.7 billion dollars", 
	"Donald Trump is the richest president to ever live", 
	"In the second-grade, trump punched his music teacher in the face.", 
	"Donald Trump ran for president in 2000, he wanted Oprah Winfrey as his running mate.", 
	"The U.S. Justice Department once filed a lawsuit against the Trump organization for discriminating against African Americans.", 
	"Approximately 200 Polish workers who were in the U.S. illegally helped build Trump Tower.",
	"In 2004, Trump claimed that all of the women from his show, The Apprentice, flirted with him, but, he said, 'that's to be expected.'",
	"As of 2016, at least 24 women have accused Donald Trump of inappropriate sexual behavior in several incidents over the last 30 years.",
	"At 70 years old, Trump is the oldest person ever to assume the presidency.",
	"Trump has made cameo appearances in 12 films and 14 TV series. He has been nominated for two Emmy Awards",
	"Trump once tweeted that vaccines, if administered too quickly in succession, have led to the increase in autism",
}

	local background = display.newImage("images/pattern.jpg",screenW/2,screenH/2 )
	background.xScale = 0.8
	background.yScale = 0.8

	local sheetData = { width=402, height=363, numFrames=4, sheetContentWidth=1608, sheetContentHeight=363 }
	local sheet = graphics.newImageSheet( "images/load.png", sheetData )

	local sequenceData =
	{name="loading",start=1,count=4,time=1000,loopCount = 0 }
 
	local load = display.newSprite( sheet, sequenceData )
	load.x = screenW/2 
	load.y = screenH/2
	load.xScale = 0.7
	load.yScale = 0.7
	load:setSequence("loading")
	load:play()

	local funFactOptions = {
		text= funFacts[math.random(1,15)],
		x=screenW/2,
		y=screenH/2,
		width=250,
		align="center",
		font="Comic",
		fontSize=18
	}

	local funfact = display.newText(funFactOptions)
	funfact:setFillColor(0,0,0)

	local function goToNextScene()
		composer.gotoScene("level1","slideUp",1000)
	end
	timer.performWithDelay(4000,goToNextScene,1)

	sceneGroup:insert(background)
	sceneGroup:insert(load)
	sceneGroup:insert(funfact)

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