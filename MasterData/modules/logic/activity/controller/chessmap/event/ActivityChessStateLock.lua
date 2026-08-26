-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateLock.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateLock", package.seeall)

local ActivityChessStateLock = class("ActivityChessStateLock", ActivityChessStateBase)

function ActivityChessStateLock:start()
	logNormal("ActivityChessStateLock start")
end

function ActivityChessStateLock:onClickPos(x, y)
	return
end

return ActivityChessStateLock
