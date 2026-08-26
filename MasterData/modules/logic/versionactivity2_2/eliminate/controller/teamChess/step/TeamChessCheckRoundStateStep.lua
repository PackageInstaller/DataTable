-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessCheckRoundStateStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessCheckRoundStateStep", package.seeall)

local TeamChessCheckRoundStateStep = class("TeamChessCheckRoundStateStep", EliminateTeamChessStepBase)

function TeamChessCheckRoundStateStep:onStart()
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessToMatchStepTime)
end

function TeamChessCheckRoundStateStep:_onDone()
	EliminateLevelController.instance:checkState()
	TeamChessCheckRoundStateStep.super._onDone(self)
end

return TeamChessCheckRoundStateStep
