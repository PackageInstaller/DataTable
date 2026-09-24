-- chunkname: @modules/logic/college/view/building/CollegeBuildingView.lua

module("modules.logic.college.view.building.CollegeBuildingView", package.seeall)

local CollegeBuildingView = class("CollegeBuildingView", CollegeBottomInfoView)

CollegeBuildingView.ViewType = {
	Upgrade = 2,
	Info = 1
}
CollegeBuildingView.ViewType2Cls = {
	[CollegeBuildingView.ViewType.Info] = CollegeBuildingStateView,
	[CollegeBuildingView.ViewType.Upgrade] = CollegeBuildingUpgradeView
}

function CollegeBuildingView:onInitView()
	CollegeBuildingView.super.onInitView(self)

	self._costComp = CollegeResCostComp.Get(self._goCostRowComp)
	self._viewType2RootGO = self:getUserDataTb_()
	self._viewType2RootGO[CollegeBuildingView.ViewType.Info] = self._goStateInfo
	self._viewType2RootGO[CollegeBuildingView.ViewType.Upgrade] = self._goStateUpgrade
	self._openViewStack = {}
end

function CollegeBuildingView:onCloseClick()
	local openViewNum = #self._openViewStack

	if openViewNum <= 1 then
		CollegeBuildingView.super.onCloseClick(self)

		return
	end

	table.remove(self._openViewStack, openViewNum)

	local lastViewType = table.remove(self._openViewStack, openViewNum - 1)

	self:switchViewType(lastViewType)
end

function CollegeBuildingView:addEvents()
	CollegeBuildingView.super.addEvents(self)
end

function CollegeBuildingView:removeEvents()
	CollegeBuildingView.super.removeEvents(self)
end

function CollegeBuildingView:onOpen()
	self:initData(self.viewParam and self.viewParam.data)
	self:switchViewType(CollegeBuildingView.ViewType.Info, true)
end

function CollegeBuildingView:initData(buildingMo)
	self._buildingMo = buildingMo
	self._buildingId = buildingMo.id
	self._buildingLv = buildingMo.level
	self._buildingMaxLvCo = CollegeConfig.instance:getBuildingMaxLvConfig(self._buildingId)
end

function CollegeBuildingView:switchViewType(viewType, isFirst)
	if not viewType or self._viewType == viewType then
		return
	end

	self._viewType = viewType

	if isFirst then
		self:_realSwitchView()
	else
		self._anim.enabled = true

		self._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self._realSwitchView, self, 0.16)
		UIBlockHelper.instance:startBlock("CollegeBuildingView_switch", 0.16)
	end
end

function CollegeBuildingView:_realSwitchView()
	self:resetBtns()
	table.insert(self._openViewStack, self._viewType)

	local cls = CollegeBuildingView.ViewType2Cls[self._viewType]
	local viewGO = self._viewType2RootGO[self._viewType]

	gohelper.setActive(viewGO, true)
	self.openExclusiveView(self, 1, self._viewType, cls, viewGO, self.viewGO, self)
end

function CollegeBuildingView:refreshCost(upgradeCost)
	gohelper.setActive(self._goCostRow, upgradeCost ~= nil)

	if not upgradeCost then
		return
	end

	self._costComp:onUpdateMO(upgradeCost)
end

function CollegeBuildingView:onClose()
	TaskDispatcher.cancelTask(self._realSwitchView, self)
	CollegeBuildingView.super.onClose(self)
end

return CollegeBuildingView
