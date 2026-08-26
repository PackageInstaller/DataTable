-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerChessGameGuideStart.lua

module("modules.logic.guide.controller.trigger.GuideTriggerChessGameGuideStart", package.seeall)

local GuideTriggerChessGameGuideStart = class("GuideTriggerChessGameGuideStart", BaseGuideTrigger)

function GuideTriggerChessGameGuideStart:ctor(triggerKey)
	GuideTriggerChessGameGuideStart.super.ctor(self, triggerKey)
	ChessGameController.instance:registerCallback(ChessGameEvent.GuideStart, self._onGuideStart, self)
end

function GuideTriggerChessGameGuideStart:assertGuideSatisfy(param, configParam)
	return param == configParam
end

function GuideTriggerChessGameGuideStart:_onGuideStart(guideId)
	self:checkStartGuide(guideId)
end

return GuideTriggerChessGameGuideStart
