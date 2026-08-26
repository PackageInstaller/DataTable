-- chunkname: @modules/logic/activity/model/chessmap/Activity109ChessGameTaskMO.lua

module("modules.logic.activity.model.chessmap.Activity109ChessGameTaskMO", package.seeall)

local Activity109ChessGameTaskMO = pureTable("Activity109ChessGameTaskMO")

function Activity109ChessGameTaskMO:init(taskMO)
	self.id = taskMO.id
	self.config = taskMO.config
	self.taskMO = taskMO
end

function Activity109ChessGameTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity109ChessGameTaskMO:isLock()
	return self.taskMO == nil
end

function Activity109ChessGameTaskMO:isFinished()
	if self.taskMO then
		return self.taskMO.hasFinished
	end

	return false
end

function Activity109ChessGameTaskMO:alreadyGotReward()
	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

return Activity109ChessGameTaskMO
