-- chunkname: @modules/logic/survival/controller/work/step/SurvivalCircleUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalCircleUpdateWork", package.seeall)

local SurvivalCircleUpdateWork = class("SurvivalCircleUpdateWork", SurvivalStepBaseWork)

function SurvivalCircleUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.circle = self._stepMo.paramInt[1] or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCircleUpdate)
	SurvivalMapHelper.instance:getSceneFogComp():setRainDis()
	self:onDone(true)
end

function SurvivalCircleUpdateWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalCircleUpdateWork
