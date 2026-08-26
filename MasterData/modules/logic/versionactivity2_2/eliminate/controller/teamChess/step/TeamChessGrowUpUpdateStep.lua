-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessGrowUpUpdateStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessGrowUpUpdateStep", package.seeall)

local TeamChessGrowUpUpdateStep = class("TeamChessGrowUpUpdateStep", EliminateTeamChessStepBase)

function TeamChessGrowUpUpdateStep:onStart()
	local data = self._data
	local uid = data.uid
	local skillId = data.skillId
	local upValue = data.upValue

	if uid == nil or skillId == nil or upValue == nil then
		self:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateSkillGrowUp(uid, skillId, upValue)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessGrowUpSkillChange, uid, skillId, upValue)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime)
end

return TeamChessGrowUpUpdateStep
