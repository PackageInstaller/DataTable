-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideM03P01.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local battleRecorder = battleContext:getObject("BattleRecorder")

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", false)

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "speedBtn",
		maskRes = "asset/story/zhandou_mask08.png",
		statisticPoint = "guide_auto_battle_2",
		maskSize = {
			w = 62,
			h = 62
		},
		offset = {
			x = -1,
			y = 1
		},
		text = Strings:get("NewPlayerGuide_219_2", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "ShowMode", {
		style = "autoBtn",
		maskRes = "asset/story/zhandou_mask08.png",
		statisticPoint = "guide_auto_battle_1",
		maskSize = {
			w = 62,
			h = 62
		},
		offset = {
			x = -1,
			y = 1
		},
		text = Strings:get("NewPlayerGuide_219_1", {
			fontName = TTF_FONT_STORY
		})
	})
	guideThread:sleepForTime(1)
	battleRecorder:recordEvent(kBRGuideLine, "TouchEnabled", true)
end

return guide
