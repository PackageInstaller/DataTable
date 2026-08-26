-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessShowEvaluateStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEvaluateStep", package.seeall)

local EliminateChessShowEvaluateStep = class("EliminateChessShowEvaluateStep", EliminateChessStepBase)

function EliminateChessShowEvaluateStep:onStart()
	local evaluateLevel = EliminateChessModel.instance:calEvaluateLevel()

	if evaluateLevel == nil then
		self:onDone(true)

		return
	end

	EliminateChessController.instance:openNoticeView(false, false, false, true, evaluateLevel, EliminateEnum.ShowEvaluateTime, self._onPlayEnd, self)
	EliminateChessModel.instance:clearTotalCount()
end

function EliminateChessShowEvaluateStep:_onPlayEnd()
	self:onDone(true)
end

return EliminateChessShowEvaluateStep
