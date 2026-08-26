-- chunkname: @modules/logic/survival/controller/work/step/SurvivalAddTalentWork.lua

module("modules.logic.survival.controller.work.step.SurvivalAddTalentWork", package.seeall)

local SurvivalAddTalentWork = class("SurvivalAddTalentWork", SurvivalStepBaseWork)

function SurvivalAddTalentWork:onStart2(context)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	tabletool.addValues(weekInfo.talents, self._stepMo.paramInt)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentChange)
	self:onDone(true)
end

return SurvivalAddTalentWork
