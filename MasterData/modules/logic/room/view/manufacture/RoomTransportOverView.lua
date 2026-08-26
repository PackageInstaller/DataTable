-- chunkname: @modules/logic/room/view/manufacture/RoomTransportOverView.lua

module("modules.logic.room.view.manufacture.RoomTransportOverView", package.seeall)

local RoomTransportOverView = class("RoomTransportOverView", BaseView)

function RoomTransportOverView:onInitView()
	self._gotransportContent = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	self._gotransportItem = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	self._btnpopBlock = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_popBlock")
	self._btnoneKeyCritter = gohelper.findChildButtonWithAudio(self.viewGO, "bottomBtns/#btn_oneKeyCritter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportOverView:addEvents()
	self._btnoneKeyCritter:AddClickListener(self._btnoneKeyCritterOnClick, self)
	self._btnpopBlock:AddClickListener(self._btnpopBlockOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomTransportOverView:removeEvents()
	self._btnoneKeyCritter:RemoveClickListener()
	self._btnpopBlock:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomTransportOverView:_btnoneKeyCritterOnClick()
	ManufactureController.instance:oneKeyCritter(true)
end

function RoomTransportOverView:_btnpopBlockOnClick()
	self:_closeCritterListView()
end

function RoomTransportOverView:_onManufactureInfoUpdate()
	for _, transportItem in ipairs(self._transportItemList) do
		transportItem:onManufactureInfoUpdate()
	end
end

function RoomTransportOverView:_onViewChange(viewName)
	if viewName ~= ViewName.RoomCritterListView then
		return
	end

	self:refreshPopBlock()
end

function RoomTransportOverView:_editableInitView()
	self:_setTransportList()
end

function RoomTransportOverView:_setTransportList()
	self._transportItemList = {}

	local dataValid = true
	local maxCount = RoomMapTransportPathModel.instance:getMaxCount()
	local transportPathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	if maxCount < #transportPathMOList then
		dataValid = false

		logError(string.format("RoomTransportOverView:_setTransportList error path count more than maxCount, pathCount:%s, maxCount:%s", #transportPathMOList, maxCount))
	end

	local list = {}
	local buildingTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i = 1, #buildingTypeList do
		local data = {}
		local pathMO = transportPathMOList[i]

		if dataValid then
			local isLinkFinish = pathMO and pathMO:isLinkFinish()

			if isLinkFinish then
				data.mo = pathMO
			end
		end

		list[i] = data
	end

	gohelper.CreateObjList(self, self._onSetTransportItem, list, self._gotransportContent, self._gotransportItem, RoomTransportOverItem)
end

function RoomTransportOverView:_onSetTransportItem(obj, data, index)
	local transportPathMO = data.mo

	obj:setData(transportPathMO)

	self._transportItemList[index] = obj
end

function RoomTransportOverView:_closeCritterListView()
	ManufactureController.instance:clearSelectTransportPath()
end

function RoomTransportOverView:onUpdateParam()
	return
end

function RoomTransportOverView:onOpen()
	self:refreshPopBlock()
	self:everySecondCall()
	TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
end

function RoomTransportOverView:refreshPopBlock()
	local isShowCritterListView = ViewMgr.instance:isOpen(ViewName.RoomCritterListView)

	gohelper.setActive(self._btnpopBlock, isShowCritterListView)
end

function RoomTransportOverView:everySecondCall()
	if self._transportItemList then
		for _, transportItem in ipairs(self._transportItemList) do
			transportItem:everySecondCall()
		end
	end
end

function RoomTransportOverView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	self:_closeCritterListView()
end

function RoomTransportOverView:onDestroyView()
	return
end

return RoomTransportOverView
