-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/StrongHoldPowerChangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldPowerChangeStep", package.seeall)

local StrongHoldPowerChangeStep = class("StrongHoldPowerChangeStep", EliminateTeamChessStepBase)

function StrongHoldPowerChangeStep:onStart()
	local data = self._data

	if data.teamType == nil or data.diffValue == nil or data.strongholdId == nil then
		self:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateStrongholdsScore(data.strongholdId, data.teamType, data.diffValue)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPowerChange, data.strongholdId, data.teamType, data.diffValue)
	self:onDone(true)
end

return StrongHoldPowerChangeStep
