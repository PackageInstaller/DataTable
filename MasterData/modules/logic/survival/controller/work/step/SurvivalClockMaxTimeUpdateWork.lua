-- chunkname: @modules/logic/survival/controller/work/step/SurvivalClockMaxTimeUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalClockMaxTimeUpdateWork", package.seeall)

local SurvivalClockMaxTimeUpdateWork = class("SurvivalClockMaxTimeUpdateWork", SurvivalStepBaseWork)

function SurvivalClockMaxTimeUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.clockMaxTime = self._stepMo.paramInt[1]
	sceneMo.addTime = sceneMo.currMaxGameTime - sceneMo.clockMaxTime

	local reason = SurvivalEnum.GameTimeUpdateReason.Normal

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapGameTimeUpdate, reason)
	self:onDone(true)
end

return SurvivalClockMaxTimeUpdateWork
