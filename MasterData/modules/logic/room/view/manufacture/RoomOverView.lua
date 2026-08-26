-- chunkname: @modules/logic/room/view/manufacture/RoomOverView.lua

module("modules.logic.room.view.manufacture.RoomOverView", package.seeall)

local RoomOverView = class("RoomOverView", BaseView)
local DELAY_CHECK_TIME = 0.05

function RoomOverView:onInitView()
	self._btnmanufacture = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_manufacture")
	self._gomannuselect = gohelper.findChild(self.viewGO, "topTab/#btn_manufacture/select")
	self._gomannuunselect = gohelper.findChild(self.viewGO, "topTab/#btn_manufacture/unselect")
	self._gomannuReddot = gohelper.findChild(self.viewGO, "topTab/#btn_manufacture/#go_reddot")
	self._btntransport = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_transport")
	self._gotransportselect = gohelper.findChild(self.viewGO, "topTab/#btn_transport/select")
	self._gotransportunselect = gohelper.findChild(self.viewGO, "topTab/#btn_transport/unselect")
	self._gotransportReddot = gohelper.findChild(self.viewGO, "topTab/#btn_transport/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomOverView:addEvents()
	self._btnmanufacture:AddClickListener(self._btnmanufactureOnClick, self)
	self._btntransport:AddClickListener(self._btntransportOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomOverView:removeEvents()
	self._btnmanufacture:RemoveClickListener()
	self._btntransport:RemoveClickListener()
end

function RoomOverView:_btnmanufactureOnClick()
	self:_btnTabClick(RoomOverViewContainer.SubViewTabId.Manufacture)
end

function RoomOverView:_btntransportOnClick()
	self:_btnTabClick(RoomOverViewContainer.SubViewTabId.Transport)
end

function RoomOverView:_btnTabClick(tabId)
	local checkResult = self.viewContainer:checkTabId(tabId)

	if not checkResult then
		logError(string.format("RoomOverView._btnTabOnClick error, no subview, tabId:%s", tabId))

		return
	end

	if self._curSelectTab == tabId then
		return
	end

	self.viewContainer:switchTab(tabId)

	self._curSelectTab = tabId

	self:refreshTab()
end

function RoomOverView:_onViewChange(viewName)
	if viewName ~= ViewName.RoomManufactureAddPopView and viewName ~= ViewName.RoomCritterListView and viewName ~= ViewName.RoomManufactureBuildingDetailView then
		return
	end

	if self._willClose then
		return
	end

	TaskDispatcher.cancelTask(self._delayCheckLeft, self)
	TaskDispatcher.runDelay(self._delayCheckLeft, self, DELAY_CHECK_TIME)
end

function RoomOverView:_delayCheckLeft()
	local needLeft = false
	local isShowAddPop = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)
	local isShowCritterListView = ViewMgr.instance:isOpen(ViewName.RoomCritterListView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingDetailView)

	needLeft = (isShowAddPop or isShowCritterListView) and true

	if ((isShowAddPop or isShowCritterListView) and true) ~= self._isLeft then
		self:playAnim(needLeft and "left" or "right")

		self._isLeft = needLeft
	end
end

function RoomOverView:_editableInitView()
	self._tabSelectedGoDict = {}

	local manufacture = self:getUserDataTb_()

	manufacture.goSelected = self._gomannuselect
	manufacture.goUnSelected = self._gomannuunselect
	self._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Manufacture] = manufacture

	local transport = self:getUserDataTb_()

	transport.goSelected = self._gotransportselect
	transport.goUnSelected = self._gotransportunselect
	self._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Transport] = transport
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isLeft = false
end

function RoomOverView:onUpdateParam()
	return
end

function RoomOverView:onOpen()
	self._willClose = false
	self._curSelectTab = self.viewContainer:getDefaultSelectedTab()

	self:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
	RedDotController.instance:addRedDot(self._gomannuReddot, RedDotEnum.DotNode.ManufactureOverview)
end

function RoomOverView:refreshTab()
	for tabId, tab in pairs(self._tabSelectedGoDict) do
		local isSelected = tabId == self._curSelectTab

		gohelper.setActive(tab.goSelected, isSelected)
		gohelper.setActive(tab.goUnSelected, not isSelected)
	end
end

function RoomOverView:playAnim(animName)
	self._animator.enabled = true

	self._animator:Play(animName, 0, 0)
end

function RoomOverView:onClose()
	self._willClose = true

	TaskDispatcher.cancelTask(self._delayCheckLeft, self)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function RoomOverView:onDestroyView()
	self._isLeft = false
end

return RoomOverView
