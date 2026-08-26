-- chunkname: @modules/logic/survival/controller/work/step/SurvivalSearchPanelChangeWork.lua

module("modules.logic.survival.controller.work.step.SurvivalSearchPanelChangeWork", package.seeall)

local SurvivalSearchPanelChangeWork = class("SurvivalSearchPanelChangeWork", SurvivalStepBaseWork)

function SurvivalSearchPanelChangeWork:onStart2(context)
	local t = {
		items = self._stepMo.items,
		panelUid = self._stepMo.paramLong[1],
		reason = SurvivalEnum.StepType.SearchPanelChange
	}

	table.insert(SurvivalMapModel.instance.itemConvertInfosList, t)
	self:onDone(true)
end

return SurvivalSearchPanelChangeWork
