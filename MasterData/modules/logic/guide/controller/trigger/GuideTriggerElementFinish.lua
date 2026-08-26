-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerElementFinish.lua

module("modules.logic.guide.controller.trigger.GuideTriggerElementFinish", package.seeall)

local GuideTriggerElementFinish = class("GuideTriggerElementFinish", BaseGuideTrigger)

function GuideTriggerElementFinish:ctor(triggerKey)
	GuideTriggerElementFinish.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
end

function GuideTriggerElementFinish:assertGuideSatisfy(param, configParam)
	local configElementId = tonumber(configParam)
	local mapId = tonumber(param)
	local co = DungeonConfig.instance:getChapterMapElement(configElementId)

	if co and co.mapId == mapId and DungeonMapModel.instance:elementIsFinished(configElementId) then
		return true
	end

	return false
end

function GuideTriggerElementFinish:_OnUpdateMapElementState(mapId)
	self:checkStartGuide(mapId)
end

return GuideTriggerElementFinish
