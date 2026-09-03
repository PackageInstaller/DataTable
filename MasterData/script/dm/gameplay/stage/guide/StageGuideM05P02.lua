-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM05P02.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)

	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content") or 5000

	waitTime = waitTime / 1000

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "StartStory", {
		pause = true,
		statisticPoint = "guide_Measter_skill_1",
		story = "guide_plot_24"
	})
	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		skillIndex = 1,
		style = "unique",
		pause = true,
		statisticPoint = "guide_Measter_skill_2",
		duration = waitTime,
		offset = {
			x = 5,
			y = 5
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
