-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingDetailBanner.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailBanner", package.seeall)

local RoomManufactureBuildingDetailBanner = class("RoomManufactureBuildingDetailBanner", BaseView)

function RoomManufactureBuildingDetailBanner:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_detail")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#go_content/#scroll_base")
	self._gobaseLayer = gohelper.findChild(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	self._txtratio = gohelper.findChildText(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	self._goitemLayer = gohelper.findChild(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer")
	self._txtadd = gohelper.findChildText(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#txt_add")
	self._goitem = gohelper.findChild(self.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureBuildingDetailBanner:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function RoomManufactureBuildingDetailBanner:removeEvents()
	self._btndetail:RemoveClickListener()
end

function RoomManufactureBuildingDetailBanner:_btndetailOnClick()
	local isOpen = ManufactureController.instance:openRoomManufactureBuildingDetailView(self._buildingUid)

	self:_setDetailSelect(isOpen)
end

function RoomManufactureBuildingDetailBanner:_editableInitView()
	self._gounselectdetail = gohelper.findChild(self.viewGO, "#go_content/#btn_detail/unselect")
	self._goselectdetail = gohelper.findChild(self.viewGO, "#go_content/#btn_detail/select")
	self._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	self._attrItemCompList = {}
	self._itemTbList = {}

	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._goitem, false)
	self:_setDetailSelect(false)
end

function RoomManufactureBuildingDetailBanner:onUpdateParam()
	self:_startRefreshTask()
	self:_refreshUI()
end

function RoomManufactureBuildingDetailBanner:onOpen()
	self.addEventCb(self, RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, self._startRefreshTask, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._startRefreshTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._startRefreshTask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, self._onCloseDetatilView, self)
	self:_startRefreshTask()
end

function RoomManufactureBuildingDetailBanner:onClose()
	return
end

function RoomManufactureBuildingDetailBanner:onDestroyView()
	self:_stopRefreshTask()
end

function RoomManufactureBuildingDetailBanner:_startRefreshTask()
	if not self._hasWaitRefreshTask then
		self._hasWaitRefreshTask = true

		TaskDispatcher.runDelay(self._onRunRefreshTask, self, 0.1)
	end
end

function RoomManufactureBuildingDetailBanner:_stopRefreshTask()
	self._hasWaitRefreshTask = false

	TaskDispatcher.cancelTask(self._onRunRefreshTask, self)
end

function RoomManufactureBuildingDetailBanner:_onRunRefreshTask()
	self:_updateParam()
	self:_refreshAttr()
	self:_refreshItem()

	if not self._isSendCritterRequest and self._buildingType then
		self._isSendCritterRequest = true

		CritterController.instance:sendBuildManufacturAttrByBtype(self._buildingType)
	end

	self._hasWaitRefreshTask = false
end

function RoomManufactureBuildingDetailBanner:_onCloseDetatilView()
	self:_setDetailSelect(false)
end

function RoomManufactureBuildingDetailBanner:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self.viewContainer:getContainerViewBuilding()

	return viewBuildingUid, viewBuildingMO
end

function RoomManufactureBuildingDetailBanner:_updateParam()
	self._buildingUid, self._buildingMO = self:getViewBuilding()
	self._buildingType = self.viewParam.buildingType
	self._builidngCfg = self._buildingMO and self._buildingMO.config
	self._buildingType = self._builidngCfg and self._builidngCfg.buildingType
	self._buildingId = self._builidngCfg and self._builidngCfg.buildingId
	self._attrInfoMOList = {}
	self._critterMOList = CritterHelper.getWorkCritterMOListByBuid(self._buildingUid)
	self._critterUidList = {}

	for _, critterMO in ipairs(self._critterMOList) do
		table.insert(self._critterUidList, critterMO.id)
	end

	for _, attrType in ipairs(self._baseAttrTypeList) do
		table.insert(self._attrInfoMOList, CritterHelper.sumArrtInfoMOByAttrId(attrType, self._critterMOList))
	end

	self._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(self._buildingUid)

	gohelper.setActive(self._btndetail, #self._critterUidList > 0)
end

function RoomManufactureBuildingDetailBanner:_refreshUI()
	self:_refreshAttr()
	self:_refreshItem()
end

function RoomManufactureBuildingDetailBanner:_setDetailSelect(iselect)
	gohelper.setActive(self._goselectdetail, iselect)
	gohelper.setActive(self._gounselectdetail, not iselect)
end

function RoomManufactureBuildingDetailBanner:_refreshAttr()
	local attrInfos = self._attrInfoMOList

	for index, attrMO in ipairs(attrInfos) do
		local item = self._attrItemCompList[index]

		if not item then
			local go = gohelper.clone(self._gobaseitem, self._gobaseLayer)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailAttrItem)

			table.insert(self._attrItemCompList, item)
		end

		local value = CritterHelper.sumPreViewAttrValue(attrMO.attributeId, self._critterUidList, self._buildingId, false)
		local valueStr = CritterHelper.formatAttrValue(attrMO.attributeId, value)

		item:onRefreshMo(attrMO, index, valueStr, valueStr, attrMO:getName())
	end

	local count = #attrInfos

	for i = 1, #self._attrItemCompList do
		gohelper.setActive(self._attrItemCompList[i].viewGO, i <= count)
	end
end

function RoomManufactureBuildingDetailBanner:_refreshItem()
	local value = CritterHelper.sumPreViewAttrValue(CritterEnum.AttributeType.Efficiency, self._critterUidList, self._buildingId, false)
	local isUp = value > 100

	for index, itemId in ipairs(self._manufactureItemIdList) do
		local itemTb = self._itemTbList[index]

		if not itemTb then
			itemTb = self:getUserDataTb_()

			table.insert(self._itemTbList, itemTb)

			local go = gohelper.cloneInPlace(self._goitem)

			itemTb.go = go
			itemTb.image_quality = gohelper.findChildImage(go, "image_quality")
			itemTb.go_icon = gohelper.findChild(go, "go_icon")
			itemTb.go_up = gohelper.findChild(go, "go_up")
			itemTb.itemIcon = IconMgr.instance:getCommonItemIcon(itemTb.go_icon)

			itemTb.itemIcon:isShowQuality(false)
		end

		itemTb.itemIcon:setMOValue(MaterialEnum.MaterialType.Item, itemId, nil, nil, nil)

		local rare = itemTb.itemIcon:getRare()
		local qualityImg = RoomManufactureEnum.RareImageMap[rare]

		UISpriteSetMgr.instance:setCritterSprite(itemTb.image_quality, qualityImg)
		gohelper.setActive(itemTb.go_up, isUp)
	end

	local count = #self._manufactureItemIdList

	for i = 1, #self._itemTbList do
		gohelper.setActive(self._itemTbList[i].go, i <= count)
	end

	self._txtadd.text = luaLang(count < 1 and "room_manufacture_detail_no_item" or "room_manufacture_detail_item_title")
end

RoomManufactureBuildingDetailBanner.prefabPath = "ui/viewres/room/manufacture/roommanufacturebuildingdetailbanner.prefab"

return RoomManufactureBuildingDetailBanner
