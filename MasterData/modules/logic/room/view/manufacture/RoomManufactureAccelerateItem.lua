-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureAccelerateItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureAccelerateItem", package.seeall)

local RoomManufactureAccelerateItem = class("RoomManufactureAccelerateItem", LuaCompBase)
local MIN_CAN_NOT_USE_COUNT = 1

function RoomManufactureAccelerateItem:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureAccelerateItem:_editableInitView()
	self._imgquality = gohelper.findChildImage(self.go, "#image_quality")
	self._goitem = gohelper.findChild(self.go, "#go_item")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._gouse = gohelper.findChild(self.go, "#go_use")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.go, "#go_use/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.go, "#go_use/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.go, "#go_use/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.go, "#go_use/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.go, "#go_use/#btn_max")
	self._simageicon = gohelper.findChildSingleImage(self.go, "#go_use/hasCount/#simage_icon")
	self._txthas = gohelper.findChildText(self.go, "#go_use/hasCount/#txt_has")
	self._btnuse = gohelper.findChildButtonWithAudio(self.go, "#go_use/#btn_use")
end

function RoomManufactureAccelerateItem:addEventListeners()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._inputvalue:AddOnValueChanged(self._onInputValueChange, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomManufactureAccelerateItem:removeEventListeners()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomManufactureAccelerateItem:_btnminOnClick()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
end

function RoomManufactureAccelerateItem:_btnsubOnClick()
	self:changeCount(self._count - 1)
end

function RoomManufactureAccelerateItem:_onInputValueChange(value)
	local count = tonumber(value)

	count = count or MIN_CAN_NOT_USE_COUNT

	self:changeCount(count)
end

function RoomManufactureAccelerateItem:_btnaddOnClick()
	self:changeCount(self._count + 1)
end

function RoomManufactureAccelerateItem:_btnmaxOnClick()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)

	if not buildingMO then
		return
	end

	local maxCount = self:getMaxCount()
	local slotId = buildingMO:getSlotIdInProgress()
	local remainSecond = buildingMO:getSlotRemainSecTime(slotId)

	if remainSecond > 0 then
		local accEff = buildingMO:getAccelerateEff(slotId, self._itemId)

		if accEff ~= 0 then
			maxCount = math.ceil(remainSecond / accEff)
		end
	end

	self:changeCount(maxCount)
end

function RoomManufactureAccelerateItem:_btnuseOnClick()
	local checkResult = self:checkCount()

	if checkResult then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)

		if not buildingMO then
			return
		end

		local slotId = buildingMO:getSlotIdInProgress()
		local remainSecond = buildingMO:getSlotRemainSecTime(slotId)
		local accEff = buildingMO:getAccelerateEff(slotId, self._itemId)
		local isOver = remainSecond < accEff * self._count

		if isOver then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomManufactureAccelerateOver, MsgBoxEnum.BoxType.Yes_No, self._sendUseItem, nil, nil, self)
		else
			self:_sendUseItem()
		end
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function RoomManufactureAccelerateItem:_sendUseItem()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)
	local slotId = buildingMO and buildingMO:getSlotIdInProgress()

	ManufactureController.instance:useAccelerateItem(self._buildingUid, self._itemId, self._count, slotId)
end

function RoomManufactureAccelerateItem:_onItemChange()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
end

function RoomManufactureAccelerateItem:setData(buildingUid, itemConfig)
	self._buildingUid = buildingUid
	self._itemId = itemConfig.id

	self:setItem()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
end

function RoomManufactureAccelerateItem:setItem()
	if not self._itemId then
		return
	end

	if not self._itemIcon then
		self._itemIcon = IconMgr.instance:getCommonItemIcon(self._goitem)

		self._itemIcon:isShowQuality(false)
	end

	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, self._itemId)

	local rare = self._itemIcon:getRare()
	local qualityImg = RoomManufactureEnum.RareImageMap[rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imgquality, qualityImg)

	local _, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, self._itemId, true)

	self._simageicon:LoadImage(icon)

	self._txtname.text = ItemConfig.instance:getItemNameById(self._itemId)
end

function RoomManufactureAccelerateItem:changeCount(count, notify)
	local maxCount = self:getMaxCount()

	if maxCount < MIN_CAN_NOT_USE_COUNT then
		maxCount = MIN_CAN_NOT_USE_COUNT
	end

	count = Mathf.Clamp(count, MIN_CAN_NOT_USE_COUNT, maxCount)
	self._count = count

	if notify then
		self._inputvalue:SetText(count)
	else
		self._inputvalue:SetTextWithoutNotify(tostring(count))
	end

	self:refreshCount()
end

function RoomManufactureAccelerateItem:refreshCount()
	local maxCount = self:getMaxCount()

	self._txthas.text = string.format("%s/%s", self._count, maxCount)

	local isCanUse = self:checkCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnuse.gameObject, not isCanUse)
end

function RoomManufactureAccelerateItem:getMaxCount()
	return (ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, self._itemId))
end

function RoomManufactureAccelerateItem:checkCount()
	local maxCount = self:getMaxCount()

	return (self._count and MIN_CAN_NOT_USE_COUNT <= self._count and maxCount >= self._count or nil) and true
end

function RoomManufactureAccelerateItem:onDestroy()
	self._simageicon:UnLoadImage()
end

return RoomManufactureAccelerateItem
