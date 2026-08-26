-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessForecastUpdateStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessForecastUpdateStep", package.seeall)

local TeamChessForecastUpdateStep = class("TeamChessForecastUpdateStep", EliminateTeamChessStepBase)

function TeamChessForecastUpdateStep:onStart()
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessForecastUpdateStep)
end

function TeamChessForecastUpdateStep:_onDone()
	local curTeamChessWar = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local curServerTeamChessWar = EliminateTeamChessModel.instance:getServerTeamChessWar()

	if curServerTeamChessWar and curTeamChessWar then
		curTeamChessWar:updateForecastBehavior(curServerTeamChessWar.enemyCharacter.forecastBehavior)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TeamChessForecastUpdateStep.super._onDone(self)
end

return TeamChessForecastUpdateStep
