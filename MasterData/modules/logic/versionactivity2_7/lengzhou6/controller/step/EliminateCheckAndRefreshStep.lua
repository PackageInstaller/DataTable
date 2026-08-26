-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateCheckAndRefreshStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateCheckAndRefreshStep", package.seeall)

local EliminateCheckAndRefreshStep = class("EliminateCheckAndRefreshStep", EliminateChessStepBase)

function EliminateCheckAndRefreshStep:onStart()
	local tipInfo = LocalEliminateChessModel.instance:canEliminate()

	if tipInfo == nil or #tipInfo < 3 then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ClearEliminateEffect)
		LocalEliminateChessModel.instance:createInitMoveState()
		LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	end

	self:onDone(true)
end

return EliminateCheckAndRefreshStep
