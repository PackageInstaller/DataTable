-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/guide/PracticeGuideCommon.lua

local guide = setmetatable({}, {
	__index = StagePracticeGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "HidePauseButton")
	guideThread:disableAI()

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("EnterNewRound"))

	guideThread:inactivateBattleThread()
	battleRecorder:recordEvent(kBRGuideLine, "PauseTime")

	event = guideThread:suspend(guideThread:wakeupOnInput())

	battleRecorder:recordEvent(kBRGuideLine, "ResumeTime")
	guideThread:activateBattleThread()
	guideThread:enableAI()
end

return guide
