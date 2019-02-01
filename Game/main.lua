-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local screenW,screenH = display.contentWidth, display.contentHeight
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"
------------------------------------------------------------

local rateGroup = display.newGroup()
local rateBack = display.newImage("images/rateBack.png",screenW/2,screenH/2)
rateBack.xScale = 0.7 rateBack.yScale = 0.7

local RateTextOptions = {
	text = "Hello! Can you support the\n\ndevelopers of this app and\n\nleave a kind review?",
	fontSize = 15, 
	font = "Funnier",
	align = "center",
	x = rateBack.x,
	y = rateBack.y - 20,
	width = rateBack.width - 130,
}
local rateText = display.newText(RateTextOptions)
rateText:setFillColor(0,0,0)

local no = display.newImage("images/x.png",rateBack.x - 90,rateBack.y + 65)
local yes = display.newImage("images/check.png",rateBack.x + 90,rateBack.y + 65)

local antiTap = display.newRect(screenW/2,screenH/2,screenW,screenH + 200)
antiTap.alpha = 0 
antiTap.isHitTestable = false

rateGroup:insert(antiTap)
rateGroup:insert(rateBack)
rateGroup:insert(rateText)
rateGroup:insert(no)
rateGroup:insert(yes)
rateGroup.alpha = 0

local function tapRateBack() return true end
rateBack:addEventListener("tap",tapRateBack)

local function tapAntiTap() return true end
antiTap:addEventListener("tap",tapAntiTap)

local function tapNo() 
loadTap()
transition.to(rateGroup,{time=100,alpha=0}) 
animateButton(0,0.6,0.6,200,no) 
antiTap.isHitTestable = false
end
no:addEventListener("tap",tapNo)

local function tapYes()
loadTap()
animateButton(0,0.6,0.6,200,yes) 
transition.to(rateGroup,{time=100,alpha=0}) 
antiTap.isHitTestable = false
local url = "https://itunes.apple.com/us/app/viewContentsUserReviews/id1217045026?ls=1&mt=8"
system.openURL( url )
end
yes:addEventListener("tap",tapYes)

local showRate = 0

function showRateIt()
	showRate = math.random(1,100)
	if showRate == 1 then 
		rateGroup.alpha=1
		antiTap.isHitTestable = true
	end
end
------------------------------------------------------------

-- load menu screen
composer.gotoScene( "splashScreen" )

unlockV2 = false
goEmoj = true  
goMusic = true

function animateButton(dlay,scaleX,scaleY,timeB,button)
  transition.to(button,{delay=dlay,time=timeB,xScale=scaleX,yScale=scaleY,transition=easing.continuousLoop})
end

--iap.getInventoryValue("unlock")

local spinner
local iap = require("iap_badger")

local catalogue = {
    products = {	
        unlockContent = {
                productNames = { apple="FullContent", google="0", amazon="0"},
                productType = "non-consumable",
                onPurchase=function() iap.setInventoryValue("unlock", true) end,
        }
    },
    inventoryItems = {
        unlock = { productType="non-consumable" }
    }
}

local function failedListener()
    if (spinner) then 
        native.showAlert("Oops!", "We could not complete your transaction!", {"Okay"})
        spinner:removeSelf()
        spinner=nil
    end
end

local iapOptions = {
    catalogue=catalogue,
    filename="IAP.txt",
    salt = "something tr1cky to gue55!",
    failedListener=failedListener,
    cancelledListener=failedListener,
    --Once the product has been purchased, it will remain in the inventory.  Uncomment the following line
    --to test the purchase functions again in future.  It's also useful for testing restore purchases.
    --doNotLoadInventory=true,
    --debugMode=true,
    
}
iap.init(iapOptions)

local function unlockContent()    
	unlockV2 = true
        --THIS IS FUNCTION WHERE I SAY WHAT I WANT TO CHANGE FOR THE IAP, WHAT IS UNLOCKED
end

local function purchaseListener(product )
    spinner:removeSelf()
    spinner=nil
    unlockContent()
    iap.saveInventory()
    native.showAlert("Info", "Your purchase was successful", {"Okay"})
end

buyUnlock=function()
    local spinnerBackground = display.newRect(160,240,360,600)
    spinnerBackground:setFillColor(1,1,1,0.75)
    spinnerBackground:addEventListener("tap", function() return true end)
    local spinnerText = display.newText("Contacting " .. iap.getStoreName() .. "...", 160,180, "Comic", 18)
    spinnerText:setFillColor(0,0,0)
    local spinnerImage = display.newImage("images/trump1.png",screenW/2,screenH/2)
    spinnerImage.xScale = 0.2 spinnerImage.yScale = 0.2
    transition.to(spinnerImage,{ time=1000, xScale=0.22,yScale=0.22,iterations=-1, transition=easing.continuousLoop})
    spinner=display.newGroup()
    spinner:insert(spinnerBackground)
    spinner:insert(spinnerText)
    spinner:insert(spinnerImage)
    iap.purchase("unlockContent", purchaseListener)
end


local function restoreListener(productName, event)
    if iap.getInventoryValue("unlock") ~= nil then 
        spinner:removeSelf()
        spinner=nil   
        native.showAlert( "Unlocked Content", "You have already unlocked this content.", { "OK" } )
    elseif (event.firstRestoreCallback) then
        spinner:removeSelf()
        spinner=nil 
        unlockContent()       
        native.showAlert("Restore", "Your items are being restored", {"Okay"})
    end
        iap.saveInventory()
end

function restorePurchases()
    local spinnerBackground = display.newRect(160,240,360,600)
    spinnerBackground:setFillColor(1,1,1,0.75)
    spinnerBackground:addEventListener("tap", function() return true end)
    local spinnerText = display.newText("Contacting " .. iap.getStoreName() .. "...", 160,180, "Comic", 18)
    spinnerText:setFillColor(0,0,0)
    local spinnerImage = display.newImage("images/trump1.png",screenW/2,screenH/2)
    spinnerImage.xScale = 0.2 spinnerImage.yScale = 0.2
    transition.to(spinnerImage,{ time=1000, xScale=0.22,yScale=0.22,iterations=-1, transition=easing.continuousLoop})
    spinner=display.newGroup()
    spinner:insert(spinnerBackground)
    spinner:insert(spinnerText)
    spinner:insert(spinnerImage)

    iap.restore(false, restoreListener, failedListener)
end


local tapAudio = audio.loadStream("select.m4a")

function loadTap()
	audio.play(tapAudio,{channel=4})
end










