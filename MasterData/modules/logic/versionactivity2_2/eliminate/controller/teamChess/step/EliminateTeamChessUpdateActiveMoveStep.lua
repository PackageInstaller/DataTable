-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessUpdateActiveMoveStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessUpdateActiveMoveStep", package.seeall)

local EliminateTeamChessUpdateActiveMoveStep = class("EliminateTeamChessUpdateActiveMoveStep", EliminateTeamChessStepBase)

function EliminateTeamChessUpdateActiveMoveStep:onStart()
	local data = self._data
	local uid = data.uid
	local displacementState = data.displacementState

	if uid == nil or displacementState == nil then
		self:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateDisplacementState(uid, displacementState)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessUpdateActiveMoveState, uid)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
end

return EliminateTeamChessUpdateActiveMoveStep
