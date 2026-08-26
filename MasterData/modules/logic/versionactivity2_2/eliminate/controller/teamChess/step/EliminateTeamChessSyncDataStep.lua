-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessSyncDataStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessSyncDataStep", package.seeall)

local EliminateTeamChessSyncDataStep = class("EliminateTeamChessSyncDataStep", EliminateTeamChessStepBase)

function EliminateTeamChessSyncDataStep:onStart()
	local conditionIsChange = false
	local curTeamChessWar = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local curServerTeamChessWar = EliminateTeamChessModel.instance:getServerTeamChessWar()

	if curServerTeamChessWar and curTeamChessWar then
		conditionIsChange = curTeamChessWar:updateCondition(curServerTeamChessWar.winCondition, curServerTeamChessWar.extraWinCondition)

		curTeamChessWar:updateForecastBehavior(curServerTeamChessWar.enemyCharacter.forecastBehavior)
	end

	if conditionIsChange then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end

	self:onDone(true)
end

return EliminateTeamChessSyncDataStep
