-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightEvent.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEvent", package.seeall)

local WaitGuideActionFightEvent = class("WaitGuideActionFightEvent", BaseGuideAction)

function WaitGuideActionFightEvent:onStart(context)
	WaitGuideActionFightEvent.super.onStart(self, context)

	self._eventName = FightEvent[self.actionParam]

	if not self._eventName then
		logError("WaitGuideActionFightEvent param error:" .. tostring(self.actionParam))

		return
	end

	FightController.instance:registerCallback(self._eventName, self._onReceiveFightEvent, self)
end

function WaitGuideActionFightEvent:_onReceiveFightEvent()
	FightController.instance:unregisterCallback(self._eventName, self._onReceiveFightEvent, self)
	self:onDone(true)
end

function WaitGuideActionFightEvent:clearWork()
	FightController.instance:unregisterCallback(self._eventName, self._onReceiveFightEvent, self)
end

return WaitGuideActionFightEvent
