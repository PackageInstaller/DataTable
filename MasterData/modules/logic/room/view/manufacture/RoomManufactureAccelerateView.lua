-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureAccelerateView.lua

module("modules.logic.room.view.manufacture.RoomManufactureAccelerateView", package.seeall)

local RoomManufactureAccelerateView = class("RoomManufactureAccelerateView", BaseView)

function RoomManufactureAccelerateView:onInitView()
	self._clickMask = gohelper.findChildClickWithAudio(self.viewGO, "mask")
	self._imagebuildingIcon = gohelper.findChildImage(self.viewGO, "title/#simage_buildingIcon")
	self._txtbuildingName = gohelper.findChildText(self.viewGO, "title/#txt_buildingName")
	self._imgquality = gohelper.findChildImage(self.viewGO, "progress/#image_quality")
	self._gomanufactureItem = gohelper.findChild(self.viewGO, "progress/#go_manufactureItem")
	self._txtmanufactureItemName = gohelper.findChildText(self.viewGO, "progress/#txt_manufactureItemName")
	self._simagebarIcon = gohelper.findChildSingleImage(self.viewGO, "progress/progressBar/#simage_barIcon")
	self._simagebarValue = gohelper.findChildImage(self.viewGO, "progress/progressBar/#simage_barValue")
	self._gotime = gohelper.findChild(self.viewGO, "progress/progressBar/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "progress/progressBar/#go_time/#txt_time")
	self._gocontent = gohelper.findChild(self.viewGO, "itemArea/#scroll_item/viewport/content")
	self._goaccelerateItem = gohelper.findChild(self.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureAccelerateView:addEvents()
	self._clickMask:AddClickListener(self.onClickModalMask, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
end

function RoomManufactureAccelerateView:removeEvents()
	self._clickMask:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
end

function RoomManufactureAccelerateView:onClickModalMask()
	self:closeThis()
end

function RoomManufactureAccelerateView:_onManufactureInfoUpdate()
	self:refreshProgress()
end

function RoomManufactureAccelerateView:_onManufactureBuildingInfoChange(changeBuildingDict)
	if self._buildingMO then
		if changeBuildingDict and not changeBuildingDict[self._buildingMO] then
			return
		end

		self:refreshProgress()
	end
end

function RoomManufactureAccelerateView:_editableInitView()
	self._accelerateItemList = {}
end

function RoomManufactureAccelerateView:onUpdateParam()
	local buildingUid = self.viewParam.buildingUid

	self._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	self:refreshTitle()
	self:setManufactureItem()
end

function RoomManufactureAccelerateView:setManufactureItem()
	self.curSlotId = self._buildingMO and self._buildingMO:getSlotIdInProgress()

	local manufactureItemId = self._buildingMO:getSlotManufactureItemId(self.curSlotId)
	local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

	if itemId then
		if not self._itemIcon then
			self._itemIcon = IconMgr.instance:getCommonItemIcon(self._gomanufactureItem)

			self._itemIcon:isShowQuality(false)
		end

		local batchIconPath = ManufactureConfig.instance:getBatchIconPath(manufactureItemId)

		self._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, itemId, nil, nil, nil, {
			specificIcon = batchIconPath
		})

		local rare = self._itemIcon:getRare()
		local qualityImg = RoomManufactureEnum.RareImageMap[rare]

		UISpriteSetMgr.instance:setCritterSprite(self._imgquality, qualityImg)

		self._txtmanufactureItemName.text = ManufactureConfig.instance:getManufactureItemName(manufactureItemId)
	end

	self:refreshProgress()
end

function RoomManufactureAccelerateView:onOpen()
	self:onUpdateParam()
	self:setAccelerateItemList()
	self:everySecondCall()
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function RoomManufactureAccelerateView:setAccelerateItemList()
	local accelerateItemList = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.RoomManufactureAccelerateItem)

	gohelper.CreateObjList(self, self._onSetAccelerateItem, accelerateItemList, self._gocontent, self._goaccelerateItem, RoomManufactureAccelerateItem)
end

function RoomManufactureAccelerateView:_onSetAccelerateItem(obj, data, index)
	obj:setData(self._buildingMO.id, data)
end

function RoomManufactureAccelerateView:refreshTitle()
	local name = ""
	local manuBuildingIcon

	if self._buildingMO then
		local buildingConfig = self._buildingMO.config

		name = buildingConfig.useDesc
		manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(self._buildingMO.buildingId)
	end

	self._txtbuildingName.text = name

	UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingIcon, manuBuildingIcon)
end

function RoomManufactureAccelerateView:refreshProgress()
	if not self._buildingMO then
		return
	end

	local manufactureState = self._buildingMO:getManufactureState()
	local isRunning = manufactureState == RoomManufactureEnum.ManufactureState.Running

	if not isRunning then
		self:closeThis()
	end

	local slotId = self._buildingMO:getSlotIdInProgress()

	if not slotId or slotId ~= self.curSlotId then
		self:closeThis()
	end

	local needTimeSec = 0
	local progress = self._buildingMO:getSlotProgress(self.curSlotId)
	local manufactureItemId = self._buildingMO:getSlotManufactureItemId(self.curSlotId)

	if manufactureItemId and manufactureItemId ~= 0 then
		local cfgTime = ManufactureConfig.instance:getNeedTime(manufactureItemId)

		needTimeSec = cfgTime * (1 - progress)
	end

	self._simagebarValue.fillAmount = progress
	self._txttime.text = ManufactureController.instance:getFormatTime(needTimeSec)
end

function RoomManufactureAccelerateView:everySecondCall()
	self:refreshProgress()
end

function RoomManufactureAccelerateView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	MessageBoxController.instance:dispatchEvent(MessageBoxEvent.CloseSpecificMessageBoxView, MessageBoxIdDefine.RoomManufactureAccelerateOver)
end

function RoomManufactureAccelerateView:onDestroyView()
	return
end

return RoomManufactureAccelerateView
