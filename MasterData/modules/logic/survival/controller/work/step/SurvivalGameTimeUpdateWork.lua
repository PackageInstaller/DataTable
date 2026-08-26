-- chunkname: @modules/logic/survival/controller/work/step/SurvivalGameTimeUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalGameTimeUpdateWork", package.seeall)

local SurvivalGameTimeUpdateWork = class("SurvivalGameTimeUpdateWork", SurvivalStepBaseWork)

function SurvivalGameTimeUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.gameTime = self._stepMo.paramInt[1] or 0
	sceneMo.currMaxGameTime = self._stepMo.paramInt[2] or 0
	sceneMo.addTime = sceneMo.currMaxGameTime - sceneMo.clockMaxTime

	if not self._stepMo.paramInt[3] then
		local reason = SurvivalEnum.GameTimeUpdateReason.Normal

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapGameTimeUpdate, reason)
		self:onDone(true)
	end
end

function SurvivalGameTimeUpdateWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalGameTimeUpdateWork
