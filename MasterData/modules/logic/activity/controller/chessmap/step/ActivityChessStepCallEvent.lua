-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepCallEvent.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCallEvent", package.seeall)

local ActivityChessStepCallEvent = class("ActivityChessStepCallEvent", ActivityChessStepBase)

function ActivityChessStepCallEvent:start()
	local evtServerData = self.originData.event
	local evtMgr = ActivityChessGameController.instance.event

	if evtMgr then
		evtMgr:setCurEventByObj(evtServerData)

		self._curEvent = evtMgr:getCurEvent()
	end

	if self._curEvent then
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.EventFinishPlay, self.onReceiveFinished, self)
	else
		self:finish()
	end
end

function ActivityChessStepCallEvent:onReceiveFinished(evt)
	if self._curEvent == evt then
		ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, self.onReceiveFinished, self)
		self:finish()
	end
end

function ActivityChessStepCallEvent:finish()
	local evtMgr = ActivityChessGameController.instance.event

	if evtMgr then
		evtMgr:setLockEvent()
	end

	ActivityChessStepCallEvent.super.finish(self)
end

function ActivityChessStepCallEvent:dispose()
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, self.onReceiveFinished, self)

	self._curEvent = nil

	ActivityChessStepCallEvent.super.dispose(self)
end

return ActivityChessStepCallEvent
