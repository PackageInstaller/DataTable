-- chunkname: @modules/logic/survival/controller/work/step/SurvivalRemoExPointsWork.lua

module("modules.logic.survival.controller.work.step.SurvivalRemoExPointsWork", package.seeall)

local SurvivalRemoExPointsWork = class("SurvivalRemoExPointsWork", SurvivalStepBaseWork)

function SurvivalRemoExPointsWork:onStart2(context)
	SurvivalMapModel.instance:removeExploredPoint2(self._stepMo.hex)
	self:onDone(true)
end

function SurvivalRemoExPointsWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalRemoExPointsWork
