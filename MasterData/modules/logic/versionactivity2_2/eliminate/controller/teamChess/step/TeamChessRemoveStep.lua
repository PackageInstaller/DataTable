-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessRemoveStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessRemoveStep", package.seeall)

local TeamChessRemoveStep = class("TeamChessRemoveStep", EliminateTeamChessStepBase)

function TeamChessRemoveStep:onStart()
	local data = self._data

	self.strongholdId = data.strongholdId
	self.uid = data.uid

	local targetStrongholdId = data.targetStrongholdId
	local delayTime = EliminateTeamChessEnum.soliderChessOutAniTime

	delayTime = self:calMoveOtherChessTime(delayTime)

	if targetStrongholdId ~= nil then
		delayTime = delayTime + EliminateTeamChessEnum.chessShowMoveStateAniTime

		local isRight = EliminateTeamChessModel.instance:sourceStrongHoldInRight(self.strongholdId, targetStrongholdId)
		local scale = isRight and -1 or 1
		local entity = TeamChessUnitEntityMgr.instance:getEntity(self.uid)
		local x, y, z = entity:getTopPosXYZ()

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.Move, x, y, z, scale, scale, scale)
		TaskDispatcher.runDelay(self._playRemoveChess, self, EliminateTeamChessEnum.chessShowMoveStateAniTime)
	else
		self:_playRemoveChess()
	end

	TaskDispatcher.runDelay(self._onDone, self, delayTime)
end

function TeamChessRemoveStep:calMoveOtherChessTime(delayTime)
	local strongHoldData = EliminateTeamChessModel.instance:getStronghold(self.strongholdId)
	local chess = strongHoldData:getChess(self.uid)
	local chessIndex = 0
	local totalCount = 0

	if chess.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		chessIndex = strongHoldData:getMySideIndexByUid(self.uid)
		totalCount = strongHoldData:getPlayerSoliderCount()
	end

	if chess.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		chessIndex = strongHoldData:getEnemySideIndexByUid(self.uid)
		totalCount = strongHoldData:getEnemySoliderCount()
	end

	if totalCount > 1 and chessIndex ~= totalCount then
		delayTime = delayTime + EliminateTeamChessEnum.teamChessPlaceStep
	end

	return delayTime
end

function TeamChessRemoveStep:_playRemoveChess()
	TaskDispatcher.cancelTask(self._playRemoveChess, self)

	local strongHoldData = EliminateTeamChessModel.instance:getStronghold(self.strongholdId)
	local chessIndex = strongHoldData:getMySideIndexByUid(self.uid)
	local chess = strongHoldData:getChess(self.uid)

	EliminateTeamChessModel.instance:removeStrongholdChess(self.strongholdId, self.uid)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, self.strongholdId, self.uid, chessIndex, chess.teamType)
end

return TeamChessRemoveStep
