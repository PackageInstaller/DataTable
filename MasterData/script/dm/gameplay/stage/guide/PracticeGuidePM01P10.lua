-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/PracticeGuidePM01P10.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)
	guideThread:sleepForFrames(2)

	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content") or 5000

	waitTime = waitTime / 1000

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	guideThread:sleepForTime(800)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		opacity = 125,
		pause = true,
		text = Strings:get("NewPlayerGuide_201_5", {
			fontName = TTF_FONT_FZYH_R
		}),
		textRefpt = {
			x = 0.61,
			y = 0.14
		},
		cardShowNum = {
			{
				pos = 1
			},
			{
				pos = 2
			},
			{
				pos = 3
			},
			{
				pos = 4
			},
			{
				pos = 5
			},
			{
				pos = 6
			},
			{
				pos = 7
			},
			{
				pos = 8
			},
			{
				pos = 9
			},
			{
				pos = 1,
				style = 1
			},
			{
				pos = 2,
				style = 1
			},
			{
				pos = 3,
				style = 1
			},
			{
				pos = 4,
				style = 1
			},
			{
				pos = 5,
				style = 1
			},
			{
				pos = 6,
				style = 1
			},
			{
				pos = 7,
				style = 1
			},
			{
				pos = 8,
				style = 1
			},
			{
				pos = 9,
				style = 1
			}
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 9,
		autoRotation = true,
		effectStyle = "drag_auto",
		cardIndex = 1,
		style = "slideCard",
		pause = true,
		text = Strings:get("NewPlayerGuide_201_6", {
			fontName = TTF_FONT_FZYH_R
		}),
		textRefpt = {
			x = 0.65,
			y = 0.35
		},
		duration = waitTime,
		celltext = Strings:get("NewPlayerGuide_201_6", {
			fontName = TTF_FONT_FZYH_R
		})
	})
	guideThread:sleepForFrames(74)
	battleRecorder:recordEvent(kBRGuideLine, "ShowHero", {
		pos = 1,
		nextPos = 1,
		nextStyle = "enemy",
		pause = true,
		maskRes = "asset/story/zhandou_mask03.png",
		text = Strings:get("NewPlayerGuide_201_7", {
			fontName = TTF_FONT_FZYH_R
		}),
		textRefpt = {
			x = 0.33,
			y = 0.47
		},
		offset = {
			x = 0,
			y = 80
		},
		cardShowNum = {
			{
				pos = 1
			},
			{
				pos = 1,
				style = 1
			}
		}
	})
	guideThread:sleepForFrames(50)
	battleRecorder:recordEvent(kBRGuideLine, "ShowHero", {
		pos = 3,
		nextPos = 3,
		nextStyle = "enemy",
		pause = true,
		maskRes = "asset/story/zhandou_mask03.png",
		text = Strings:get("NewPlayerGuide_201_8", {
			fontName = TTF_FONT_FZYH_R
		}),
		textRefpt = {
			x = 0.3,
			y = 0.2
		},
		offset = {
			x = 0,
			y = 80
		},
		cardShowNum = {
			{
				pos = 3,
				num = 2
			},
			{
				style = 1,
				num = 2,
				pos = 3
			}
		}
	})
	guideThread:sleepForFrames(44)
	battleRecorder:recordEvent(kBRGuideLine, "ShowHero", {
		pos = 5,
		nextPos = 4,
		nextStyle = "enemy",
		pause = true,
		maskRes = "asset/story/zhandou_mask03.png",
		text = Strings:get("NewPlayerGuide_201_9", {
			fontName = TTF_FONT_FZYH_R
		}),
		textRefpt = {
			x = 0.3,
			y = 0.2
		},
		offset = {
			x = 0,
			y = 80
		},
		cardShowNum = {
			{
				pos = 5,
				num = 3
			},
			{
				style = 1,
				num = 3,
				pos = 4
			}
		},
		nextShowGuideText = {
			opacity = 125,
			pause = true,
			text = Strings:get("NewPlayerGuide_201_10", {
				fontName = TTF_FONT_FZYH_R
			}),
			textRefpt = {
				x = 0.5,
				y = 0.35
			}
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
