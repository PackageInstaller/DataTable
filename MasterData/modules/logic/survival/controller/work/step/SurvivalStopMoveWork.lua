-- chunkname: @modules/logic/survival/controller/work/step/SurvivalStopMoveWork.lua

module("modules.logic.survival.controller.work.step.SurvivalStopMoveWork", package.seeall)

local SurvivalStopMoveWork = class("SurvivalStopMoveWork", SurvivalStepBaseWork)

function SurvivalStopMoveWork:onStart2(context)
	SurvivalMapModel.instance:setMoveToTarget()
	SurvivalMapModel.instance:setShowTarget()
	self:onDone(true)
end

return SurvivalStopMoveWork
