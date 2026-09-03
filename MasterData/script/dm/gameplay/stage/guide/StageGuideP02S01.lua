-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideP02S01.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "StartStory", {
		pause = true,
		statisticPoint = "guide_Stage_Xunlian1_4",
		story = "guide_plot_11"
	})
	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 2,
		style = "slideCard",
		autoRotation = true,
		dir = 1,
		effectStyle = "drag_auto",
		statisticPoint = "guide_Stage_Xunlian1_5",
		cardIndex = 1,
		heroId = "CLMan",
		pause = true,
		text = Strings:get("NewPlayerGuide_102_5", {
			fontName = TTF_FONT_STORY
		}),
		textRefpt = {
			x = 0.65,
			y = 0.35
		},
		duration = waitTime
	})
end

return guide
