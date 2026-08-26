-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureOverBuildingItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureOverBuildingItem", package.seeall)

local RoomManufactureOverBuildingItem = class("RoomManufactureOverBuildingItem", LuaCompBase)

function RoomManufactureOverBuildingItem:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureOverBuildingItem:_editableInitView()
	self._gocritterInfo = gohelper.findChild(self.go, "critterInfo")
	self._gocritterItem = gohelper.findChild(self.go, "critterInfo/#go_critterInfoItem")
	self._txtbuilding = gohelper.findChildText(self.go, "manufactureInfo/progress/#txt_building")
	self._imagebuildingicon = gohelper.findChildImage(self.go, "manufactureInfo/progress/#txt_building/#image_buildingicon")
	self._btnaccelerate = gohelper.findChildButtonWithAudio(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_accelerate")
	self._btndetail = gohelper.findChildButtonWithAudio(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail")
	self._goaccelerate = self._btnaccelerate.gameObject
	self._btnwrong = gohelper.findChildClickWithDefaultAudio(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong")
	self._gowrongselect = gohelper.findChild(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_select")
	self._gowrongunselect = gohelper.findChild(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_unselect")
	self._btngoto = gohelper.findChildClickWithAudio(self.go, "manufactureInfo/progress/#btn_goto/clickarea")
	self._goscrollslot = gohelper.findChild(self.go, "manufactureInfo/#scroll_slot")
	self._scrollSlot = self._goscrollslot:GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goslotItemContent = gohelper.findChild(self.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent")
	self._transslotItemContent = self._goslotItemContent.transform
	self._goslotItem = gohelper.findChild(self.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	gohelper.setActive(self._goslotItem, false)

	self._gounselectdetail = gohelper.findChild(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/unselect")
	self._goselectdetail = gohelper.findChild(self.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/select")

	self:clearVar()
	self:_setDetailSelect(false)
end

function RoomManufactureOverBuildingItem:addEventListeners()
	self._btnaccelerate:AddClickListener(self._btnaccelerateOnClick, self)
	self._btnwrong:AddClickListener(self._btnwrongOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, self._onCloseDetatilView, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, self._onWrongViewChange, self)
end

function RoomManufactureOverBuildingItem:removeEventListeners()
	self._btnaccelerate:RemoveClickListener()
	self._btnwrong:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, self._onCloseDetatilView, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, self._onWrongViewChange, self)
end

function RoomManufactureOverBuildingItem:_btnaccelerateOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:openManufactureAccelerateView(curBuildingUid)
	self:closePopView()
end

function RoomManufactureOverBuildingItem:_btnwrongOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:clickWrongBtn(curBuildingUid, true)
end

function RoomManufactureOverBuildingItem:_btngotoOnClick()
	local _, curBuildingMO = self:getViewBuilding()

	ViewMgr.instance:closeView(ViewName.RoomOverView, true)

	local isOpenCritterBuildingView = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)

	if isOpenCritterBuildingView then
		ManufactureController.instance:closeCritterBuildingView(true)
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(curBuildingMO, (self.parentView and self.parentView.viewContainer.viewParam or nil) and self.parentView.viewContainer.viewParam.openFromRest)
end

function RoomManufactureOverBuildingItem:_btndetailOnClick()
	local buildingUid = self:getViewBuilding()
	local isOpen = ManufactureController.instance:openRoomManufactureBuildingDetailView(buildingUid, true)

	self:_setDetailSelect(isOpen)
end

function RoomManufactureOverBuildingItem:_onCloseDetatilView()
	self:_setDetailSelect(false)
end

function RoomManufactureOverBuildingItem:onManufactureInfoUpdate()
	self:refreshSelectedSlot()
	self:refreshSelectedCritterSlot()
	self:_setSlotItems()
	self:_setCritterItem()
	self:refresh()
end

function RoomManufactureOverBuildingItem:onManufactureBuildingInfoChange(changeBuildingDict)
	local curBuildingUid = self:getViewBuilding()

	if changeBuildingDict and not changeBuildingDict[curBuildingUid] then
		return
	end

	self:refreshSelectedSlot()
	self:refreshSelectedCritterSlot()
	self:_setSlotItems()
	self:_setCritterItem()
	self:refresh()
end

function RoomManufactureOverBuildingItem:onTradeLevelChange()
	self:_setCritterItem()
end

function RoomManufactureOverBuildingItem:onChangeSelectedSlotItem()
	for _, slotItem in ipairs(self._slotItemList) do
		slotItem:onChangeSelectedSlotItem()
	end
end

function RoomManufactureOverBuildingItem:_setDetailSelect(iselect)
	gohelper.setActive(self._goselectdetail, iselect)
	gohelper.setActive(self._gounselectdetail, not iselect)
end

function RoomManufactureOverBuildingItem:_onWrongViewChange(buildingUid)
	self:refreshWrongBtnSelect(buildingUid)
end

function RoomManufactureOverBuildingItem:setData(buildingMO, index, parentView)
	self.buildingMO = buildingMO
	self.index = index
	self.parentView = parentView
	self._scrollSlot.parentGameObject = parentView._goscrollbuilding
	self._curViewManufactureState = nil

	self:_setSlotItems()
	self:_setCritterItem()
	self:refresh()
end

function RoomManufactureOverBuildingItem:_setSlotItems()
	local _, curBuildingMO = self:getViewBuilding()

	if not curBuildingMO then
		self:recycleAllSlotItem()

		return
	end

	local buildingId = curBuildingMO.buildingId
	local unlockSlotList = curBuildingMO:getAllUnlockedSlotIdList()
	local totalSlotCount = ManufactureConfig.instance:getBuildingTotalSlotCount(buildingId)

	for i = 1, totalSlotCount do
		local slotItem = self:getSlotItem(i)
		local slotId = unlockSlotList[i]

		slotItem:setData(slotId, i)
	end

	local curSlotCount = #self._slotItemList

	if totalSlotCount < curSlotCount then
		for i = totalSlotCount + 1, curSlotCount do
			local slotItem = self._slotItemList[i]

			self:recycleSlotItem(slotItem)
		end
	end

	self:_setSlotContentSize()
end

function RoomManufactureOverBuildingItem:_setSlotContentSize()
	local slotItemCount = #self._slotItemList
	local itemHeight = recthelper.getWidth(self._goslotItem.transform)
	local totalSize = (itemHeight + RoomManufactureEnum.OverviewSlotItemSpace) * slotItemCount - RoomManufactureEnum.OverviewSlotItemSpace

	recthelper.setWidth(self._transslotItemContent, totalSize)
end

function RoomManufactureOverBuildingItem:_setCritterItem()
	local _, curBuildingMO = self:getViewBuilding()
	local critterCount = 0

	if curBuildingMO then
		critterCount = curBuildingMO:getCanPlaceCritterCount()
	end

	if self._critterItemList then
		local oldCount = #self._critterItemList

		if oldCount and critterCount < oldCount then
			for i = critterCount + 1, oldCount do
				local oldCritterItem = self._critterItemList[i]

				oldCritterItem:reset()
			end
		end

		self._critterItemList = {}

		local critterSlotIdList = {}

		for i = 1, critterCount do
			critterSlotIdList[i] = i - 1
		end

		gohelper.CreateObjList(self, self._onSetCritterItem, critterSlotIdList, self._gocritterInfo, self._gocritterItem, RoomManufactureCritterInfo)
	end
end

function RoomManufactureOverBuildingItem:_onSetCritterItem(obj, data, index)
	self._critterItemList[index] = obj

	obj:setData(data, index, self)
end

function RoomManufactureOverBuildingItem:closePopView()
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function RoomManufactureOverBuildingItem:getSlotItem(index)
	local slotItem = self._slotItemList[index]

	if not slotItem then
		slotItem = self:getSlotItemFromPool()
		self._slotItemList[index] = slotItem
	end

	return slotItem
end

function RoomManufactureOverBuildingItem:getSlotItemFromPool()
	if next(self._slotItemPool) then
		return (table.remove(self._slotItemPool))
	else
		return self:createSlotItem()
	end
end

function RoomManufactureOverBuildingItem:createSlotItem()
	local slotItemGo = gohelper.clone(self._goslotItem, self._goslotItemContent)

	return (RoomManufactureOverSlotItem.New(slotItemGo, self))
end

function RoomManufactureOverBuildingItem:recycleSlotItem(slotItem)
	slotItem:reset(true)
	tabletool.removeValue(self._slotItemList, slotItem)
	table.insert(self._slotItemPool, slotItem)
end

function RoomManufactureOverBuildingItem:recycleAllSlotItem()
	if self._slotItemList then
		for _, slotItem in ipairs(self._slotItemList) do
			slotItem:reset(true)
			table.insert(self._slotItemPool, slotItem)
		end
	end

	self._slotItemList = {}
end

function RoomManufactureOverBuildingItem:refresh()
	self:refreshTitle()
	self:refreshCritter()
	self:checkManufactureState()
	self:refreshSlotItems()
	self:refreshWrongBtnShow()
	self:refreshDetailBtn()
end

function RoomManufactureOverBuildingItem:refreshTitle()
	local name = ""
	local level = 0
	local buildingId
	local _, curBuildingMO = self:getViewBuilding()

	if curBuildingMO then
		name = curBuildingMO.config.useDesc
		level = curBuildingMO.level
		buildingId = curBuildingMO.buildingId
	end

	local maxLevel = ManufactureConfig.instance:getBuildingMaxLevel(buildingId)

	self._txtbuilding.text = string.format("%s <color=#E19653>%s</color>", name, maxLevel <= level and luaLang("lv_max") or formatLuaLang("v1a5_aizila_level", level))

	local manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(curBuildingMO.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingicon, manuBuildingIcon)
end

function RoomManufactureOverBuildingItem:refreshCritter()
	return
end

function RoomManufactureOverBuildingItem:checkManufactureState()
	local newManufactureState = false
	local _, curBuildingMO = self:getViewBuilding()

	if curBuildingMO then
		newManufactureState = curBuildingMO:getManufactureState()
	end

	if self._curViewManufactureState == newManufactureState then
		return
	end

	self._curViewManufactureState = newManufactureState

	local isRunning = self._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running

	gohelper.setActive(self._goaccelerate, isRunning)
end

function RoomManufactureOverBuildingItem:refreshSlotItems()
	for _, slotItem in ipairs(self._slotItemList) do
		slotItem:refresh()
	end
end

function RoomManufactureOverBuildingItem:refreshSelectedSlot()
	local curBuildingUid = self:getViewBuilding()
	local selectedBuildingUid = ManufactureModel.instance:getSelectedSlot()

	if selectedBuildingUid == curBuildingUid then
		ManufactureController.instance:refreshSelectedSlotId(curBuildingUid)
	end
end

function RoomManufactureOverBuildingItem:refreshSelectedCritterSlot()
	local curBuildingUid = self:getViewBuilding()
	local selectedBuildingUid = ManufactureModel.instance:getSelectedCritterSlot()

	if selectedBuildingUid == curBuildingUid then
		ManufactureController.instance:refreshSelectedCritterSlotId(curBuildingUid)
	end
end

function RoomManufactureOverBuildingItem:refreshWrongBtnShow()
	local curBuildingUid = self:getViewBuilding()
	local tipItemList = ManufactureModel.instance:getManufactureWrongTipItemList(curBuildingUid)

	self:refreshWrongBtnSelect()

	local isShow = #tipItemList > 0

	gohelper.setActive(self._btnwrong, isShow)
end

function RoomManufactureOverBuildingItem:refreshWrongBtnSelect(buildingUid)
	local curBuildingUid = self:getViewBuilding()
	local isOpen = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView)
	local isSelected = isOpen and buildingUid == curBuildingUid

	gohelper.setActive(self._gowrongselect, isSelected)
	gohelper.setActive(self._gowrongunselect, not isSelected)
end

function RoomManufactureOverBuildingItem:refreshDetailBtn()
	local _, curBuildingMO = self:getViewBuilding()
	local critterDict = curBuildingMO:getSlot2CritterDict()
	local hasCritter = next(critterDict)

	gohelper.setActive(self._btndetail, hasCritter)
end

function RoomManufactureOverBuildingItem:everySecondCall()
	for _, slotItem in ipairs(self._slotItemList) do
		slotItem:everySecondCall()
	end
end

function RoomManufactureOverBuildingItem:getViewBuilding()
	local viewBuildingUid

	return (self.buildingMO or nil) and self.buildingMO.uid, self.buildingMO
end

function RoomManufactureOverBuildingItem:getSlotItemContentTrans()
	return self._transslotItemContent
end

function RoomManufactureOverBuildingItem:getIndex()
	return self.index
end

function RoomManufactureOverBuildingItem:isShowAddPop()
	return self.parentView:isShowAddPop()
end

function RoomManufactureOverBuildingItem:setViewBuildingUid()
	local curBuildingUid = self:getViewBuilding()

	self.parentView:setViewBuildingUid(curBuildingUid)
end

function RoomManufactureOverBuildingItem:clearVar()
	self.index = nil
	self._curViewManufactureState = nil

	self:clearSlotPool()
	self:clearSlotItemList()
end

function RoomManufactureOverBuildingItem:clearSlotPool()
	if self._slotItemPool then
		for _, slotItem in ipairs(self._slotItemPool) do
			slotItem:destroy()
		end
	end

	self._slotItemPool = {}
end

function RoomManufactureOverBuildingItem:clearSlotItemList()
	if self._slotItemList then
		for _, slotItem in ipairs(self._slotItemList) do
			slotItem:destroy()
		end
	end

	self._slotItemList = {}
end

function RoomManufactureOverBuildingItem:onDestroy()
	self:clearVar()
end

return RoomManufactureOverBuildingItem
