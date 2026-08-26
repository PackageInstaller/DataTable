-- chunkname: @modules/logic/survival/controller/work/step/SurvivalCircleShrinkFinishWork.lua

module("modules.logic.survival.controller.work.step.SurvivalCircleShrinkFinishWork", package.seeall)

local SurvivalCircleShrinkFinishWork = class("SurvivalCircleShrinkFinishWork", SurvivalStepBaseWork)

function SurvivalCircleShrinkFinishWork:onStart2(context)
	if not self._stepMo.paramInt[1] then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		for i, v in ipairs(sceneMo.safeZone) do
			if v.round == self._stepMo.paramInt[1] then
				table.remove(sceneMo.safeZone, i)

				break
			end
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShrinkInfoUpdate)
		self:onDone(true)
	end
end

function SurvivalCircleShrinkFinishWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalCircleShrinkFinishWork
