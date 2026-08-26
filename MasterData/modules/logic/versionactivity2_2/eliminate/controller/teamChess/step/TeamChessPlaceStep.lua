-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessPlaceStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPlaceStep", package.seeall)

local TeamChessPlaceStep = class("TeamChessPlaceStep", EliminateTeamChessStepBase)

function TeamChessPlaceStep:onStart()
	local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

	if roundStepState == EliminateTeamChessEnum.TeamChessRoundType.enemy then
		EliminateLevelController.instance:registerCallback(EliminateChessEvent.LevelDialogClosed, self._checkRoundStep, self)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyPlaceBefore)
	else
		self:_checkRoundStep()
	end
end

function TeamChessPlaceStep:_checkRoundStep()
	EliminateLevelController.instance:unregisterCallback(EliminateChessEvent.LevelDialogClosed, self._checkRoundStep, self)

	local data = self._data
	local stronghold = EliminateTeamChessModel.instance:getStronghold(data.strongholdId)
	local chessPiece = data.chessPiece
	local teamType = chessPiece.teamType
	local index = stronghold:updatePiece(teamType, chessPiece)
	local piece = stronghold:getChess(chessPiece.uid)

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.AddStrongholdChess, piece, data.strongholdId, index)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessPlaceStep)
end

return TeamChessPlaceStep
