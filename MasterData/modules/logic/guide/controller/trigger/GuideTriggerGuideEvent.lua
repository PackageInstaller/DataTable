-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerGuideEvent.lua

module("modules.logic.guide.controller.trigger.GuideTriggerGuideEvent", package.seeall)

local GuideTriggerGuideEvent = class("GuideTriggerGuideEvent", BaseGuideTrigger)

function GuideTriggerGuideEvent:ctor(triggerKey)
	GuideTriggerGuideEvent.super.ctor(self, triggerKey)
	GuideController.instance:registerCallback(GuideEvent.TriggerActive, self._onTriggerActive, self)
end

function GuideTriggerGuideEvent:assertGuideSatisfy(param, configParam)
	return param == GuideEnum.EventTrigger[configParam]
end

function GuideTriggerGuideEvent:_onTriggerActive(param)
	self:checkStartGuide(param)
end

return GuideTriggerGuideEvent
