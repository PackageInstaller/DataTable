-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessUpdateGameInfoStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateGameInfoStep", package.seeall)

local EliminateChessUpdateGameInfoStep = class("EliminateChessUpdateGameInfoStep", EliminateChessStepBase)

function EliminateChessUpdateGameInfoStep:onStart()
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateGameInfo)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
	LocalEliminateChessModel.instance:updateSpEffectCd()
	LengZhou6GameModel.instance:clearTempData()
	LocalEliminateChessModel.instance:roundDataClear()

	if LengZhou6GameModel.instance:gameIsOver() then
		LengZhou6GameController.instance:gameEnd()
	else
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

		LengZhou6EliminateController.instance:buildSeqFlow(step)
	end

	self:_onDone()
end

return EliminateChessUpdateGameInfoStep
