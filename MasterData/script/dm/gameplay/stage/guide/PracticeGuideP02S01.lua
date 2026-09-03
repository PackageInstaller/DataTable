-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/PracticeGuideP02S01.lua

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
	battleRecorder:recordEvent(kBRGuideLine, "StartStory", {
		pause = true,
		complexityNum = 9,
		statisticPoint = "guide_Stage_Xunlian1_4",
		story = "guide_plot_11"
	})
	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 5,
		complexityNum = 9,
		effectStyle = "drag_auto",
		autoRotation = true,
		hero = "Model_SLMen",
		statisticPoint = "guide_Stage_Xunlian1_5",
		style = "slideCard",
		pause = true,
		textRefpt = {
			x = 0.65,
			y = 0.35
		},
		duration = waitTime
	})
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
