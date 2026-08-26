-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEnterExplore.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEnterExplore", package.seeall)

local GuideTriggerEnterExplore = class("GuideTriggerEnterExplore", BaseGuideTrigger)

function GuideTriggerEnterExplore:ctor(triggerKey)
	GuideTriggerEnterExplore.super.ctor(self, triggerKey)
	ExploreController.instance:registerCallback(ExploreEvent.EnterExplore, self._onEnterExplore, self)
end

function GuideTriggerEnterExplore:assertGuideSatisfy(param, mapId)
	return param == tonumber(mapId)
end

function GuideTriggerEnterExplore:_onEnterExplore(mapId)
	self:checkStartGuide(mapId)
end

return GuideTriggerEnterExplore
