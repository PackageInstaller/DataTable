-- chunkname: @modules/logic/survival/controller/work/step/SurvivalRemovePointsWork.lua

module("modules.logic.survival.controller.work.step.SurvivalRemovePointsWork", package.seeall)

local SurvivalRemovePointsWork = class("SurvivalRemovePointsWork", SurvivalStepBaseWork)

function SurvivalRemovePointsWork:onStart2(context)
	SurvivalMapModel.instance:removeExploredPoint(self._stepMo.hex)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapExploredPointUpdate)
	self:onDone(true)
end

function SurvivalRemovePointsWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalRemovePointsWork
