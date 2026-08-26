-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionSpecialEvent.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionSpecialEvent", package.seeall)

local WaitGuideActionSpecialEvent = class("WaitGuideActionSpecialEvent", BaseGuideAction)

function WaitGuideActionSpecialEvent:ctor(guideId, stepId, actionParam)
	WaitGuideActionSpecialEvent.super.ctor(self, guideId, stepId, actionParam)

	local paramList = string.split(actionParam, "#")

	self._eventName = #paramList >= 1 and paramList[1]

	if self._eventName then
		self._eventEnum = GuideEnum.SpecialEventEnum[self._eventName] or 0
	end

	self._guideId = guideId
	self._stepId = stepId
end

function WaitGuideActionSpecialEvent:onStart(context)
	WaitGuideActionSpecialEvent.super.onStart(self, context)

	if self._eventEnum == 0 then
		logError("找不到特殊事件: " .. tostring(self._eventName))
		self:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.SpecialEventDone, self._onEventDone, self)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventStart, self._eventEnum, self._guideId, self._stepId)
end

function WaitGuideActionSpecialEvent:_onEventDone(eventEnum)
	if self._eventEnum == eventEnum then
		GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, self._onEventDone, self)
		self:onDone(true)
	end
end

function WaitGuideActionSpecialEvent:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, self._onEventDone, self)
end

return WaitGuideActionSpecialEvent
