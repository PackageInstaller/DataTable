-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM02P01.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)
	battleRecorder:recordEvent(kBRGuideLine, "HidePauseButton")
	guideThread:sleepForFrames(2)
	battleRecorder:recordEvent(kBRGuideLine, "HideSkillButton")

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
