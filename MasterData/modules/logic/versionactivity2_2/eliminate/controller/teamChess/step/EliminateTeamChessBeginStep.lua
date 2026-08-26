-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessBeginStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessBeginStep", package.seeall)

local EliminateTeamChessBeginStep = class("EliminateTeamChessBeginStep", EliminateTeamChessStepBase)

function EliminateTeamChessBeginStep:onStart()
	local time = self._data.time

	EliminateChessController.instance:openNoticeView(false, false, true, false, 0, time, nil, nil)
	TaskDispatcher.runDelay(self._onDone, self, time)
end

function EliminateTeamChessBeginStep:_onDone()
	local roundNum = EliminateLevelModel.instance:getRoundNumber()
	local levelId = EliminateLevelModel.instance:getLevelId()

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBegin, string.format("%s_%s", levelId, roundNum))
	EliminateTeamChessBeginStep.super._onDone(self)
end

return EliminateTeamChessBeginStep
