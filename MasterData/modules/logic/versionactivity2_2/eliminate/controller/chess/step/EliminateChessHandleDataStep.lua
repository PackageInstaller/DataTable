-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessHandleDataStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessHandleDataStep", package.seeall)

local EliminateChessHandleDataStep = class("EliminateChessHandleDataStep", EliminateChessStepBase)

function EliminateChessHandleDataStep:onStart()
	local data = EliminateChessController.instance:getCurTurn()

	if data == nil then
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ShowEvaluate)

		EliminateChessController.instance:buildSeqFlow(step)

		local cacheData = EliminateChessModel.instance:getNeedResetData()

		if cacheData ~= nil then
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)

			EliminateChessController.instance:buildSeqFlow(step)
		end

		self:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminate(data.eliminate)
	EliminateChessController.instance:handleDrop(data.tidyUp, data.fillChessBoard)
	self:onDone(true)
end

return EliminateChessHandleDataStep
