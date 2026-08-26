-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateFinishEvent.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateFinishEvent", package.seeall)

local Va3ChessStateFinishEvent = class("Va3ChessStateFinishEvent", Va3ChessStateBase)

function Va3ChessStateFinishEvent:start()
	logNormal("Va3ChessStateFinishEvent start")

	if ViewMgr.instance:isOpenFinish(Va3ChessGameController.instance:getViewName()) then
		self:sendRequest()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	end
end

function Va3ChessStateFinishEvent:onOpenViewFinish(viewName)
	if viewName == Va3ChessGameController.instance:getViewName() then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
		self:sendRequest()
	end
end

function Va3ChessStateFinishEvent:sendRequest()
	local actId = Va3ChessGameModel.instance:getActId()

	Va3ChessRpcController.instance:sendActEventEndRequest(actId, self.onReceiveReply, self)
end

function Va3ChessStateFinishEvent:onReceiveReply(cmd, resultCode)
	if resultCode == 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, self)
	end
end

function Va3ChessStateFinishEvent:dispose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	Va3ChessStateFinishEvent.super.dispose(self)
end

return Va3ChessStateFinishEvent
