-- chunkname: @modules/logic/survival/controller/work/step/SurvivalSearchItemSublimationWork.lua

module("modules.logic.survival.controller.work.step.SurvivalSearchItemSublimationWork", package.seeall)

local SurvivalSearchItemSublimationWork = class("SurvivalSearchItemSublimationWork", SurvivalStepBaseWork)

function SurvivalSearchItemSublimationWork:onStart2()
	local t = {
		items = self._stepMo.items,
		panelUid = self._stepMo.paramLong[1],
		reason = SurvivalEnum.StepType.SearchItemSublimation
	}

	table.insert(SurvivalMapModel.instance.itemConvertInfosList, t)
	self:onDone(true)
end

return SurvivalSearchItemSublimationWork
