-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepClosePanelWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepClosePanelWork", package.seeall)

local SodacheStepClosePanelWork = class("SodacheStepClosePanelWork", SodacheStepBaseWork)

function SodacheStepClosePanelWork:onWorkStart(context)
	context.isEventEnd = true

	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.panelBox.currPanel:clear()

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClosePanel)

	if not self:_checkEventViewClose() then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkEventViewClose, self)
	end
end

function SodacheStepClosePanelWork:_checkEventViewClose()
	for k, v in pairs(SodacheEnum.PanelViewName) do
		if ViewMgr.instance:isOpen(v) then
			return false
		end
	end

	self:onDone(true)

	return true
end

function SodacheStepClosePanelWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkEventViewClose, self)
end

return SodacheStepClosePanelWork
