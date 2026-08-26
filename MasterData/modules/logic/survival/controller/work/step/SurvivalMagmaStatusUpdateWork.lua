-- chunkname: @modules/logic/survival/controller/work/step/SurvivalMagmaStatusUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalMagmaStatusUpdateWork", package.seeall)

local SurvivalMagmaStatusUpdateWork = class("SurvivalMagmaStatusUpdateWork", SurvivalStepBaseWork)

function SurvivalMagmaStatusUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.sceneProp.magmaStatus = self._stepMo.paramInt[1] or SurvivalEnum.MagmaStatus.Normal

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMagmaStatusUpdate)
	self:onDone(true)
end

return SurvivalMagmaStatusUpdateWork
