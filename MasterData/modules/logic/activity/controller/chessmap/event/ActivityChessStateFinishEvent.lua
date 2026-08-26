-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateFinishEvent.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateFinishEvent", package.seeall)

local ActivityChessStateFinishEvent = class("ActivityChessStateFinishEvent", ActivityChessStateBase)

function ActivityChessStateFinishEvent:start()
	logNormal("ActivityChessStateFinishEvent start")

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		self:sendRequest()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	end
end

function ActivityChessStateFinishEvent:onOpenViewFinish(viewName)
	if viewName == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
		self:sendRequest()
	end
end

function ActivityChessStateFinishEvent:sendRequest()
	local actId = ActivityChessGameModel.instance:getActId()

	Activity109Rpc.instance:sendAct109EventEndRequest(actId, self.onReceiveReply, self)
end

function ActivityChessStateFinishEvent:onReceiveReply(cmd, resultCode)
	if resultCode == 0 then
		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, self)
	end
end

function ActivityChessStateFinishEvent:dispose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ActivityChessStateFinishEvent.super.dispose(self)
end

return ActivityChessStateFinishEvent
