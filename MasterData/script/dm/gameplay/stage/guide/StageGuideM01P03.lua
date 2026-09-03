-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM01P03.lua

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
	local heroCard1 = self:newHeroCard(playerA, "Special_M01S03U01", 1)

	self:insertCard(battleContext, playerA, heroCard1, 1)

	local heroCard2 = self:newHeroCard(playerA, "Special_M01S03U03", 2)

	self:insertCard(battleContext, playerA, heroCard2, 2)

	local heroCard3 = self:newHeroCard(playerA, "Special_M01S03U02", 3)

	self:insertCard(battleContext, playerA, heroCard3, 3)

	local TeamB = battleContext:getObject("TeamB")
	local playerB = TeamB:getCurPlayer()
	local unitData2 = self:newUnitData(playerB, "SpecialEnemy_M01S03U01", 2)

	self:spawnUnit(battleContext, playerB, 2, unitData2, false)

	local unitData3 = self:newUnitData(playerB, "SpecialEnemy_M01S03U02", 3)

	self:spawnUnit(battleContext, playerB, 5, unitData3, false)
	guideThread:sleepForFrames(2)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGroundLayer")

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		pause = true,
		dir = 0,
		duration = 3,
		statisticPoint = "guide_main_stage_1_3_9",
		text = Strings:get("NewPlayerGuide_104_6", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "cardjob",
		maskRes = "asset/story/zhandou_mask08.png",
		statisticPoint = "guide_main_stage_1_3_10",
		maskSize = {
			w = 44,
			h = 44
		},
		offset = {
			x = 0,
			y = 0
		},
		text = Strings:get("NewPlayerGuide_104_7", {
			fontName = TTF_FONT_STORY
		}),
		cardIndex = {
			1,
			2,
			3
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "cardjob",
		maskRes = "asset/story/zhandou_mask08.png",
		cardIndex = 1,
		complexityNum = 9,
		statisticPoint = "guide_main_stage_1_3_11",
		maskSize = {
			w = 44,
			h = 44
		},
		offset = {
			x = 0,
			y = 0
		},
		text = Strings:get("NewPlayerGuide_104_8", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "cardjob",
		maskRes = "asset/story/zhandou_mask08.png",
		cardIndex = 2,
		complexityNum = 9,
		statisticPoint = "guide_main_stage_1_3_12",
		maskSize = {
			w = 44,
			h = 44
		},
		offset = {
			x = 0,
			y = 0
		},
		text = Strings:get("NewPlayerGuide_104_9", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "cardjob",
		maskRes = "asset/story/zhandou_mask08.png",
		cardIndex = 3,
		complexityNum = 9,
		statisticPoint = "guide_main_stage_1_3_13",
		maskSize = {
			w = 44,
			h = 44
		},
		offset = {
			x = 0,
			y = 0
		},
		text = Strings:get("NewPlayerGuide_104_10", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 2,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "guide_main_stage_1_3_14",
		cardIndex = 1,
		style = "slideCard",
		pause = true,
		text = Strings:get("NewPlayerGuide_104_11", {
			fontName = TTF_FONT_STORY
		}),
		textRefpt = {
			x = 0.65,
			y = 0.35
		},
		duration = waitTime
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
