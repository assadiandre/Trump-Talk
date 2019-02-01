--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c805d8e2e4a897fd149290cdc20ab8de:6df7a46b94176deece04804e8f3836ea:94cc8898d4bed31ca9b9630e546817b9$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1
            x=1,
            y=1,
            width=442,
            height=418,

            sourceX = 76,
            sourceY = 14,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 2
            x=445,
            y=1,
            width=442,
            height=418,

            sourceX = 76,
            sourceY = 14,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 3
            x=889,
            y=1,
            width=554,
            height=392,

            sourceX = 33,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 4
            x=1445,
            y=1,
            width=554,
            height=392,

            sourceX = 33,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 5
            x=1,
            y=421,
            width=472,
            height=408,

            sourceX = 41,
            sourceY = 24,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 6
            x=475,
            y=421,
            width=478,
            height=408,

            sourceX = 40,
            sourceY = 24,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 7
            x=955,
            y=421,
            width=544,
            height=392,

            sourceX = 31,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 8
            x=1501,
            y=421,
            width=544,
            height=392,

            sourceX = 31,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 9
            x=1,
            y=831,
            width=544,
            height=392,

            sourceX = 24,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 10
            x=547,
            y=831,
            width=544,
            height=392,

            sourceX = 24,
            sourceY = 40,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 11
            x=1093,
            y=831,
            width=550,
            height=400,

            sourceX = 24,
            sourceY = 32,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 12
            x=1,
            y=1233,
            width=550,
            height=400,

            sourceX = 24,
            sourceY = 32,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 13
            x=553,
            y=1233,
            width=462,
            height=390,

            sourceX = 34,
            sourceY = 42,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 14
            x=1017,
            y=1233,
            width=470,
            height=398,

            sourceX = 41,
            sourceY = 34,
            sourceWidth = 600,
            sourceHeight = 432
        },
        {
            -- 15-2
            x=1489,
            y=1233,
            width=424,
            height=568,

            sourceX = 115,
            sourceY = 32,
            sourceWidth = 600,
            sourceHeight = 600
        },
        {
            -- 15
            x=1,
            y=1803,
            width=424,
            height=568,

            sourceX = 115,
            sourceY = 32,
            sourceWidth = 600,
            sourceHeight = 600
        },
        {
            -- 16-2
            x=427,
            y=1803,
            width=388,
            height=544,

            sourceX = 111,
            sourceY = 56,
            sourceWidth = 600,
            sourceHeight = 600
        },
        {
            -- 16
            x=817,
            y=1803,
            width=388,
            height=544,

            sourceX = 111,
            sourceY = 56,
            sourceWidth = 600,
            sourceHeight = 600
        },
        {
            -- 17
            x=1207,
            y=1803,
            width=572,
            height=548,

            sourceX = 8,
            sourceY = 52,
            sourceWidth = 600,
            sourceHeight = 600
        },
    },
    
    sheetContentWidth = 2046,
    sheetContentHeight = 2372
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["10"] = 10,
    ["11"] = 11,
    ["12"] = 12,
    ["13"] = 13,
    ["14"] = 14,
    ["15-2"] = 15,
    ["15"] = 16,
    ["16-2"] = 17,
    ["16"] = 18,
    ["17"] = 19,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
