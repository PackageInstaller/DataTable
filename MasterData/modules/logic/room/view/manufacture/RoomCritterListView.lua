-- chunkname: @modules/logic/room/view/manufacture/RoomCritterListView.lua

module("modules.logic.room.view.manufacture.RoomCritterListView", package.seeall)

local RoomCritterListView = class("RoomCritterListView", BaseView)

function RoomCritterListView:onInitView()
	self._gomood = gohelper.findChild(self.viewGO, "#go_critter/sort/#btn_mood")
	self._gorare = gohelper.findChild(self.viewGO, "#go_critter/sort/#btn_rare")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critter/sort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "#go_critter/sort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "#go_critter/sort/#btn_filter/#go_filter")
	self._scrollrect = gohelper.findChildScrollRect(self.viewGO, "#go_critter/#scroll_critter")
	self._btncloseCritter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critter/#btn_closeCritter")
	self._goempty = gohelper.findChild(self.viewGO, "#go_critter/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterListView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btncloseCritter:AddClickListener(self._btncloseCritterOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, self._onChangeSelectedTransportPath, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterListUpdate, self.onCritterListUpdate, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterListResetScrollPos, self.resetScrollPos, self)
end

function RoomCritterListView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btncloseCritter:RemoveClickListener()

	if self.sortMoodItem then
		self.sortMoodItem.btnsort:RemoveClickListener()
	end

	if self.sortRareItem then
		self.sortRareItem.btnsort:RemoveClickListener()
	end

	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, self._onChangeSelectedTransportPath, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterListUpdate, self.onCritterListUpdate, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterListResetScrollPos, self.resetScrollPos, self)
end

function RoomCritterListView:_btnsortOnClick(sortItem)
	local order = ManufactureCritterListModel.instance:getOrder()

	ManufactureCritterListModel.instance:setOrder((order == sortItem.orderDown or nil) and sortItem.orderUp)
	self:refreshSort()
	self:refreshList()
end

function RoomCritterListView:_btnfilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomCritterListView:_btncloseCritterOnClick()
	local pathId = self:getPathId()

	if pathId then
		ManufactureController.instance:clearSelectTransportPath()
	else
		ManufactureController.instance:clearSelectCritterSlotItem()
	end
end

function RoomCritterListView:_onChangeSelectedCritterSlotItem()
	local pathId = self:getPathId()

	if pathId then
		return
	end

	local selectedBuildingUid = ManufactureModel.instance:getSelectedCritterSlot()
	local curBuildingUid = self:getViewBuilding()

	if selectedBuildingUid == curBuildingUid then
		return
	end

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(selectedBuildingUid)

	if buildingMO then
		self.viewContainer:setContainerViewBelongId(selectedBuildingUid)
		CritterController.instance:setManufactureCritterList(buildingMO.buildingId, selectedBuildingUid, false, self.filterMO)
	end
end

function RoomCritterListView:_onChangeSelectedTransportPath()
	local pathId = self:getPathId()

	if not pathId then
		return
	end

	local selectedPathId = ManufactureModel.instance:getSelectedTransportPath()

	if selectedPathId == pathId then
		return
	end

	self.viewContainer:setContainerViewBelongId(nil, selectedPathId)

	local _, _, curBuildingId = self:getViewBuilding()

	CritterController.instance:setManufactureCritterList(curBuildingId, selectedPathId, true, self.filterMO)
end

function RoomCritterListView:onCritterFilterTypeChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self:refreshFilterBtn()
	self:refreshList()
end

function RoomCritterListView:onCritterListUpdate()
	local isEmpty = ManufactureCritterListModel.instance:isCritterListEmpty()

	gohelper.setActive(self._goempty, isEmpty)
end

function RoomCritterListView:resetScrollPos()
	self._scrollrect.verticalNormalizedPosition = 1
end

function RoomCritterListView:_editableInitView()
	self.sortMoodItem = self:getUserDataTb_()
	self.sortRareItem = self:getUserDataTb_()

	self:_initSortItem(self.sortMoodItem, self._gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	self:_initSortItem(self.sortRareItem, self._gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function RoomCritterListView:_initSortItem(sortItem, go, orderUp, orderDown)
	sortItem.btnsort = gohelper.findChildButtonWithAudio(go, "")
	sortItem.go1 = gohelper.findChild(go, "#go_normal")
	sortItem.go2 = gohelper.findChild(go, "#go_selected")
	sortItem.goarrow = gohelper.findChild(go, "#go_selected/txt/arrow")
	sortItem.orderUp = orderUp
	sortItem.orderDown = orderDown

	sortItem.btnsort:AddClickListener(self._btnsortOnClick, self, sortItem)
end

function RoomCritterListView:onUpdateParam()
	return
end

function RoomCritterListView:onOpen()
	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	self:refreshSort()
	self:refreshFilterBtn()
	self:refreshList()
end

function RoomCritterListView:refreshList()
	local pathId = self:getPathId()
	local curBuildingUid, _, curBuildingId = self:getViewBuilding()
	local isTransport = not not pathId

	CritterController.instance:setManufactureCritterList(curBuildingId, pathId or curBuildingUid, isTransport, self.filterMO)
end

function RoomCritterListView:refreshSort()
	self:_refreshSortItemSort(self.sortMoodItem)
	self:_refreshSortItemSort(self.sortRareItem)
end

function RoomCritterListView:_refreshSortItemSort(sortItem)
	local order = ManufactureCritterListModel.instance:getOrder()

	self:_setSort(sortItem, order == sortItem.orderUp or order == sortItem.orderDown, order == sortItem.orderUp)
end

function RoomCritterListView:_setSort(sortItem, select, reverse)
	if select then
		gohelper.setActive(sortItem.go1, false)
		gohelper.setActive(sortItem.go2, true)
		self:_setReverse(sortItem.goarrow.transform, reverse)
	else
		gohelper.setActive(sortItem.go1, true)
		gohelper.setActive(sortItem.go2, false)
	end
end

function RoomCritterListView:_setReverse(transform, reverse)
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(transform)

	if reverse then
		transformhelper.setLocalScale(transform, scaleX, -math.abs(scaleY), scaleZ)
	else
		transformhelper.setLocalScale(transform, scaleX, math.abs(scaleY), scaleZ)
	end
end

function RoomCritterListView:refreshFilterBtn()
	local isFiltering = self.filterMO:isFiltering()

	gohelper.setActive(self._gonotfilter, not isFiltering)
	gohelper.setActive(self._gofilter, isFiltering)
end

function RoomCritterListView:getViewBuilding()
	local viewBuildingUid, viewBuildingMO, viewBuildingId = self.viewContainer:getContainerViewBuilding()

	return viewBuildingUid, viewBuildingMO, viewBuildingId
end

function RoomCritterListView:getPathId()
	return self.viewContainer:getContainerPathId()
end

function RoomCritterListView:onClose()
	ManufactureCritterListModel.instance:clearSort()
end

function RoomCritterListView:onDestroyView()
	return
end

return RoomCritterListView
