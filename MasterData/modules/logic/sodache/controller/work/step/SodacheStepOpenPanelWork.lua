-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepOpenPanelWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepOpenPanelWork", package.seeall)

local SodacheStepOpenPanelWork = class("SodacheStepOpenPanelWork", SodacheStepBaseWork)

function SodacheStepOpenPanelWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.panelBox.currPanel:init(self._stepMo.panel)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnOpenPanel)
	self:onDone(true)
end

return SodacheStepOpenPanelWork
