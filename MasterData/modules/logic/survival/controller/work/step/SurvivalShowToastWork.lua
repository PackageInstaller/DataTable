-- chunkname: @modules/logic/survival/controller/work/step/SurvivalShowToastWork.lua

module("modules.logic.survival.controller.work.step.SurvivalShowToastWork", package.seeall)

local SurvivalShowToastWork = class("SurvivalShowToastWork", SurvivalStepBaseWork)

function SurvivalShowToastWork:onStart2(context)
	if not self._stepMo.paramInt[1] then
		ToastController.instance:showToast(self._stepMo.paramInt[1])
		self:onDone(true)
	end
end

function SurvivalShowToastWork:getRunOrder(params, flow, index, allStep)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalShowToastWork
