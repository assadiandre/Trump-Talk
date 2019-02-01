local composer = require( "composer" )
local scene = composer.newScene()

local music = audio.loadStream("music.m4a")
audio.play(music,{channel=3,loops=-1})
audio.setVolume( 0.4, {channel=3 })

function scene:create( event )
	audio.resume()
	local widget = require( "widget" )
	local iap = require("iap_badger")
	local sceneGroup = self.view
	local settingsVar = 1

	local items =
	{
    { type = "image", value = { filename = "images/shareIcon.png", baseDir = system.ResourceDirectory, } },
    { type = "string", value = "Go Download the Best Donald Trump App!" },
    { type = "url", value = "https://itunes.apple.com/us/app/viewContentsUserReviews/id1217045026?ls=1&mt=8" }
	}

	local screenW = display.contentWidth 
	local screenH = display.contentHeight
	local actualHeight = display.actualContentHeight
	local name = {}
	local TVar = 0

	local background = display.newImage("images/background.png",screenW/2,screenH/2 )
	background.xScale = 0.8
	background.yScale = 0.8

	local trumpIcon = display.newImage("images/trump4.png",screenW/2 - 50,400)
	trumpIcon.xScale = 0.8
	trumpIcon.yScale = 0.8
	trumpIcon.rotation = -10

	local iconGroup = display.newGroup()

	local settings = display.newImage("images/icon1M.png",80,screenH/2 + 150)
	settings.xScale = 0.3
	settings.yScale = 0.3

	local buy = display.newImage("images/icon3M.png",245,screenH/2 + 150)
	buy.xScale = 0.3
	buy.yScale = 0.3

	local share = display.newImage("images/icon2M.png",screenW/2,screenH/2 + 150)
	share.xScale = 0.3
	share.yScale = 0.3

	local play = display.newImage("images/play.png",screenW/2,screenH/2)
	play.xScale = 0.6
	play.yScale = 0.6

	local nameGroup = display.newGroup()
	name[1] = display.newText("The",40,0,"SF Slapstick Comic",50)
	name[2] = display.newText("Donald",screenW/2 + 35,10,"SF Slapstick Comic",70)
	name[3] = display.newText("Trump",110,80,"SF Slapstick Comic",75)
	name[4] = display.newText("app",265,80,"SF Slapstick Comic",50)
	nameGroup:insert(name[1])
	nameGroup:insert(name[2])
	nameGroup:insert(name[3])
	nameGroup:insert(name[4])
	nameGroup.y = (screenH - actualHeight)/2 + 40

	local function randomTrans()
		transition.to(name[math.random(1,4)],{time=300,xScale=1.1,yScale=1.1,transition=easing.continuousLoop})
	end
	timer.performWithDelay(1000,randomTrans,0)

local infoScroll

	local function randomAppear()
		transition.to(trumpIcon,{time=1200,x=math.random(screenW/2 - 50,screenW/2 -20),rotation=math.random(-13,-7),transition=easing.continuousLoop})
	end
	timer.performWithDelay(2400,randomAppear,0)

	local function tapPlay()
		loadTap()
		transition.to(play,{time=50,xScale=0.55,yScale=0.55,onComplete=
			function()
			transition.to(play,{time=50,xScale=0.6,yScale=0.6})
			end})
		display.remove(infoScroll)
		infoScroll = nil
		timer.performWithDelay(150,function() 
		composer.loadScene( "level1")
		composer.gotoScene("load","crossFade",400)
		composer.removeScene("menu",false)
		end,1)
	end
	play:addEventListener("tap",tapPlay)

	iconGroup:insert(settings)
	iconGroup:insert(buy)
	iconGroup:insert(share)
	iconGroup.y = (actualHeight - screenH)/2 + 40

------Info Group-----------------------------------------------------
local infoGroup = display.newGroup()	
infoScroll = widget.newScrollView(
{top = 100,left = 10, width = 280, height = 160, scrollWidth = 600, scrollHeight = 800, listener = scrollListener} )
infoScroll.x = screenW/2 
infoScroll.y = screenH/2

local infoText = display.newImage("images/infoText.png",screenW/2 - 15,250)
infoText.xScale = 0.5
infoText.yScale = 0.5

local infoPlack = display.newImage("images/infoPage.png",screenW/2,screenH/2)
infoPlack.xScale = 0.7
infoPlack.yScale = 0.7
infoScroll:insert(infoText)
infoScroll:toFront()

local infoBack = display.newImage("images/back.png",screenW/2 - 109,screenH/2 + 102)
infoBack.xScale = 0.8 infoBack.yScale = 0.8

infoGroup:insert(infoPlack)
infoGroup:insert(infoScroll)
infoGroup:insert(infoBack)

local function tapInfoPlack() return true end
infoPlack:addEventListener("tap",tapInfoPlack)

local function tapInfoBack()
	transition.to(infoGroup,{time=500,alpha=0,transition=easing.outBack})
	settingsVar = 1
	loadTap()
end
infoBack:addEventListener("tap",tapInfoBack)
infoGroup.alpha = 0
------Settings Group-----------------------------------------------------	
local musicSet = "On"
local emojisSet = "On"

local settingsGroup = display.newGroup()

local settingsPlack = display.newImage("images/settings.png",screenW/2,screenH/2 )
settingsPlack.xScale = 0.7
settingsPlack.yScale = 0.7
local musicOff = display.newImage("images/off.png",screenW/2 - 100,screenH/2 - 55)
musicOff.xScale = 0.8 musicOff.yScale = 0.8
musicOff.alpha = 0
local musicOn = display.newImage("images/on.png",screenW/2 - 100,screenH/2 - 55)
musicOn.xScale = 0.8 musicOn.yScale = 0.8
musicOn.alpha = 1
local ex = display.newImage("images/x.png",screenW/2 - 100,screenH/2 -5 )
ex.xScale = 0.8 ex.yScale = 0.8
ex.alpha = 0
local check = display.newImage("images/check.png",screenW/2 - 100,screenH/2 -5)
check.xScale = 0.8 check.yScale = 0.8
local info = display.newImage("images/info.png",screenW/2 - 90,screenH/2 + 50 )
info.xScale = 0.8 info.yScale = 0.8
local contact = display.newImage("images/contact.png",screenW/2,screenH/2 + 50)
contact.xScale = 0.8 contact.yScale = 0.8
local restore = display.newImage("images/restore.png",screenW/2 + 90,screenH/2 + 50)
restore.xScale = 0.8 restore.yScale = 0.8
local exit = display.newImage("images/back.png",screenW/2 - 109,screenH/2 + 102)
exit.xScale = 0.8 exit.yScale = 0.8
local musicText = display.newText("Music "..musicSet,musicOff.x + 85,musicOff.y,"SF Slapstick Comic",20)
musicText:setFillColor(0,0,0)
local checkText = display.newText("Emojis "..emojisSet,ex.x + 90,ex.y,"SF Slapstick Comic",20)
checkText:setFillColor(0,0,0)
settingsGroup:insert(settingsPlack)
settingsGroup:insert(musicOff)
settingsGroup:insert(musicOn)
settingsGroup:insert(ex)
settingsGroup:insert(check)
settingsGroup:insert(exit)
settingsGroup:insert(info)
settingsGroup:insert(restore)
settingsGroup:insert(contact)
settingsGroup:insert(musicText)
settingsGroup:insert(checkText)
settingsGroup.alpha = 0
-----Button Listeners + Functions----------------------------------------------
	local function showShare()

	    local popupName = "activity"
	    local isAvailable = native.canShowPopup( popupName )
	    local isSimulator = "simulator" == system.getInfo( "environment" )
	 
	    if isAvailable then
	        local listener = {}
	        function listener:popup( event )
	        end
	         native.showPopup( popupName,
	        {
	            items = items,
	            listener = listener,
	            origin = share.contentBounds,
	            permittedArrowDirections={ "up", "down" }
	        })
	    else
	        native.showAlert( "Error", "Can't display the view controller. Are you running iOS 7 or later?", { "OK" } )
    end
end

local function tapShare()
	loadTap()
	animateButton(0,0.25,0.25,150,share)
	timer.performWithDelay(200,showShare,1)
end
share:addEventListener("tap",tapShare)

local function settingsNorm()
	transition.to(settingsGroup,{time=200,xScale=1,yScale=1,y=0,x=0})
end

local function tapSettings()
	if settingsVar == 1 then 
		settingsGroup.alpha = 0.5
		transition.to(settingsGroup,{time=100,xScale=0.9,yScale=0.9,y=15,x=15,alpha=1,transition=easing.outBack,onComplete=settingsNorm})
		animateButton(0,0.25,0.25,150,settings)
		settingsVar = 2
	elseif settingsVar == 2 then 
		transition.to(settingsGroup,{time=100,xScale=0.9,yScale=0.9,y=15,x=15,alpha=0,transition=easing.outBack,onComplete=settingsNorm})
		animateButton(0,0.25,0.25,150,settings)
		settingsVar = 1
		transition.to(infoGroup,{time=500,alpha=0,transition=easing.outBack})
		end
		loadTap()
	end
settings:addEventListener("tap",tapSettings)

local function tapExit()
	loadTap()
	animateButton(0,0.7,0.7,150,exit)
	transition.to(settingsGroup,{time=100,xScale=0.9,yScale=0.9,y=settingsGroup.y + 15,x=settingsGroup.x + 15,alpha=0,transition=easing.outBack,onComplete=settingsNorm})
	settingsVar = 1
	return true 
end
exit:addEventListener("tap",tapExit)


	if goEmoj == false then 
		ex.alpha = 1
		check.alpha = 0
		checkText.text = "Emojis Off"
	end 
	if goMusic == false then
		audio.pause(music)
		musicOff.alpha = 1 
		musicOn.alpha = 0
		musicText.text = "Music Off"
	end

local function tapMusic(event)
	if event.target == musicOn then 
		audio.pause(music)
		goMusic = false
		musicOn.alpha = 0 
		musicOff.alpha = 1
		musicText.text = "Music Off"
	elseif event.target == musicOff then 
		audio.resume(music)
		goMusic = true
		musicOff.alpha = 0 
		musicOn.alpha = 1
		musicText.text = "Music On"
	end
	loadTap()
end
musicOff:addEventListener("tap",tapMusic)
musicOn:addEventListener("tap",tapMusic)

local function tapEx(event)
	if event.target == check then 
		check.alpha = 0 
		ex.alpha = 1
		checkText.text = "Emojis Off"
		goEmoj = false 
	elseif event.target == ex then 
		ex.alpha = 0
		check.alpha = 1
		checkText.text = "Emojis On"
		goEmoj = true
	end
	loadTap()
end
check:addEventListener("tap",tapEx)
ex:addEventListener("tap",tapEx)

local function tapInfo()
	loadTap()
	animateButton(0,0.7,0.7,150,info)
	transition.to(settingsGroup,{time=100,xScale=0.9,yScale=0.9,y=settingsGroup.y + 15,x=settingsGroup.x + 15,alpha=0,transition=easing.outBack,onComplete=settingsNorm})
	transition.to(infoGroup,{time=100,alpha=1,xScale=0.9,yScale=0.9,x=infoGroup.x + 15,y=infoGroup.y + 15,transition=easing.outBack,onComplete=function()
	transition.to(infoGroup,{time=100,xScale=1,yScale=1,x=infoGroup.x - 15,y=infoGroup.y - 15})end})
end
info:addEventListener("tap",tapInfo)

local function tapContact()
	loadTap()
	animateButton(0,0.7,0.7,150,contact)
	local sendOptions =
	{
	   to = "newBgames01@gmail.com",
	   subject = "Trump App",
	   body = "Hey NewBGames,"}
	   native.showPopup( "mail", sendOptions )
end
contact:addEventListener("tap",tapContact)

local function tapRestore()
	loadTap()
	animateButton(0,0.7,0.7,150,restore)
	restorePurchases()
end
restore:addEventListener("tap",tapRestore)


local function tapSettingsPlack()
	-- Make sure not to tap through the settings
	return true 
end
settingsPlack:addEventListener("tap",tapSettingsPlack)
 
-----IAP----------------------------------------------

local function tapBuy()
	animateButton(0,0.25,0.25,150,buy)
	loadTap()
	if iap.getInventoryValue("unlock") == nil then 
		buyUnlock()
	elseif iap.getInventoryValue("unlock") ~= nil then
		timer.performWithDelay(500,function()
			native.showAlert( "Unlocked Content", "You have already unlocked this content.", { "OK" } )
		end,1)
	end
end
buy:addEventListener("tap",tapBuy)

---------------------------------------------------


	sceneGroup:insert( background )
	sceneGroup:insert( trumpIcon )
	sceneGroup:insert( iconGroup )
	sceneGroup:insert( play )
	sceneGroup:insert( nameGroup )
	sceneGroup:insert( infoGroup )
 	sceneGroup:insert( settingsGroup )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		showRateIt()
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene