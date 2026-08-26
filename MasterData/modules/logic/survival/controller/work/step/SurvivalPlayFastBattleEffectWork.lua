-- chunkname: @modules/logic/survival/controller/work/step/SurvivalPlayFastBattleEffectWork.lua

module("modules.logic.survival.controller.work.step.SurvivalPlayFastBattleEffectWork", package.seeall)

local SurvivalPlayFastBattleEffectWork = class("SurvivalPlayFastBattleEffectWork", SurvivalStepBaseWork)

function SurvivalPlayFastBattleEffectWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local unitMo = sceneMo.unitsById[self._stepMo.id]

	if unitMo then
		SurvivalMapHelper.instance:addPointEffect(unitMo.pos, SurvivalPointEffectComp.ResPaths.fastfight)

		for _, exPos in ipairs(unitMo.exPoints) do
			SurvivalMapHelper.instance:addPointEffect(exPos, SurvivalPointEffectComp.ResPaths.fastfight)
		end
	end

	self:onDone(true)
end

return SurvivalPlayFastBattleEffectWork
