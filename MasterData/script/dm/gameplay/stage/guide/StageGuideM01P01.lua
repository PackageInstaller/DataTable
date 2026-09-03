-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM01P01.lua

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
	battleRecorder:recordEvent(kBRGuideLine, "HideRoleObject", {
		pos = 2
	})
	battleRecorder:recordEvent(kBRGuideLine, "ShowGroundLayer")
	battleRecorder:recordEvent(kBRGuideLine, "HideSkillButton")

	local waitTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_Time2", "content") or 5000

	waitTime = waitTime / 1000

	local teamA = battleContext:getObject("TeamA")
	local playerA = teamA:getCurPlayer()
	local heroCard1 = self:newHeroCard(playerA, "Special_M01S01U01", 1)

	self:insertCard(battleContext, playerA, heroCard1, 1)

	local TeamB = battleContext:getObject("TeamB")
	local playerB = TeamB:getCurPlayer()
	local unitData1 = self:newMasterUnitData(playerB, "Special_M01S01_Master", 1)

	self:spawnUnit(battleContext, playerB, 8, unitData1, true)

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "HideStartBattleAni")
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		duration = 3,
		statisticPoint = "guide_main_stage_1_1_6",
		pause = true,
		text = Strings:get("NewPlayerGuide_101_3", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowHero", {
		style = "enemy",
		maskRes = "asset/story/zhandou_mask08.png",
		pause = true,
		statisticPoint = "guide_main_stage_1_1_7",
		maskSize = {
			w = 130,
			h = 200
		},
		text = Strings:get("NewPlayerGuide_101_4", {
			fontName = TTF_FONT_STORY
		}),
		offset = {
			x = 0,
			y = 80
		},
		nextShow = {
			style = "self",
			maskRes = "asset/story/zhandou_mask08.png",
			statisticPoint = "guide_main_stage_1_1_8",
			maskSize = {
				w = 130,
				h = 200
			},
			text = Strings:get("NewPlayerGuide_101_5", {
				fontName = TTF_FONT_STORY
			}),
			offset = {
				x = 10,
				y = 80
			}
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		duration = 3,
		statisticPoint = "guide_main_stage_1_1_9",
		pause = true,
		text = Strings:get("NewPlayerGuide_101_6", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "card",
		maskRes = "asset/story/zhandou_mask08.png",
		cardIndex = 1,
		statisticPoint = "guide_main_stage_1_1_10",
		maskSize = {
			w = 130,
			h = 130
		},
		text = Strings:get("NewPlayerGuide_101_7", {
			fontName = TTF_FONT_STORY
		}),
		offset = {
			x = 0,
			y = 14
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "cardcost",
		maskRes = "asset/story/zhandou_mask08.png",
		cardIndex = 1,
		complexityNum = 9,
		statisticPoint = "guide_main_stage_1_1_11",
		maskSize = {
			w = 40,
			h = 50
		},
		text = Strings:get("NewPlayerGuide_101_8", {
			fontName = TTF_FONT_STORY
		}),
		offset = {
			x = -2,
			y = 1
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowGuideText", {
		duration = 3,
		statisticPoint = "guide_main_stage_1_1_12",
		pause = true,
		text = Strings:get("NewPlayerGuide_101_9", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "energy",
		maskRes = "asset/story/zhandou_mask02.png",
		complexityNum = 9,
		effectRes = "effect1_yindaoguangquan",
		statisticPoint = "guide_main_stage_1_1_13",
		text = Strings:get("NewPlayerGuide_101_10", {
			fontName = TTF_FONT_STORY
		}),
		textRefpt = {
			x = 0.5,
			y = 0.25
		},
		offset = {
			x = 22,
			y = 0
		}
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "RoleGoBattle", {
		pos = 2
	})
	guideThread:sleepForTime(1500)
	battleRecorder:recordEvent(kBRGuideLine, "StartGuide", {
		cell = 2,
		autoRotation = true,
		effectStyle = "drag_auto",
		statisticPoint = "guide_main_stage_1_1_14",
		cardIndex = 1,
		style = "slideCard",
		pause = true,
		text = Strings:get("NewPlayerGuide_101_11", {
			fontName = TTF_FONT_STORY
		}),
		textRefpt = {
			x = 0.65,
			y = 0.35
		},
		duration = waitTime
	})
	guideThread:sleepForTime(1)
end

return guide
