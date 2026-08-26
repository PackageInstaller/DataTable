-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/MainCharacterPowerChangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterPowerChangeStep", package.seeall)

local MainCharacterPowerChangeStep = class("MainCharacterPowerChangeStep", EliminateTeamChessStepBase)

function MainCharacterPowerChangeStep:onStart()
	local data = self._data

	if data.diffValue == nil or data.teamType == nil then
		self:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterPower(data.teamType, data.diffValue)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterPowerChange, data.teamType, data.diffValue)
	TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.addResourceTipTime)
end

return MainCharacterPowerChangeStep
