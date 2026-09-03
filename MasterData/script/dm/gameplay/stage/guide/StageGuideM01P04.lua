-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM01P04.lua

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

	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content") or 5000

	waitTime = waitTime / 1000

	local teamA = battleContext:getObject("TeamA")
	local playerA = teamA:getCurPlayer()
	local heroCard1 = self:newHeroCard(playerA, "Special_M01S04U02", 1)

	self:insertCard(battleContext, playerA, heroCard1, 1)

	local heroCard2 = self:newHeroCard(playerA, "Special_M01S04U03", 2)

	self:insertCard(battleContext, playerA, heroCard2, 2)

	local heroCard3 = self:newHeroCard(playerA, "Special_M01S04U01", 3)

	self:insertCard(battleContext, playerA, heroCard3, 3)

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		pause = true,
		dir = 0,
		duration = 3,
		statisticPoint = "guide_main_stage_1_4_5",
		text = Strings:get("NewPlayerGuide_105_2", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
	guideThread:sleepForTime(6450)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)
	battleRecorder:recordEvent(kBRGuideLine, "AutoGuide", {
		cardIndex = 1,
		style = "slideCard",
		cell = 2,
		pause = true,
		effectStyle = "drag_auto",
		autoRotation = true,
		statisticPoint = "guide_main_stage_1_4_6",
		duration = waitTime
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
