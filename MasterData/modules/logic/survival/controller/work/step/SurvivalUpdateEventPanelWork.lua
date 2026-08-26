-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateEventPanelWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateEventPanelWork", package.seeall)

local SurvivalUpdateEventPanelWork = class("SurvivalUpdateEventPanelWork", SurvivalStepBaseWork)

function SurvivalUpdateEventPanelWork:onStart2(context)
	local panel = self._stepMo.panel
	local type = panel.type

	if type == SurvivalEnum.PanelType.Search and ViewMgr.instance:isOpen(ViewName.SurvivalMapSearchView) and not self.context.fastExecute then
		SurvivalController.instance:registerCallback(SurvivalEvent.SurvivalSearchAnimFinish, self._delayDone, self)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSearchEventUpdate, panel:getSearchItems())
	else
		self:onDone(true)
	end
end

function SurvivalUpdateEventPanelWork:_delayDone()
	self:onDone(true)
end

function SurvivalUpdateEventPanelWork:clearWork()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.SurvivalSearchAnimFinish, self._delayDone, self)
end

function SurvivalUpdateEventPanelWork:getRunOrder(params, flow)
	params.havePanelUpdate = true

	return SurvivalEnum.StepRunOrder.After
end

return SurvivalUpdateEventPanelWork
