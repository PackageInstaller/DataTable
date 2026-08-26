-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerWeekWalkLayerOpen.lua

module("modules.logic.guide.controller.trigger.GuideTriggerWeekWalkLayerOpen", package.seeall)

local GuideTriggerWeekWalkLayerOpen = class("GuideTriggerWeekWalkLayerOpen", BaseGuideTrigger)

function GuideTriggerWeekWalkLayerOpen:ctor(triggerKey)
	GuideTriggerWeekWalkLayerOpen.super.ctor(self, triggerKey)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, self._checkStartGuide, self)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnWeekwalkInfoUpdate, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerWeekWalkLayerOpen:assertGuideSatisfy(param, configParam)
	local mapId = tonumber(configParam)

	return (WeekWalkModel.instance:getMapInfo(mapId))
end

function GuideTriggerWeekWalkLayerOpen:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerWeekWalkLayerOpen:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerWeekWalkLayerOpen
