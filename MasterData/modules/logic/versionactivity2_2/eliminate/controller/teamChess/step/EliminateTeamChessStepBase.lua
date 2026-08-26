-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessStepBase.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepBase", package.seeall)

local EliminateTeamChessStepBase = class("EliminateTeamChessStepBase", BaseWork)

function EliminateTeamChessStepBase:initData(data)
	self._data = data
end

function EliminateTeamChessStepBase:onStart()
	self:onDone(true)
end

function EliminateTeamChessStepBase:_onDone()
	self:onDone(true)
end

function EliminateTeamChessStepBase:clearWork()
	TaskDispatcher.cancelTask(self._onDone, self)
end

return EliminateTeamChessStepBase
