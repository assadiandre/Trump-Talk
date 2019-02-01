-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local removeLock
local trump
local getRidOfTimeTable 
local configIpad
--------------------------------------------

function scene:create( event )

local sceneGroup = self.view
local iap = require("iap_badger")
local widget = require( "widget" )
local screenW = display.contentWidth 
local screenH = display.contentHeight
local actualHeight = display.actualContentHeight
local timeTable = {}
local n = 1
local talkAudio
local plack = {}
local plack2 = {}
local plack3 = {}
local plackText1 = {}
local plackText2 = {}
local plackText3 = {}
local tapPlackVar = 1
local playTapAudio
local tapAudio
local tweet
local keyboardSound 
local playKS
local tweetBVar = 1
local tweetScroll
local ding = audio.loadStream("ding.m4a")
local openPage2
local tapQuestion
local tutVar = 1
local scrollGroup = display.newGroup()
local specGroup
local specVar = 1
local nLevel = 115
local unlockVar = iap.getInventoryValue("unlock") 

local function checkUnlockVar()
	if unlockVar == true then 
		nLevel = 145
	end
end
checkUnlockVar()

local function playDing()
  audio.rewind(ding)
  audio.play(ding,{channel=2})
  audio.setVolume( 0.2, {channel=2 })
end

local function buttonTrans(button)
  transition.to(button,{time=70,xScale=0.5,yScale=0.5,onComplete=function() 
    transition.to(button,{time=70,xScale=0.6,yScale=0.6})
    end})
end

--------IMAGES---------------------------------------------------

local background = display.newImage("images/background.png",screenW/2,screenH/2)
background.xScale = 0.8
background.yScale = 0.8

local plus = display.newImage("images/icon1.png",280,(screenH - actualHeight)/2 + 40)
plus.xScale = 0.6
plus.yScale = 0.6

local replay = display.newImage("images/icon2.png",160,(screenH - actualHeight)/2 + 40)
replay.xScale = 0.6
replay.yScale = 0.6

local star = display.newImage("images/starIcon.png",220,(screenH - actualHeight)/2 + 40)
star.xScale = 0.6
star.yScale = 0.6

local question = display.newImage("images/icon5.png",100,(screenH - actualHeight)/2 + 40)
question.xScale = 0.6
question.yScale = 0.6

local back = display.newImage("images/icon3.png",40,(screenH - actualHeight)/2 + 40)
back.xScale = 0.6
back.yScale = 0.6

local whiteTap = display.newRect(screenW/2,300,screenW,screenH)
whiteTap.isHitTestable = true 
whiteTap.alpha = 0

local titleTextOptions = {
  text = '',
  width = screenW,
  x = screenW/2,
  y = (screenH - actualHeight)/2 + 120,
  font = "Funnier",
  fontSize = 30,
  align = "center",
}

local titleText = display.newText( titleTextOptions )
------TRUMP SPRITE SHEET-----------------------------------------------------

  local trumpInfo = require("trump")
  local trumpSheet = graphics.newImageSheet( "images/trump.png", trumpInfo:getSheet() )
  local trumpOrderData = {
     { name = "talkSarcastic", start=1, count=2, time=300, loopCount=0 },
     { name = "talkDumb", start=3, count=2, time=300, loopCount=0 },
     { name = "wave", start=5, count=2, time=300, loopCount=0 },
     { name = "talkDumb2Flipped", start=7, count=2, time=300, loopCount=0 },
     { name = "talkDumb2", start=9, count=2, time=300, loopCount=0 },
     { name = "talkNormal", start=11, count=2, time=300, loopCount=0 },
     { name = "laugh", start=13, count=1, time=300, loopCount=0 },
     { name = "yell", start=14, count=1, time=300, loopCount=0 },
     { name = "idle", start=12, count=1, time=300, loopCount=0 },
     { name = "dumbFace2-idle", start=10, count=1, time=300, loopCount=0 },
     { name = "talkFastDumb2", start=9, count=2, time=200, loopCount=0 },
     { name = "talkFastDumb2Flipped", start=7, count=2, time=200, loopCount=0 },
     { name = "talkFastNormal", start=11, count=2, time=200, loopCount=0 },
     { name = "tweetAngry", start=17, count=2, time=200, loopCount=52 },
     { name = "tweetHappy", start=15, count=2, time=200, loopCount=52 },
     { name = "sign", start=17, count=1, time=0, loopCount=1},
 }

  trump = display.newSprite( trumpSheet, trumpOrderData )
  trump.x = screenW/2 - 40
  trump.y = (actualHeight - screenH)/2 + 335
  trump.xScale = 0.9
  trump.yScale = 0.9
  trump.rotation = -10
  trump:setSequence("idle")
  trump:play()

------EMOJI SPRITE SHEET-----------------------------------------------------
  local emojiInfo = require("emoji")
  local emojiSheet = graphics.newImageSheet( "images/emoji.png", emojiInfo:getSheet() )
  local emojiOrderData = {
	{name="hellaFunny",start=4,count=1},----------Funny/Happy
	{name="hellaFunny2",start=8,count=1},
	{name="halo",start=9,count=1},
	{name="wink",start=10,count=1},
	{name="killSelf",start=13,count=1},
	{name="lick",start=15,count=1},
	{name="lickSmile",start=22,count=1},
	{name="money",start=25,count=1},
	{name="hands",start=28,count=1},
	{name="question",start=34,count=1},
    {name="straight",start=2,count=1},------------UNhappy
    {name="nervous",start=7,count=1},
    {name="noExpression",start=30,count=1},
    {name="straightFace",start=32,count=1},
    {name="roll",start=33,count=1},
    {name="daze",start=35,count=1},
    {name="unhappy",start=37,count=1},
 }

  local emoji = display.newSprite( emojiSheet, emojiOrderData )
  emoji.x = screenW/2 
  emoji.y = 130
  emoji.xScale = 0.5
  emoji.yScale = 0.5
  emoji.alpha = 0
  local emojiVar = 0 

  local function playFunnyEmoji()
  	emojiVar = math.random(1,10)
  	emoji:setSequence(emojiOrderData[emojiVar].name)
  	emoji:play()
  end

  local function playMadEmoji()
  	emojiVar = math.random(11,16)
  	emoji:setSequence(emojiOrderData[emojiVar].name)
  	emoji:play()
  end
---------TALK DATA AND FUNCTIONS--------------------------------------------------

local function st1Trans()
  transition.to(trump,{time=5000,x = trump.x - 20})
end

local showEVar = 0

local function playit(preset1,time1,time2,preset2,time3,time4,preset3,time5,time6,preset4,time7,preset5,time8,time9,preset6,time10,preset7,time11,time12,preName,emojiSet)
  playDing()
  emoji.alpha = 0
  timeTable[1] = timer.performWithDelay(time1,function()trump:setSequence(preset1) trump:play() end,1)
  timeTable[2] = timer.performWithDelay(time2,function()trump:pause() end,1)
  timeTable[3] = timer.performWithDelay(time3,function()trump:setSequence(preset2) trump:play() end,1)
  timeTable[4] = timer.performWithDelay(time4,function()trump:pause() end,1)
  timeTable[5] = timer.performWithDelay(time5,function()trump:setSequence(preset3) trump:play()end,1)
  timeTable[6] = timer.performWithDelay(time6,function()trump:pause() end,1)
  timeTable[7] = timer.performWithDelay(time7,function()trump:setSequence(preset4) trump:play() end,1)
  timeTable[8] = timer.performWithDelay(time8,function()trump:setSequence(preset5) trump:play() end,1)
  timeTable[9] = timer.performWithDelay(time9,function()trump:pause() end,1)
  timeTable[10] = timer.performWithDelay(time10,function()trump:setSequence(preset6) trump:play() end,1)
  timeTable[11] = timer.performWithDelay(time11,function()trump:setSequence(preset7) trump:play() end,1)
  timeTable[12] = timer.performWithDelay(time12,function()trump:pause() end,1)

  ----Text--------------------------------------------------------------------------
  titleText.text = preName .." no." .. n --'"Hello" no.'..n
  ------------------------------------------------------------------------------
  showEVar = math.random(1,2)
  if emojiSet ~= nil and showEVar == 2 and goEmoj == true then 
  	emoji.alpha = 1
  	emojiSet()
  end
end 

local function playTweet(tweetPreset,tweetNum,tweetName)
  playDing()
  tweet = display.newImageRect("tweets/"..tweetNum..".png",300,115)
  tweet.x = screenW/2
  tweet.y = screenH/2 - 90
  tweet:toBack()
  trump:toBack()
  background:toBack()
  sceneGroup:insert(tweet)
  trump:setSequence(tweetPreset)
  trump:play()
  keyboardSound = audio.loadStream("keyboard.m4a")
  playKS = audio.play(keyboardSound)
  ------Text-----------------------------------------------
  titleText.text = tweetName .." no." .. tweetNum
end 

local tweets = {
  {"tweetHappy",1,"Tweet"},
  {"tweetAngry",2,"Tweet"},
  {"tweetHappy",3,"Tweet"},
  {"tweetAngry",4,"Tweet"},
  {"tweetAngry",5,"Tweet"},
  {"tweetAngry",6,"Tweet"},
  {"tweetHappy",7,"Tweet"},
  {"tweetAngry",8,"Tweet"},
  {"tweetHappy",9,"Tweet"},
  {"tweetAngry",10,"Tweet"},
  {"tweetHappy",11,"Tweet"},
  {"tweetAngry",12,"Tweet"},
  {"tweetHappy",13,"Tweet"},
  {"tweetAngry",14,"Tweet"},
  {"tweetAngry",15,"Tweet"},
  {"tweetHappy",16,"Tweet"},
  {"tweetAngry",17,"Tweet"},
  {"tweetHappy",18,"Tweet"},
  {"tweetAngry",19,"Tweet"},
  {"tweetHappy",20,"Tweet"},
  {"tweetAngry",21,"Tweet"},
  {"tweetHappy",22,"Tweet"}
}

local st = {
  {"talkNormal",1700,6000,"talkNormal",7000,10500,"talkDumb2",12000,22000,"talkSarcastic",22500,"talkNormal",27000,28000,"talkNormal",30000,"idle",37000,0,'"Mexico"',playFunnyEmoji}, -- Mexico
  {"talkDumb",100,1000,"talkDumb",3000,7000,"talkDumb2",7000,7500,"laugh",9000,"0",0,0,"0",0,"0",0,0,'"Jobs"',playMadEmoji}, -- Jobs 
  {"talkDumb2",100,2000,"talkDumb2Flipped",3000,6000,"wave",6000,6400,"talkSarcastic",6700,"talkDumb2",10500,15000,"talkDumb2Flipped",15500,"laugh",20000,0,'"Golf"',playFunnyEmoji}, -- Obama Golf
  {"talkDumb2Flipped",1000,1500,"talkDumb2Flipped",2000,7000,"talkDumb2",8500,10000,"talkDumb2",10500,"0",0,11500,"wave",13000,"laugh",14000,0,'"China Apartment"',playFunnyEmoji}, -- China Apartment
  {"talkNormal",1300,3000,"talkNormal",3400,4100,"talkNormal",4300,0,"0",0,"0",0,0,"talkSarcastic",9000,"yell",16000,0,'"Kill Us"',playMadEmoji}, -- Kill Us
  {"talkDumb",50,1200,"talkDumb",1500,3000,"talkSarcastic",3900,7300,"talkSarcastic",8300,"talkDumb2",15000,0,"talkDumb2Flipped",22000,"0",0,24000,'"Border Guards"',playMadEmoji}, -- Border Guards
  {"talkDumb",0,1600,"talkDumb",2500,5200,"talkDumb2Flipped",5800,6800,"talkDumb2",8100,"talkDumb2Flipped",10800,12300,"talkDumb",13400,"dumbFace2-idle",18000,9000,'"Syrian Hotel"',playMadEmoji}, -- Syrian Hotel
  {"talkDumb2",550,2300,"talkDumb",3500,10600,"talkSarcastic",11200,13500,"talkNormal",13500,"talkDumb2Flipped",16550,0,"0",0,"0",0,22180,'"Net Worth"',playFunnyEmoji}, -- Net Worth
  {"talkNormal",10,700,"talkNormal",1200,2300,"talkNormal",2700,6000,"talkNormal",7000,"0",0,0,"0",0,"0",0,18300,'"Chopping Heads"',playMadEmoji}, -- Chopping Heads
  {"talkNormal",450,1300,"talkSarcastic",1400,1900,"talkNormal",2400,4500,"talkSarcastic",4500,"0",0,0,"0",0,"0",0,5500,'"Water Boarding"',playMadEmoji}, -- Water Boarding
  {"talkNormal",1,450,"talkSarcastic",600,3200,"talkDumb",3400,0,"0",0,"0",0,0,"0",0,"0",0,5500,'"Bomb"',playFunnyEmoji}, -- Bomb ------------------------------------------------------- Volume too low
  {"talkDumb2",1,2500,"talkDumb2Flipped",3400,6500,"talkDumb2",7000,11000,"0",0,"0",0,0,"0",0,"0",0,0,'"Problems"',playFunnyEmoji}, -- Center(s)
  {"talkDumb",1,2500,"talkDumb",3400,6000,"talkDumb",6500,7000,"talkDumb",7500,"0",0,0,"0",0,"0",0,12000,'"Period"',playFunnyEmoji}, -- Period
  {"talkDumb2",1,2000,"talkDumb2Flipped",2000,4300,"talkNormal",4300,6500,"talkDumb2Flipped",7300,"0",0,11000,"talkDumb2",12000,"0",0,13000,'"Give"',playMadEmoji}, -- Give
  {"talkSarcastic",200,1600,"talkDumb",2400,5300,"talkDumb",5400,0,"0",0,"0",0,0,"0",0,"0",0,7100,'"Full Moon"',playFunnyEmoji}, -- Full Moon
  {"talkDumb2",200,7500,"talkSarcastic",8000,11500,"talkDumb",12000,18000,"wave",18000,"talkDumb2Flipped",20000,0,"talkDumb2",20000,"laugh",27000,30000,'"Small?"',playFunnyEmoji}, -- Lightweight
  {"talkSarcastic",1,0,"talkDumb",4000,0,"talkNormal",7000,11500,"talkNormal",13000,"0",0,0,"0",0,"0",0,15400,'"Tax Fraud"',playMadEmoji}, -- Tax Fraud
  {"wave",1,0,"talkNormal",3400,7400,"talkNormal",8000,14200,"talkDumb2Flipped",14900,"0",0,0,"0",0,"0",0,16700,'"Lyin Ted"',playFunnyEmoji}, -- Lyin' Ted
  {"talkSarcastic",100,1400,"talkDumb",2500,3800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Beauty Money"',playFunnyEmoji}, -- Beauty Money
  {"talkDumb2",1,2100,"talkDumb",2500,3350,"talkDumb2",3850,4900,"talkDumb2",5300,"talkDumb2Flipped",6200,5800,"0",0,"laugh",7600,7200,'"Stupid People"',playMadEmoji}, -- Stupid People
  {"talkDumb",280,800,"talkDumb",1100,12640,"talkNormal",3000,3750,"talkNormal",4000,"talkNormal",4800,4400,"talkDumb2",7400,"talkDumb2Flipped",11200,7200,'"The Deal pt.1"',playMadEmoji}, -- Artofthedeal 1
  {"talkNormal",100,1000,"talkDumb",2700,3400,"talkDumb2",4200,5600,"0",0,"0",0,0,"0",0,"0",0,0,'"The Deal pt.2"',playFunnyEmoji}, -- Artofthedeal 2
  {"talkDumb",1,800,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Mexico pt.2"',playFunnyEmoji}, -- Mexico 
  {"talkSarcastic",100,3700,"talkDumb",3900,7900,"talkDumb2",7900,9900,"talkDumb2Flipped",10400,"0",0,0,"0",0,"0",0,12000,'"Disgrace"',playMadEmoji}, -- Disgrace
  {"talkSarcastic",140,4100,"talkDumb",4300,4900,"talkDumb",5800,7000,"0",0,"0",0,0,"0",0,"0",0,0,'"Great Wall"',playFunnyEmoji}, -- Great Wall
  {"talkDumb",10,3000,"talkDumb",3400,5000,"talkNormal",5400,6300,"talkNormal",6600,"talkDumb",7700,8600,"talkNormal",9200,"0",0,10900,'"I want enemey"',playMadEmoji}, -- I want enemy
  {"talkDumb2",350,1800,"talkDumb",2100,4200,"talkDumb2Flipped",4200,5500,"talkDumb2Flipped",5600,"0",0,0,"0",0,"0",0,6300,'"Latino Vote?"',playMadEmoji}, -- ¿Latino Vote?
  {"talkDumb",170,3000,"talkNormal",3400,5600,"talkDumb2",6000,8000,"talkNormal",9300,"talkDumb2",14000,13000,"0",0,"0",0,15900,'"Sweat Like Dogs"',playFunnyEmoji}, -- Swea)ogs
  {"talkDumb",1,800,"talkDumb2",1600,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,2800,'"Nice Person"',playMadEmoji}, -- Nice person
  {"talkDumb",110,2150,"talkNormal",2200,5500,"talkDumb",5600,0,"0",0,"0",0,0,"0",0,"0",0,6300,'"Rosie, youre fired"',playFunnyEmoji}, -- Rosies Fired
  {"talkSarcastic",1,2500,"talkNormal",3200,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,4300,'"Tough on Isis"',playFunnyEmoji}, -- Tough on Isis 
  {"talkSarcastic",3300,8700,"talkNormal",9200,10800,"talkDumb",11100,12300,"talkSarcastic",12520,"talkDumb2",14500,14000,"wave",1,"0",0,17000,'"Bomb the Hell"',playMadEmoji}, -- Bomb the hell
  {"talkNormal",1,2000,"wave",2100,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,3000,'"I love Saudies"',playFunnyEmoji}, -- I Love Saudies!
  {"talkDumb",1,750,"talkDumb",1360,1850,"talkNormal",3000,0,"0",0,"0",0,0,"0",0,"0",0,4000,'"American Dream"',playFunnyEmoji}, -- American Dream
  {"talkSarcastic",70,2150,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Nice Person"',playFunnyEmoji}, -- Nice person 2
  {"talkDumb",1,1230,"talkDumb2",1280,4690,"talkDumb2Flipped",5000,7300,"0",0,"0",0,0,"0",0,"0",0,0,'"Truck Driver Rosie"',playFunnyEmoji}, -- Truck Driver Rosie
  {"talkNormal",1,3000,"talkDumb",3120,4170,"talkDumb2",4500,6700,"talkNormal",7130,"0",0,0,"0",0,"0",0,8450,'"Rosies Worst"',playFunnyEmoji}, -- Rosies Worst 
  {"talkDumb",100,2000,"talkDumb2Flipped",2400,4000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Their Best"',playMadEmoji}, -- Their Best 
  {"talkNormal",80,2500,"talkDumb",2600,3800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Pay it. Mexico."',playMadEmoji}, -- Pay it. Bitch. ------------------------------------------------------- Volume Higher
  {"talkDumb2",90,2480,"talkDumb2Flipped",2500,4400,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Our Stupidity"',playMadEmoji}, -- Our stupidity
  {"talkDumb",80,460,"talkNormal",550,1000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Bad Hombres"',playFunnyEmoji}, -- Bad hombres
  {"talkSarcastic",50,1270,"talkNormal",1350,2850,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"10ft Over Ground"',playFunnyEmoji}, -- 10ft over ground
  {"talkNormal",1,500,"talkDumb",630,1160,"talkNormal",1340,2000,"0",0,"0",0,0,"0",0,"0",0,0,'"We Will"',playMadEmoji}, -- We will 
  {"talkDumb2",60,1230,"talkNormal",1340,2250,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Whos Gonna"',playMadEmoji}, -- Whos Gonna 
  {"talkDumb",70,1400,"talkDumb2Flipped",1740,2000,"talkDumb2Flipped",2300,2700,"0",0,"0",0,0,"0",0,"0",0,0,'"Great Wall pt2"',playFunnyEmoji}, -- Great Wall
  {"talkDumb",1,1230,"talkNormal",1400,1700,"talkDumb",2000,2500,"0",0,"0",0,0,"0",0,"0",0,0,'"Mexico Pays"',playFunnyEmoji}, -- Mexico Pays
  {"talkSarcastic",1,670,"talkDumb",950,2070,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Mexican People"',playMadEmoji}, -- Mexican People
  {"talkDumb2",20,1400,"talkDumb",1750,0,"talkDumb2Flipped",3500,5700,"0",0,"0",0,0,"0",0,"0",0,0,'"Only 1 million"',playFunnyEmoji}, -- Only 1 million
  {"talkNormal",1,1000,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Sooooo Rich"',playFunnyEmoji}, -- Really Rich 
  {"talkSarcastic",1,2260,"talkNormal",2300,3400,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Sooooo Proud"',playFunnyEmoji}, -- So proud
  {"talkFastDumb2",1,350,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"China!"',playFunnyEmoji}, -- China!
  {"talkNormal",190,720,"talkFastDumb2",720,1540,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"King Debt"',playMadEmoji}, -- King of Debt
  {"talkDumb2",40,1610,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Beat China"',playMadEmoji}, -- Beat China 
  {"talkFastNormal",20,1000,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Bernie"',playFunnyEmoji}, -- Bernie  -------------------------------------------------------
  {"talkDumb",1,700,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Tiffany"',playFunnyEmoji}, -- Tiffany 
  {"talkFastNormal",30,740,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Mexico. Again."',playFunnyEmoji}, -- Mexico. Again 
  {"talkFastDumb2",30,800,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Saudi Arabia"',playFunnyEmoji}, -- Saudi Arabia
  {"talkDumb",50,780,"talkNormal",780,1700,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Wheres Ivanka?"',playFunnyEmoji}, -- Where's Ivanka?
  {"talkNormal",30,500,"talkFastDumb2",580,1000,"talkFastNormal",1120,1500,"0",0,"0",0,0,"0",0,"0",0,0,'"Dony Don"',playFunnyEmoji}, -- Dony Don 
  {"talkFastNormal",1,620,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Rubio"',playFunnyEmoji}, -- Rubio
  {"talkFastDumb2",1,440,"talkDumb",660,1200,"talkFastNormal",1410,1700,"0",0,"0",0,0,"0",0,"0",0,0,'"Crooked Hillary"',playMadEmoji}, -- Crooked Hillary
  {"talkSarcastic",90,1800,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Ford to Mexico"',playMadEmoji}, -- Ford to Mexico
  {"talkFastDumb2",1,700,"talkDumb2Flipped",700,1600,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"0 stamina"',playFunnyEmoji}, -- 0 stamina
  {"talkDumb",20,0,"talkNormal",500,950,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Beautiful Baby"',playFunnyEmoji}, -- Beautiful baby
  {"talkDumb",20,0,"talkSarcastic",860,2200,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Going to Hell"',playFunnyEmoji}, -- Going to Hell
  {"talkNormal",40,530,"talkFastNormal",640,1000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"I Love Our Police"',playMadEmoji}, -- I love our police -------------------------------------------------------
  {"talkDumb2",1,550,"talkFastDumb2Flipped",650,970,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"A Hundred Percent"',playMadEmoji}, -- A hundred percent -------------------------------------------------------
  {"talkNormal",1,380,"talkDumb2",400,1200,"talkDumb",1400,2900,"0",0,"0",0,0,"0",0,"0",0,0,'"How Stupid"',playFunnyEmoji}, -- How stupid 
  {"talkSarcastic",60,1150,"talkDumb",1150,1800,"talkDumb2",1800,2500,"0",0,"0",0,0,"0",0,"0",0,0,'"Listen"',playFunnyEmoji}, -- Listen
  {"talkNormal",1,220,"talkNormal",370,800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Youre Fired"',playFunnyEmoji}, -- Your Fired
  {"talkDumb2",1,1110,"talkDumb",1840,3700,"talkDumb2Flipped",3800,5000,"0",0,"0",0,0,"0",0,"0",0,0,'"No Clue"',playFunnyEmoji}, -- No clue
  {"talkSarcastic",140,1400,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Mexican Gov."',playFunnyEmoji}, -- Mexican Gov. -------------------------------------------------------
  {"talkDumb",1,1000,"talkNormal",1400,2200,"talkDumb2",2600,3400,"0",0,"0",0,0,"0",0,"wave",3400,5000,'"Great Again"',playFunnyEmoji}, -- Great Again
  {"talkSarcastic",1,640,"talkNormal",870,2900,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"God Ever"',playMadEmoji}, -- God Ever 
  {"talkFastNormal",1,600,"talkDumb",700,930,"talkNormal",1000,1350,"0",0,"0",0,0,"0",0,"0",0,0,'"Truly Great"',playMadEmoji}, -- A Truly Great -------------------------------------------------------
  {"talkDumb",1,940,"talkDumb2Flipped",1250,2200,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Losers"',playMadEmoji}, -- Losers
  {"talkDumb2",1,680,"talkDumb",1400,1800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"American Dream"',playFunnyEmoji}, -- American Dream -------------------------------------------------------
  {"talkSarcastic",1,430,"talkSarcastic",670,1200,"talkDumb",1420,1650,"0",0,"0",0,0,"0",0,"0",0,0,'"Crooked Hllary"',playFunnyEmoji}, -- Crooked Hillary
  {"talkNormal",40,230,"talkNormal",470,1400,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Vote"',playMadEmoji}, -- Vote
  {"talkDumb2",1,1600,"talkDumb2Flipped",1700,3000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Country"',playFunnyEmoji}, -- Country 
  {"talkDumb",1,820,"talkDumb2Flipped",870,2400,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Thanks"',playFunnyEmoji}, -- Thank you very much
  {"talkDumb2",50,680,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Sorry"',playFunnyEmoji}, -- Sorry
  {"talkNormal",30,360,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"No."',playFunnyEmoji}, -- No
  {"talkSarcastic",50,940,"talkDumb2",1000,1570,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Doesnt Exist"',playFunnyEmoji}, -- Doesn't Exist
  {"talkDumb",1,580,"talkFastNormal",650,970,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Hapenning"',playMadEmoji}, -- Hapenning       #####85
  {"talkNormal",1,650,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Dont Worry"',playFunnyEmoji}, -- Don't Worry -------------------------------------------------------
  {"talkNormal",20,380,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Wrong"',playFunnyEmoji}, -- Wrong
  {"talkDumb",50,190,"talkFastDumb2",220,600,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Thats right"',playMadEmoji}, -- Thats right
  {"talkSarcastic",40,1000,"talkDumb",1050,1400,"talkDumb",1700,2500,"0",0,"0",0,0,"0",0,"0",0,0,'"What I say"',playFunnyEmoji}, -- What I say
  {"talkDumb2",1,1300,"talkDumb2Flipped",1650,3000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"I Tell You This"',playFunnyEmoji}, -- I tell you this
  {"talkDumb",1,500,"talkNormal",600,1140,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Common Sense"',playFunnyEmoji}, -- Common Sense
  {"talkDumb",1,1100,"talkDumb2",2000,2800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Really Do"',playFunnyEmoji}, -- Really Do 
  {"talkNormal",30,1050,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Fully Understand"',playMadEmoji}, -- Fully Understand
  {"talkDumb",1,500,"talkDumb",540,1000,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Question"',playFunnyEmoji}, -- Question
  {"talkNormal",60,800,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Out of Here"',playFunnyEmoji}, -- Out of Here
  {"talkDumb2",1,500,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Wrong2"',playFunnyEmoji}, -- Wrong 2
  {"talkSarcastic",1,680,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Start It"',playMadEmoji}, -- Start It
  {"talkDumb",1,1000,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Jail"',playMadEmoji}, -- Jail
  {"talkDumb2Flipped",40,820,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Believe Me"',playMadEmoji}, -- Believe Me -------------------------------------------------------
  {"talkNormal",1,900,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Smart"',playFunnyEmoji}, -- Smart -------------------------------------------------------
  {"talkDumb2",1,1600,"talkDumb2Flipped",2000,3000,"0",0,0,"0",0,"0",0,0,"0",0,"wave",3000,4000,'"Dont Remember"',playFunnyEmoji}, -- Don't Remember
  {"talkDumb",1,450,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Thank You"',playFunnyEmoji}, -- Thank You
  {"talkSarcastic",1,1700,"talkDumb2",2300,3700,"talkDumb2Flipped",4000,6750,"talkDumb",7300,"talkDumb2",10300,8800,"0",0,"0",0,11450,'"Stupid"',playFunnyEmoji}, -- Stupid 
  {"talkDumb2Flipped",40,1120,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Takers of the L"',playFunnyEmoji}, -- Don't Win
  {"talkDumb",80,2300,"talkDumb2",2400,4150,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Amazing Victory"',playFunnyEmoji}, -- Amazing Victory
  {"talkNormal",1,1150,"talkDumb2",1500,3500,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Son"',playFunnyEmoji}, -- Son
  {"talkSarcastic",20,400,"talkDumb",600,1100,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"My Life"',playMadEmoji}, -- My life
  {"talkSarcastic",60,700,"talkDumb2Flipped",780,1450,"talkFastNormal",1600,2000,"0",0,"0",0,0,"0",0,"0",0,0,'"Employ Thousands"',playMadEmoji}, -- Employ Thousands 
  {"talkNormal",1,500,"talkSarcastic",620,1000,"talkDumb",1000,1450,"0",0,"0",0,0,"0",0,"0",0,0,'"Do it"',playFunnyEmoji}, -- Do it
  {"talkNormal",1,2200,"talkDumb",2200,3400,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Very Proud"',playFunnyEmoji}, -- Very Proud
  {"talkDumb",1,2800,"talkNormal",3200,5180,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Winning"',playFunnyEmoji}, -- Winning
  {"talkNormal",1,950,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"I will be"',playMadEmoji}, -- I will be -------------------------------------------------------
  {"talkSarcastic",1,1700,"talkDumb2Flipped",1700,3700,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Normal Situation"',playMadEmoji}, -- Normal Situation
  {"talkSarcastic",1,450,"talkNormal",630,1600,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Wonderfull Family"',playMadEmoji}, -- Wonderfull familly 
  {"talkSarcastic",1,1800,"talkDumb2",1900,2700,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Messenger"',playFunnyEmoji}, -- Messenger 
  {"talkDumb2",80,1300,"talkSarcastic",1800,2700,"talkDumb2Flipped",3000,4400,"0",0,"0",0,0,"0",0,"0",0,0,'"Energy"',playFunnyEmoji}, ---------------EXTRA---------------------------------------
  {"talkDumb2",1,1500,"talkSarcastic",2400,5900,"talkDumb2",6500,7600,"talkDumb",8900,"dumbFace2-idle",12000,10000,"talkDumb2Flipped",10800,"talkNormal",12800,13700,'"Knife"',playFunnyEmoji},
  {"talkSarcastic",1,1600,"talkDumb2",3200,5600,"talkDumb",6600,7200,"talkNormal",8111,"0",0,0,"0",0,"0",0,11100,'"China Wall"',playFunnyEmoji}, 
  {"talkDumb",1,1100,"talkFastNormal",1400,4000,"talkSarcastic",5100,6300,"talkDumb",6800,"talkDumb2",7800,8400,"talkDumb2Flipped",8400,"talkDumb",9300,11700,'"Come In!"',playFunnyEmoji}, 
  {"talkDumb2",1,1100,"talkFastNormal",1600,4480,"talkDumb",4800,5500,"talkSarcastic",5500,"talkNormal",7300,8600,"talkFastDumb2",9200,"0",0,12110,'"Highly Low"',playMadEmoji}, 
  {"talkFastNormal",1,1400,"talkSarcastic",1800,6300,"talkDumb2",7200,8000,"talkDumb",8300,"talkSarcastic",9500,0,"talkNormal",10800,"laugh",14350,16000,'"Water!"',playFunnyEmoji},
  {"talkFastNormal",1,210,"talkFastDumb2",750,1900,"talkFastDumb2",2200,2650,"talkDumb",2680,"0",0,0,"0",0,"0",0,3200,'"Bing Bing"',playFunnyEmoji}, 
  {"talkDumb2",1,2600,"talkNormal",3500,4700,"talkSarcastic",5400,8000,"talkDumb",8500,"talkSarcastic",9800,9200,"talkDumb2",11200,"0",0,13000,'"Jeb"',playFunnyEmoji}, 
  {"talkFastDumb2",1,1900,"talkSarcastic",2500,0,"talkFastNormal",4100,0,"0",0,"0",0,0,"0",0,"0",0,4900,'"Sorry Mcane"',playFunnyEmoji},
  {"talkFastDumb2",40,0,"talkDumb2Flipped",940,1900,"talkSarcastic",2600,4200,"talkNormal",4450,"talkDumb",5900,5400,"0",0,"0",0,6750,'"Isis Hotel?"',playFunnyEmoji},
  {"talkDumb2Flipped",50,560,"talkSarcastic",590,2500,"talkDumb",3000,4200,"0",0,"0",0,0,"0",0,"0",0,0,'"Damn Hillary"',playFunnyEmoji}, 
  {"talkDumb",1,2200,"talkSarcastic",2400,2800,"talkSarcastic",3000,4000,"talkDumb2",4600,"talkDumb2Flipped",6100,8010,"0",0,"0",0,0,'"Damn Obama"',playFunnyEmoji},
  {"talkFastDumb2",1,2000,"talkDumb",2600,3250,"talkSarcastic",4000,4650,"0",0,"0",0,0,"0",0,"0",0,0,'"IDC"',playMadEmoji}, 
  {"talkFastNormal",1,680,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Nasty Guy"',playMadEmoji}, 
  {"talkNormal",1,1700,"talkDumb2",1760,3800,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Meltdown"',playFunnyEmoji}, 
  {"talkDumb",150,2000,"talkSarcastic",2300,3000,"talkDumb2",3200,5000,"talkDumb",5400,"0",0,6300,"0",0,"0",0,0,'"Sorry Ran"',playFunnyEmoji},
  {"wave",1,0,"0",0,0,"talkDumb",8000,9400,"laugh",9400,"0",0,0,"0",0,"0",0,10000,'"Only Rosie"',playFunnyEmoji}, 
  {"talkDumb2",1,550,"talkDumb",1470,2340,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"P%&ssy"',playFunnyEmoji},
  {"wave",1,0,"talkDumb2Flipped",7690,8750,"talkFastDumb2",9300,10000,"talkDumb2Flipped",10400,"0",0,15000,"0",0,"0",0,0,'"Get It Out"',playFunnyEmoji}, 
  {"talkDumb",1,1600,"talkFastDumb2",1800,2200,"talkSarcastic",4000,5000,"0",0,"0",0,0,"0",0,"0",0,0,'"Mit Failed"',playMadEmoji},  
  {"talkDumb2",1,1000,"talkDumb2Flipped",1600,4300,"talkSarcastic",5300,7130,"talkDumb2",7130,"talkNormal",9000,8500,"0",0,"0",0,10000,'"Beg"',playFunnyEmoji},  
  {"talkDumb",1,1350,"talkDumb2",2500,4300,"talkSarcastic",4700,5200,"talkNormal",6000,"talkNormal",7600,6800,"idle",8000,"talkDumb",9500,11200,'"No Right"',playFunnyEmoji},
  {"talkNormal",1250,2000,"talkSarcastic",2500,4000,"talkDumb2",4450,5600,"talkNormal",6200,"0",0,7300,"0",0,"0",0,0,'"Obama"',playFunnyEmoji}, 
  {"talkDumb",1,4200,"talkDumb2",4500,7800,"0",0,0,"0",0,"0",0,0,"0",0,"wave",7800,8900,'"Date Ivanka"',playMadEmoji},
  {"laugh",1,0,"talkSarcastic",3000,4000,"talkDumb2",4800,5800,"talkDumb",6000,"talkDumb2",6500,6400,"0",0,"0",0,7100,'"100% Savage"',playFunnyEmoji}, 
  {"talkNormal",1,1200,"talkDumb",1400,2400,"talkSarcastic",2700,5000,"talkDumb2",5600,"talkDumb2Flipped",9300,9000,"0",0,"0",0,12600,'"So Stupid"',playFunnyEmoji},
  {"talkNormal",1,0,"talkSarcastic",2400,8000,"talkDumb2",8000,10500,"talkDumb2Flipped",11000,"talkDumb",14600,16000,"0",0,"0",0,0,'"Losers"',playMadEmoji},
  {"laugh",1,0,"talkDumb",4160,4500,"talkDumb2",5500,8000,"0",0,"0",0,0,"0",0,"0",0,0,'"Not Stupid"',playFunnyEmoji}, 
  {"wave",1,0,"talkSarcastic",8300,12000,"talkDumb",12000,0,"talkDumb2",14000,"talkNormal",17200,16700,"0",0,"0",0,18800,'"No Respect"',playFunnyEmoji}, 
  {"talkDumb2Flipped",800,1800,"0",0,0,"0",0,0,"0",0,"0",0,0,"0",0,"0",0,0,'"Nasty Women"',playMadEmoji}  
}

local replayAudio
local playReplayAudio
local specAudio 
local playSpecAudio
---SKIP FUNCTIONS--------------------------------------------------------

getRidOfTimeTable = function()
  for i=1,12 do 
    if timeTable[i] ~= nil then 
      timer.cancel(timeTable[i])
    end
  end
end

local function getRidOfAudio()
  if talkAudio ~= nil then 
    audio.stop(playAudio)
    audio.dispose(talkAudio)
    talkAudio = nil 
    playAudio = nil 
  end
  if replayAudio ~= nil then 
    audio.stop(playReplayAudio)
    audio.dispose(replayAudio)
    replayAudio = nil 
    playReplayAudio = nil 
  end
  if tweet ~= nil then 
    tweet:removeSelf()
    tweet = nil 
  end
  if keyboardSound ~= nil then 
    audio.stop(playKS)
    audio.dispose(keyboardSound)
    keyboardSound = nil 
    playKS = nil 
  end
  if specAudio ~= nil then 
  	audio.stop(playSpecAudio)
 	audio.dispose(specAudio)
 	specAudio = nil 
 	playSpecAudio = nil 
  end
  if tapAudio ~= nil then 
    audio.stop(playTapAudio)
    audio.dispose(tapAudio)
    tapAudio = nil 
    playTapAudio = nil 
  end
end

---TAP FUNCTION--------------------------------------------------------

local function tapTrump()
  showRateIt()
  emoji.y = math.random(140,170)
  emoji.x = math.random(100,200)
  n = math.random(1,nLevel+22)
  tutVar = 2
  tapQuestion()
  getRidOfTimeTable()
  getRidOfAudio()
  if n > nLevel then 
    t = math.random(1,22)
    n = 116
    local tweetRef = tweets[t]
    playTweet(tweetRef[1],tweetRef[2],tweetRef[3])
  elseif n > 115 and unlockVar == true then 
  	local extraVar = n - 115
  	talkAudio = audio.loadStream( "extra/"..extraVar..".m4a" )
  	playAudio = audio.play(talkAudio)
    local talkInd = st[n]
    playit(talkInd[1],talkInd[2],talkInd[3],talkInd[4],talkInd[5],talkInd[6],talkInd[7],
    talkInd[8],talkInd[9],talkInd[10],talkInd[11],talkInd[12],talkInd[13],talkInd[14],
    talkInd[15],talkInd[16],talkInd[17],talkInd[18],talkInd[19],talkInd[20],talkInd[21])
  else
	talkAudio = audio.loadStream( "sayings/"..n..".m4a" )
    playAudio = audio.play(talkAudio)
    local talkInd = st[n]
    playit(talkInd[1],talkInd[2],talkInd[3],talkInd[4],talkInd[5],talkInd[6],talkInd[7],
    talkInd[8],talkInd[9],talkInd[10],talkInd[11],talkInd[12],talkInd[13],talkInd[14],
    talkInd[15],talkInd[16],talkInd[17],talkInd[18],talkInd[19],talkInd[20],talkInd[21])
	end
  return true
end
whiteTap:addEventListener("tap",tapTrump)

---REPLAY FUNCTION - TEST--------------------------------------------------------

local function tapReplay()
  tutVar = 2
  tapQuestion()
  getRidOfTimeTable()
  getRidOfAudio()
  if n > nLevel then 
    local tweetRef = tweets[t]
    playTweet(tweetRef[1],tweetRef[2],tweetRef[3])
  elseif n > 115 and unlockVar == true then 
  	local extraVar = n - 115
  	talkAudio = audio.loadStream( "extra/"..extraVar..".m4a" )
  	playAudio = audio.play(talkAudio)
    local talkInd = st[n]
    playit(talkInd[1],talkInd[2],talkInd[3],talkInd[4],talkInd[5],talkInd[6],talkInd[7],
    talkInd[8],talkInd[9],talkInd[10],talkInd[11],talkInd[12],talkInd[13],talkInd[14],
    talkInd[15],talkInd[16],talkInd[17],talkInd[18],talkInd[19],talkInd[20])
  else 
    replayAudio = audio.loadStream( "sayings/"..n..".m4a" )
    playReplayAudio = audio.play(replayAudio)
    local talkInd = st[n]
  	playit(talkInd[1],talkInd[2],talkInd[3],talkInd[4],talkInd[5],talkInd[6],talkInd[7],
  	talkInd[8],talkInd[9],talkInd[10],talkInd[11],talkInd[12],talkInd[13],talkInd[14],
  	talkInd[15],talkInd[16],talkInd[17],talkInd[18],talkInd[19],talkInd[20])
    end
    buttonTrans(replay)
    loadTap()
	return true
end
replay:addEventListener("tap",tapReplay)

-----------------------------------------------------------

-----PLACK------------------------------------------------------------
local plackGroup = display.newGroup()

local scrollView = widget.newScrollView(
{top = 100,left = 10, width = 310, height = 380, scrollWidth = 600, scrollHeight = 800, listener = scrollListener} )
scrollView.x = screenW/2 
scrollView.y = 250
scrollGroup:insert(scrollView)

local tapRect1 = display.newRect(73,25,140,40)
tapRect1.alpha = 0
local tapRect2 = display.newRect(249,25,140,40)
tapRect2.alpha = 0

local openPage = display.newImage("images/test1.png")
openPage.x = screenW/2 
openPage.y = screenH/2 + 30
scrollGroup:insert(openPage)

local openPageText = display.newText("Sound Board",openPage.x - 70,openPage.y-250,"Age",21)
scrollGroup:insert(openPageText)

local function tapPlack(event)
    tapPlackVar = 1
    -----Getting rid of visuals----------------------------------------
    tapRect1.isHitTestable = false 
    tapRect2.isHitTestable = false 
    scrollGroup.alpha = 0
    tutVar = 2
    tapQuestion()
    ------Transition for button pressed-------------------
    transition.to(event.target,{time=200,xScale=1.1,yScale=1.1,transition=easing.continuousLoop})
    ---Getting Rid of Any Playing Audio and Movements----------------------
    getRidOfTimeTable() 
    getRidOfAudio()
    ----Declaring Variables---------------------
    tapAudio = audio.loadStream( "sayings/"..event.target.num..".m4a" )
    playTapAudio = audio.play(tapAudio)
    -----Playing Trump--------------------
    n = event.target.num
    local talkTapInd = st[event.target.num]
    playit(talkTapInd[1],talkTapInd[2],talkTapInd[3],talkTapInd[4],talkTapInd[5],talkTapInd[6],talkTapInd[7],
    talkTapInd[8],talkTapInd[9],talkTapInd[10],talkTapInd[11],talkTapInd[12],talkTapInd[13],talkTapInd[14],
    talkTapInd[15],talkTapInd[16],talkTapInd[17],talkTapInd[18],talkTapInd[19],talkTapInd[20])
    -------------------------
    return true
end


local function stopTouch()
  -- To make sure your don't tap through the background
  return true 
end
openPage:addEventListener("tap",stopTouch)

local spacer = display.newRect(screenW/2,2700,10,10)
spacer.isVisible = false 
plackGroup:insert(spacer)

local plackX = screenW/2 - 81
local plackY = -50

for i=0,114 do
	plackX = plackX + 150
	if i % 2 == 0 then 
		 plackY = plackY + 90
		 plackX = screenW/2 - 81
	end
	plack[i] = display.newImage("images/specialBox2.png",plackX,plackY)
	plack[i].xScale = 0.8
	plack[i].yScale = 0.8
	plack[i].num = i + 1
    plack[i]:addEventListener("tap",tapPlack)

    local findText = st[i+1]
    plackText1[i] = display.newText(findText[20],plack[i].x,plack[i].y,"Funnier",10)
    plackText2[i] = display.newText("no."..i+1,plack[i].x,plack[i].y + 15,"Funnier",12)

    plackGroup:insert(plack[i])
    plackGroup:insert(plackText1[i])
    plackGroup:insert(plackText2[i])
    openPage:toFront()
	scrollView:insert(plackGroup)
	scrollView:toFront()
end

----Tweet Board Function------------------------------------------------------------

local tweetSelection = 0
local plack4 = {}
local tweetSign = {}
local twitterBoardGroup = display.newGroup()

tweetScroll = widget.newScrollView(
{top = 100,left = 10, width = 310, height = 380, scrollWidth = 600, scrollHeight = 800, listener = scrollListener} )
tweetScroll.x = screenW/2 
tweetScroll.y = 250
scrollGroup:insert(tweetScroll)

local spacer2 = display.newRect(100,600,100,100)
twitterBoardGroup:insert(spacer2)
spacer2.alpha = 0

local scrollBack = display.newImage("images/back.png",65,495)
scrollBack.xScale = 0.8
scrollBack.yScale = 0.8

openPage2 = display.newImage("images/test2.png")
openPage2.x = screenW/2 
openPage2.y = screenH/2 + 30
scrollGroup:insert(openPage2)

local openPageText2 = display.newText("Tweet Board",openPage2.x + 73,openPage2.y-250,"Age",21)
scrollGroup:insert(openPageText2)
scrollGroup:insert(scrollBack)

local function tapTwitterB(event)
    tapPlackVar = 1
    -----Getting rid of visuals----------------------------------------
    tapRect1.isHitTestable = false 
    tapRect2.isHitTestable = false 
    scrollGroup.alpha = 0
    tutVar = 2
    tapQuestion()
    n = event.target.num + nLevel
    t = event.target.num
    ------Transition for button pressed-------------------
    transition.to(event.target,{time=200,xScale=1.1,yScale=1.1,transition=easing.continuousLoop})
    ---Getting Rid of Any Playing Audio and Movements----------------------
    getRidOfTimeTable() 
    getRidOfAudio()

    local choseTapT = tweets[event.target.num]
    playTweet(choseTapT[1],choseTapT[2],choseTapT[3])
    return true
end

local tweetX = screenW/2 - 81
local tweetY = -50

for i=0,21 do 
	tweetX = tweetX + 150
	if i % 2 == 0 then 
		 tweetY = tweetY + 90
		 tweetX = screenW/2 - 81
	end
	plack4[i] = display.newImage("images/specialBoxBlue.png",tweetX,tweetY)
	plack4[i].xScale = 0.8
	plack4[i].yScale = 0.8
	plack4[i]:addEventListener("tap",tapTwitterB)
	plack4[i].num = i + 1
	tweetSign[i] = display.newText( 'Tweet no.'..i + 1, plack4[i].x,plack4[i].y, "Funnier", 11 )
	twitterBoardGroup:insert(plack4[i])
	twitterBoardGroup:insert(tweetSign[i])
	tweetScroll:insert(twitterBoardGroup)
	openPage2:toFront()
	tweetScroll:toFront()
	scrollBack:toFront()
end

local scrollGroupXSCALE = 1
local scrollGroupYSCALE = 1
local XPOSITION = 0
local YPOSITION = 0

local function scrollGroupNorm()
	transition.to(scrollGroup,{time=200,xScale=scrollGroupXSCALE,yScale=scrollGroupYSCALE,y=YPOSITION,x=XPOSITION})
end

local function tapPlus()
  tutVar = 2
  tapQuestion()
  if tapPlackVar == 1 then
  	specGroup.alpha = 0
  	specVar = 1
    transition.to(scrollGroup,{time=100,xScale=scrollGroupXSCALE - 0.05,yScale=scrollGroupYSCALE - 0.05,y=YPOSITION+7,x=XPOSITION+7,alpha=1,transition=easing.outBack,onComplete=scrollGroupNorm})
    scrollGroup:toFront()
    openPageText:toFront()
    openPageText2:toFront()
    scrollBack:toFront()
    tapPlackVar = 2 
    tapRect1.isHitTestable = true 
    tapRect2.isHitTestable = true 
  elseif tapPlackVar == 2 then 
    transition.to(scrollGroup,{time=100,xScale=scrollGroupXSCALE - 0.05,yScale=scrollGroupYSCALE - 0.05,y=YPOSITION+7,x=XPOSITION+7,alpha=0,transition=easing.outBack,onComplete=scrollGroupNorm})
    tapPlackVar = 1 
    tapRect1.isHitTestable = false 
    tapRect2.isHitTestable = false 
  end
  tapRect1:toFront()
  tapRect2:toFront()
  loadTap()
  buttonTrans(plus)
end
plus:addEventListener("tap",tapPlus)

local function tapScrollBack() 
	animateButton(0,0.9,0.9,150,scrollBack)
	transition.to(scrollGroup,{time=100,xScale=0.95,yScale=0.95,y=7,x=7,alpha=0,transition=easing.outBack,onComplete=scrollGroupNorm})
    tapPlackVar = 1 
    tapRect1.isHitTestable = false 
    tapRect2.isHitTestable = false 
    loadTap() 
end
scrollBack:addEventListener("tap",tapScrollBack)

------------------------------------------------

------------------------------------------------

local function tapOpenPage1()
  openPage:toFront()
  scrollView:toFront()
  tapRect1:toFront()
  tapRect2:toFront()
  openPageText:toFront()
  scrollBack:toFront()
  loadTap()
end
tapRect1:addEventListener("tap",tapOpenPage1)

local function tapOpenPage2()
  openPage2:toFront()
  tweetScroll:toFront()
  tapRect1:toFront()
  tapRect2:toFront()
  openPageText2:toFront()
  scrollBack:toFront()
  loadTap()
end
tapRect2:addEventListener("tap",tapOpenPage2)

tappedVar = false
openPage:toFront()
scrollView:toFront()

----Tutorial Code---------------------------------------------------------------
local questTextOptions = {
  text = "Click anywhere to make Trump talk and tweet! Tap on the more button in the upper right corner to open the Soundboard and Tweet-Board!",
  width = screenW - 16,
  x = screenW/2,
  y = (screenH - actualHeight)/2 + 200,
  font = "ComicNeueSansID",
  fontSize = 17,
  align = "center",
}

local tutorialGroup = display.newGroup()
local tutBack = display.newRect(screenW/2,screenH/2,screenW+300,screenH+200)
tutBack.alpha = 0.4
tutBack:setFillColor(0,0,0)
local tutText = display.newText( questTextOptions )
local tutArrow = display.newImage("images/arrow.png",280,(screenH - actualHeight)/2 + 100)
tutArrow.xScale = 0.2
tutArrow.yScale = 0.2
tutArrow.rotation = 90
tutorialGroup:insert(tutBack)
tutorialGroup:insert(tutText)
tutorialGroup:insert(tutArrow)
tutorialGroup.alpha = 0
local tutArrowTrans = transition.to(tutArrow,{time=1000,y=(screenH - actualHeight)/2 + 110,transition=easing.continuousLoop,iterations=-1})

local function tapBack()
	getRidOfAudio()
	buttonTrans(back)
	composer.gotoScene("menu","slideRight",1000)
	loadTap()
	return true 
end
back:addEventListener("tap",tapBack)

-----------------------------------------------------------------
specGroup = display.newGroup()

local function specGroupNorm()
	transition.to(specGroup,{time=200,xScale=scrollGroupXSCALE,yScale=scrollGroupXSCALE,y=XPOSITION,x=XPOSITION})
end

local specBack = display.newImage("images/specBack.png")
specBack.x = screenW/2
specBack.y = screenH/2 + 30

local speckgoBack = display.newImage("images/back.png",65,495)
speckgoBack.xScale = 0.8
speckgoBack.yScale = 0.8

local function tapSpeckgoBack() 
	animateButton(0,0.9,0.9,150,speckgoBack)
	specVar = 1
	transition.to(specGroup,{time=100,xScale=0.95,yScale=0.95,y=7,x=7,alpha=0,transition=easing.outBack,onComplete=specGroupNorm}) 
	loadTap()
end
speckgoBack:addEventListener("tap",tapSpeckgoBack)

local specScroll = widget.newScrollView(
{top = 100,left = 10, width = 295, height = 390, scrollWidth = 600, scrollHeight = 800, listener = scrollListener} )
specScroll.x = screenW/2 
specScroll.y = screenH/2 + 10

local specBackPlacementX = screenW/2 - 87
local specBackPlacementY = -50

local function unlockAert2(event)
	if ( event.action == "clicked" ) then
	local tapChoice2 = event.index 
	if tapChoice2 == 1 then 
		getRidOfAudio()
		composer.gotoScene("menu","fade",300)
       	timer.performWithDelay(400,function() buyUnlock() end,1)
       end
	end 
end

local function unlockAlert( event )
    if ( event.action == "clicked" ) then
        local tapChoice = event.index
        if ( tapChoice == 1 ) then
        	getRidOfAudio()
        	composer.gotoScene("menu","fade",300)
        	timer.performWithDelay(400,function() buyUnlock() end,1)
        elseif ( tapChoice == 2 ) then
        	native.showAlert( "Are You Sure ?","You can unlock 30 of the best audio clips and poses!", { "Yes", "No" },unlockAert2)
		end
    end
end

local function tapSpec(event)
	if unlockVar == true or unlockV2 == true then 
		specVar = 1
	    -----Getting rid of visuals----------------------------------------
	    specGroup.alpha = 0
	    ---Getting Rid of Any Playing Audio and Movements----------------------
	    getRidOfTimeTable() 
	    getRidOfAudio()

	    n = event.target.num + 115
	   	specAudio = audio.loadStream( "extra/"..event.target.num..".m4a" )
	    playSpecAudio = audio.play(specAudio)
	    local choseSpec = st[n]
	    playit(choseSpec[1],choseSpec[2],choseSpec[3],choseSpec[4],choseSpec[5],choseSpec[6],choseSpec[7],
	    choseSpec[8],choseSpec[9],choseSpec[10],choseSpec[11],choseSpec[12],choseSpec[13],choseSpec[14],
	    choseSpec[15],choseSpec[16],choseSpec[17],choseSpec[18],choseSpec[19],choseSpec[20])
	elseif unlockVar == nil and unlockV2 == false then 
		native.showAlert( "Oops!","You need to buy this content to unlock it.", { "Yes Please!", "No" }, unlockAlert )
	end
end

local function preventSpecTouch()
	return true
end
specBack:addEventListener("tap",preventSpecTouch)

local lock = {}
local l = 0

for i=0,29 do
	specBackPlacementX = specBackPlacementX + 150
	if i % 2 == 0 then 
	 specBackPlacementY = specBackPlacementY + 90
	 specBackPlacementX = screenW/2 - 87
	end
	local specBox = display.newImage("images/specialBox2.png")
	specBox.x = specBackPlacementX
	specBox.y = specBackPlacementY
	specBox.num = i + 1
	specBox.xScale = 0.8
	specBox.yScale = 0.8
	specScroll:insert(specBox)
	local specIt = st[i + 116]
	local specText = display.newText(specIt[20],specBox.x,specBox.y,"Funnier",13)
	specScroll:insert(specText)
	specBox:addEventListener("tap",tapSpec)
	if unlockVar == nil then 
		l = l + 1
		lock[l] = display.newImage("images/lock.png",specBox.x + 45, specBox.y - 20)
		lock[l].xScale = 0.4
		lock[l].yScale = 0.4
		specScroll:insert(lock[l])
	end
end

removeLock = function()
	if lock ~= nil and unlockV2 == true then 
		for i=1,l do
			lock[i].alpha = 0
		end
	end
end

specGroup:insert(specBack)
specGroup:insert(speckgoBack)
specGroup:insert(specScroll)
specGroup.alpha = 0

local function tapStar()
	tutVar = 2
  	tapQuestion()
	specGroup:toFront()
  if specVar == 1 then 
	  transition.to(specGroup,{time=100,xScale=scrollGroupXSCALE - 0.05,yScale=scrollGroupXSCALE - 0.05,y=YPOSITION+7,x=YPOSITION+7,alpha=1,transition=easing.outBack,onComplete=specGroupNorm})
	  scrollGroup.alpha = 0
	  tapPlackVar = 1
	  buttonTrans(star)
	  specVar = 2 
  elseif specVar == 2 then 
  	  transition.to(specGroup,{time=100,xScale=scrollGroupXSCALE - 0.05,yScale=scrollGroupXSCALE - 0.05,y=YPOSITION+7,x=YPOSITION+7,alpha=0,transition=easing.outBack,onComplete=specGroupNorm})
	  buttonTrans(star)
	  specVar = 1
	end
	loadTap()
	return true
  end
star:addEventListener("tap",tapStar)
-----------------------------------------------------------------

tapQuestion = function()
  if tutVar == 1 then
    loadTap() 
    transition.to(tutorialGroup,{time=500,alpha=1})
    tutVar = 2
    transition.resume(tutArrowTrans)
    --Getting Rid of Visuals----------------
    scrollGroup.alpha = 0
    specGroup.alpha = 0
    tapPlackVar = 1 
    specVar = 1
    plus:toFront()
    	if tweet ~= nil then 
    		tweet.alpha = 0
    	end
    ------------------
   buttonTrans(question)
  elseif tutVar == 2 then
    transition.pause(tutArrowTrans)
    transition.to(tutorialGroup,{time=200,alpha=0})
    tutArrowTrans = nil
    tutVar = 1
    end 
  end
question:addEventListener("tap",tapQuestion)
-----------------------------------------------------------------
configIpad = function ()
	if system.getInfo("model") == "iPad" then
		scrollGroupXSCALE = 0.9
		scrollGroupYSCALE = 0.9
		XPOSITION = 14
		YPOSITION = 14
	end
end
-----------------------------------------------------------------

scrollGroup.alpha = 0
scrollGroup:toFront()

sceneGroup:insert(background)
sceneGroup:insert(whiteTap)
sceneGroup:insert(plus)
sceneGroup:insert(replay)
sceneGroup:insert(star)
sceneGroup:insert(question)
sceneGroup:insert(back)
sceneGroup:insert(titleText)
sceneGroup:insert(trump)
sceneGroup:insert(tapRect1)
sceneGroup:insert(tapRect2)
sceneGroup:insert(spacer)
sceneGroup:insert(spacer2)
sceneGroup:insert(tutorialGroup)
sceneGroup:insert(scrollGroup)
sceneGroup:insert(specGroup)
sceneGroup:insert(emoji)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		audio.pause()
		configIpad()
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		removeLock()
		composer.removeScene("load")
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		getRidOfTimeTable()
		trump:setSequence("laugh")
		trump:play()
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene