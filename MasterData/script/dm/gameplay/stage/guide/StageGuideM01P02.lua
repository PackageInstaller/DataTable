-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM01P02.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)
	battleRecorder:recordEvent(kBRGuideLine, "HidePauseButton")
	battleRecorder:recordEvent(kBRGuideLine, "HideGroundLayer")
	guideThread:sleepForFrames(2)
	battleRecorder:recordEvent(kBRGuideLine, "HideSkillButton")

	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content") or 5000

	waitTime = waitTime / 1000

	local teamA = battleContext:getObject("TeamA")
	local playerA = teamA:getCurPlayer()
	local heroCard1 = self:newHeroCard(playerA, "Special_M01S02U01", 1)

	self:insertCard(battleContext, playerA, heroCard1, 1)

	local heroCard2 = self:newHeroCard(playerA, "Special_M01S02U02", 2)

	self:insertCard(battleContext, playerA, heroCard2, 2)

	local TeamB = battleContext:getObject("TeamB")
	local playerB = TeamB:getCurPlayer()
	local unitData1 = self:newMasterUnitData(playerB, "Special_M01S02_Master", 1)

	self:spawnUnit(battleContext, playerB, 8, unitData1, true)

	local unitData2 = self:newUnitData(playerB, "SpecialEnemy_M01S02U01", 2)

	self:spawnUnit(battleContext, playerB, 2, unitData2, false)

	local unitData3 = self:newUnitData(playerB, "SpecialEnemy_M01S02U02", 3)

	self:spawnUnit(battleContext, playerB, 5, unitData3, false)
	guideThread:sleepForFrames(2)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGroundLayer")

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "StartStory", {
		pause = true,
		story = "blockstory01_2start"
	})
	guideThread:sleepForFrames(1)

	local speekTime = 2000

	battleRecorder:recordEvent(kBRGuideLine, "ShowUnitSpeak", {
		delay = 0,
		pos = 2,
		statisticPoint = "guide_main_stage_1_2_6",
		stmts = {
			{
				Strings:get("NewPlayerGuide_OneLine_Text1"),
				speekTime
			}
		}
	})
	battleRecorder:recordEvent(kBRGuideLine, "ShowUnitSpeak", {
		delay = 0,
		pos = 5,
		stmts = {
			{
				Strings:get("NewPlayerGuide_OneLine_Text2"),
				speekTime
			}
		}
	})
	battleRecorder:recordEvent(kBRGuideLine, "ShowUnitSpeak", {
		delay = 0,
		pos = 8,
		stmts = {
			{
				Strings:get("NewPlayerGuide_OneLine_Text3"),
				speekTime
			}
		}
	})
	guideThread:sleepForTime(speekTime)
	guideThread:sleepForFrames(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		heroId = "CLMan",
		pause = true,
		dir = 0,
		duration = 3,
		statisticPoint = "guide_main_stage_1_2_7",
		text = Strings:get("NewPlayerGuide_102_3", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowRedCells", {
		heroId = "CLMan",
		pause = true,
		dir = 0,
		duration = 3,
		statisticPoint = "guide_main_stage_1_2_8",
		text = Strings:get("NewPlayerGuide_102_4", {
			fontName = TTF_FONT_STORY
		}),
		cellsIndex = {
			2,
			5,
			8
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "HideRedCells")
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 2,
		style = "slideCard",
		autoRotation = true,
		dir = 1,
		effectStyle = "drag_auto",
		statisticPoint = "guide_main_stage_1_2_9",
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
	guideThread:sleepForFrames(100)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
