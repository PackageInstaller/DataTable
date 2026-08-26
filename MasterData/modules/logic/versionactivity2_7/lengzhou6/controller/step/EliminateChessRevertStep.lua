-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessRevertStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessRevertStep", package.seeall)

local EliminateChessRevertStep = class("EliminateChessRevertStep", EliminateChessStepBase)

function EliminateChessRevertStep:onStart()
	LengZhou6EliminateController.instance:revertRecord()
	self:onDone(true)
end

return EliminateChessRevertStep
