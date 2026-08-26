-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/StrongHoldSettleStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldSettleStep", package.seeall)

local StrongHoldSettleStep = class("StrongHoldSettleStep", EliminateTeamChessStepBase)

function StrongHoldSettleStep:onStart()
	local data = self._data
	local strongHoldId = data.strongholdId
	local state = data.state

	TeamChessUnitEntityMgr.instance:cacheEntityShowMode(strongHoldId)
	EliminateTeamChessModel.instance:strongHoldSettle(strongHoldId, state)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldSettle, strongHoldId, state)

	local winSide = ""

	if EliminateTeamChessEnum.StrongHoldState.enemySide == state then
		winSide = tostring(EliminateTeamChessEnum.TeamChessTeamType.enemy)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SettleAndToHaveDamage, (EliminateTeamChessEnum.StrongHoldState.mySide == state or nil) and tostring(EliminateTeamChessEnum.TeamChessTeamType.player))

	local strongHold = EliminateTeamChessModel.instance:getStronghold(strongHoldId)
	local playerSoliderCount = strongHold:getPlayerSoliderCount()
	local enemySoliderCount = strongHold:getEnemySoliderCount()
	local delayTime = 0

	if playerSoliderCount > 0 or enemySoliderCount > 0 then
		delayTime = delayTime + EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime
		delayTime = delayTime + EliminateTeamChessEnum.StrongHoldBattleVxTime
	end

	if strongHold.enemyScore ~= strongHold.myScore then
		delayTime = delayTime + math.max(EliminateTeamChessEnum.teamChessWinOpenTime, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end

	if delayTime > 0 then
		TaskDispatcher.runDelay(self._onDone, self, delayTime)
	else
		self:onDone(true)
	end
end

return StrongHoldSettleStep
