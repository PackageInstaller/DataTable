-- chunkname: @modules/logic/survival/controller/work/step/SurvivalPlayExplodeEffectWork.lua

module("modules.logic.survival.controller.work.step.SurvivalPlayExplodeEffectWork", package.seeall)

local SurvivalPlayExplodeEffectWork = class("SurvivalPlayExplodeEffectWork", SurvivalStepBaseWork)

function SurvivalPlayExplodeEffectWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local unitMo = sceneMo.unitsById[self._stepMo.id]

	if unitMo then
		SurvivalMapHelper.instance:addPointEffect(unitMo.pos)

		for _, exPos in ipairs(unitMo.exPoints) do
			SurvivalMapHelper.instance:addPointEffect(exPos)
		end
	end

	self:onDone(true)
end

return SurvivalPlayExplodeEffectWork
