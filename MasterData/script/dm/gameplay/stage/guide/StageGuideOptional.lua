-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/guide/StageGuideOptional.lua

local guide = setmetatable({}, {
	__index = StageGuide
})

function guide:main(guideThread, battleContext)
	local eventCenter = battleContext:getObject("EventCenter")

	eventCenter:addListener("GuideUnitSpawned", bind1(self.onGuideUnitSpawned, self), 0)

	local battleRecorder = battleContext:getObject("BattleRecorder")

	self._battleRecorder = battleRecorder
	self._guideThread = guideThread

	battleRecorder:newTimeline(kBRGuideLine, "BattleGuideLine")

	local event = guideThread:suspend(guideThread:wakeupOnBattleEvent("GoFighting"))

	battleRecorder:recordEvent(kBRGuideLine, "SetupOptionalGuide", {})
end

function guide:onGuideUnitSpawned(_, args)
	self._battleRecorder:recordEvent(kBRGuideLine, "EndOptionalGuide", {})
end

return guide
