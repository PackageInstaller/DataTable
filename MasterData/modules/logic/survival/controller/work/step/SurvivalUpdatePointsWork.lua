-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdatePointsWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdatePointsWork", package.seeall)

local SurvivalUpdatePointsWork = class("SurvivalUpdatePointsWork", SurvivalStepBaseWork)

function SurvivalUpdatePointsWork:onStart2(context)
	SurvivalMapModel.instance:addExploredPoint(self._stepMo.hex)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapExploredPointUpdate)
	self:onDone(true)
end

function SurvivalUpdatePointsWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUpdatePointsWork
