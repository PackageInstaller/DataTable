-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEnterActivity109Chess.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEnterActivity109Chess", package.seeall)

local GuideTriggerEnterActivity109Chess = class("GuideTriggerEnterActivity109Chess", BaseGuideTrigger)

function GuideTriggerEnterActivity109Chess:ctor(triggerKey)
	GuideTriggerEnterActivity109Chess.super.ctor(self, triggerKey)
	Activity109ChessController.instance:registerCallback(ActivityChessEvent.GuideOnEnterMap, self._onEnterMap, self)
end

function GuideTriggerEnterActivity109Chess:assertGuideSatisfy(param, configParam)
	return param == configParam
end

function GuideTriggerEnterActivity109Chess:_onEnterMap(episodeIdStr)
	self:checkStartGuide(episodeIdStr)
end

return GuideTriggerEnterActivity109Chess
