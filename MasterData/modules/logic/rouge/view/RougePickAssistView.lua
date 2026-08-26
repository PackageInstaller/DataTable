-- chunkname: @modules/logic/rouge/view/RougePickAssistView.lua

module("modules.logic.rouge.view.RougePickAssistView", package.seeall)

local RougePickAssistView = class("RougePickAssistView", PickAssistView)

function RougePickAssistView:onOpen()
	self._capacityParams = RougeController.instance.pickAssistViewParams

	self:_initCapacity()
	RougePickAssistView.super.onOpen(self)
end

function RougePickAssistView:_initCapacity()
	local volumeGo = gohelper.findChild(self.viewGO, "bg/volume")

	self._capacityComp = RougeCapacityComp.Add(volumeGo, self._capacityParams.curCapacity, self._capacityParams.totalCapacity, true)

	self._capacityComp:showChangeEffect(true)
end

function RougePickAssistView:refreshBtnDetail()
	RougePickAssistView.super.refreshBtnDetail(self)

	local selectedMO = PickAssistListModel.instance:getSelectedMO()
	local capacity = selectedMO and RougeConfig1.instance:getRoleCapacity(selectedMO.heroMO.config.rare) or 0

	self._capacityComp:updateCurNum(capacity + self._capacityParams.curCapacity)
end

return RougePickAssistView
