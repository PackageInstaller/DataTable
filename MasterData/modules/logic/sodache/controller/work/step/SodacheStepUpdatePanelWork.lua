-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdatePanelWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdatePanelWork", package.seeall)

local SodacheStepUpdatePanelWork = class("SodacheStepUpdatePanelWork", SodacheStepBaseWork)

function SodacheStepUpdatePanelWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.panelBox.currPanel:init(self._stepMo.panel)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnUpdatePanel)

	for k, v in pairs(SodacheEnum.PanelViewName) do
		if ViewMgr.instance:isOpen(v) and not ViewMgr.instance:isOpenFinish(v) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onViewOpenFinish, self)

			return
		end
	end

	self:onDone(true)
end

function SodacheStepUpdatePanelWork:_onViewOpenFinish(viewName)
	for k, v in pairs(SodacheEnum.PanelViewName) do
		if v == viewName then
			self:onDone(true)

			return
		end
	end
end

function SodacheStepUpdatePanelWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onViewOpenFinish, self)
end

return SodacheStepUpdatePanelWork
