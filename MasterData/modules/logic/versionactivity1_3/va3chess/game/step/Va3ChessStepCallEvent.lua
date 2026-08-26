-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepCallEvent.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepCallEvent", package.seeall)

local Va3ChessStepCallEvent = class("Va3ChessStepCallEvent", Va3ChessStepBase)

function Va3ChessStepCallEvent:start()
	local evtServerData = self.originData.event
	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr then
		evtMgr:setCurEventByObj(evtServerData)

		self._curEvent = evtMgr:getCurEvent()
	end

	if self._curEvent then
		Va3ChessGameController.instance:registerCallback(Va3ChessEvent.EventFinishPlay, self.onReceiveFinished, self)
	else
		self:finish()
	end
end

function Va3ChessStepCallEvent:onReceiveFinished(evt)
	if self._curEvent == evt then
		Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.EventFinishPlay, self.onReceiveFinished, self)
		self:finish()
	end
end

function Va3ChessStepCallEvent:finish()
	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr then
		evtMgr:setLockEvent()
	end

	Va3ChessStepCallEvent.super.finish(self)
end

function Va3ChessStepCallEvent:dispose()
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.EventFinishPlay, self.onReceiveFinished, self)

	self._curEvent = nil

	Va3ChessStepCallEvent.super.dispose(self)
end

return Va3ChessStepCallEvent
