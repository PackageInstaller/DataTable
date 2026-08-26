-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessCheckStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessCheckStep", package.seeall)

local EliminateChessCheckStep = class("EliminateChessCheckStep", EliminateChessStepBase)

function EliminateChessCheckStep:onStart()
	local isRound = self._data

	LengZhou6EliminateController.instance:eliminateCheck(isRound)
	self:onDone(true)
end

return EliminateChessCheckStep
