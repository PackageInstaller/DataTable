-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateBase.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateBase", package.seeall)

local ActivityChessStateBase = class("ActivityChessStateBase")

function ActivityChessStateBase:init(stateType, originData)
	self._stateType = stateType
	self.originData = originData
end

function ActivityChessStateBase:start()
	self._stateType = nil
end

function ActivityChessStateBase:onClickPos(x, y, manualClick)
	return
end

function ActivityChessStateBase:getStateType()
	return self._stateType
end

function ActivityChessStateBase:dispose()
	return
end

return ActivityChessStateBase
