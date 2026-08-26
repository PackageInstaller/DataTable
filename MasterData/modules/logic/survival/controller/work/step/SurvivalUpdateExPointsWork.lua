-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateExPointsWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateExPointsWork", package.seeall)

local SurvivalUpdateExPointsWork = class("SurvivalUpdateExPointsWork", SurvivalStepBaseWork)

function SurvivalUpdateExPointsWork:onStart2(context)
	SurvivalMapModel.instance:addExploredPoint2(self._stepMo.hex)
	self:onDone(true)
end

function SurvivalUpdateExPointsWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUpdateExPointsWork
