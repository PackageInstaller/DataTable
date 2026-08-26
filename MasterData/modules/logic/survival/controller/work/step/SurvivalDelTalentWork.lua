-- chunkname: @modules/logic/survival/controller/work/step/SurvivalDelTalentWork.lua

module("modules.logic.survival.controller.work.step.SurvivalDelTalentWork", package.seeall)

local SurvivalDelTalentWork = class("SurvivalDelTalentWork", SurvivalStepBaseWork)

function SurvivalDelTalentWork:onStart2(context)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	for i, v in ipairs(self._stepMo.paramInt) do
		tabletool.removeValue(weekInfo.talents, v)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentChange)
	self:onDone(true)
end

return SurvivalDelTalentWork
