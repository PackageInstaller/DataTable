-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/MainCharacterHpChangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterHpChangeStep", package.seeall)

local MainCharacterHpChangeStep = class("MainCharacterHpChangeStep", EliminateTeamChessStepBase)

function MainCharacterHpChangeStep:onStart()
	local data = self._data

	if data.diffValue == nil or data.teamType == nil then
		self:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterHp(data.teamType, data.diffValue)

	if math.abs(data.diffValue) > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterHpChange, data.teamType, data.diffValue)
		TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessHpChangeStepTime)
	else
		self:onDone(true)
	end
end

return MainCharacterHpChangeStep
