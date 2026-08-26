-- chunkname: @modules/logic/survival/controller/work/step/SurvivalAddExBlockWork.lua

module("modules.logic.survival.controller.work.step.SurvivalAddExBlockWork", package.seeall)

local SurvivalAddExBlockWork = class("SurvivalAddExBlockWork", SurvivalStepBaseWork)

function SurvivalAddExBlockWork:onStart2(context)
	local scene = SurvivalMapHelper.instance:getScene()

	if scene then
		for i, mo in ipairs(self._stepMo.extraBlock) do
			scene.block:addExBlock(mo)
		end
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if sceneMo then
		tabletool.addValues(sceneMo.extraBlock, self._stepMo.extraBlock)
	end

	self:onDone(true)
end

return SurvivalAddExBlockWork
