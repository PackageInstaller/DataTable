-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureWrongTipItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureWrongTipItem", package.seeall)

local RoomManufactureWrongTipItem = class("RoomManufactureWrongTipItem", LuaCompBase)

function RoomManufactureWrongTipItem:init(go)
	self.go = go
	self._gowaitbg = gohelper.findChild(self.go, "waitbg")
	self._gopausebg = gohelper.findChild(self.go, "pausebg")
	self._imagequality = gohelper.findChildImage(self.go, "info/item/#image_quality")
	self._simageproductionIcon = gohelper.findChildSingleImage(self.go, "info/item/#simage_productionIcon")
	self._txtproductionName = gohelper.findChildText(self.go, "info/item/#txt_productionName")
	self._golayoutstatus = gohelper.findChild(self.go, "info/layoutStatus")
	self._goStatusItem = gohelper.findChild(self.go, "info/layoutStatus/#simage_status")
	self._godec = gohelper.findChild(self.go, "info/#go_dec")
	self._gowrongs = gohelper.findChild(self.go, "#go_wrongs")
	self._gowrongItem = gohelper.findChild(self.go, "#go_wrongs/#go_wrongItem")

	self:setData()
end

function RoomManufactureWrongTipItem:addEventListeners()
	return
end

function RoomManufactureWrongTipItem:removeEventListeners()
	return
end

function RoomManufactureWrongTipItem:onWrongItemJumpClick(index)
	local wrongItem = self.wrongItemList[index]

	if not wrongItem then
		return
	end

	local param = {
		isOverView = self.isOverView,
		pathToType = self.buildingType
	}

	ManufactureController.instance:clickWrongJump(wrongItem.data.wrongType, wrongItem.data.manufactureItemId, wrongItem.data.buildingType, param)
end

function RoomManufactureWrongTipItem:setData(buildingUid, manufactureItemId, wrongSlotIdList, isOverView)
	self.buildingUid = buildingUid
	self.manufactureItemId = manufactureItemId
	self.wrongSlotIdList = wrongSlotIdList
	self.isOverView = isOverView
	self.buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(manufactureItemId)

	self:refresh()
end

function RoomManufactureWrongTipItem:refresh()
	if not self.buildingUid or not self.manufactureItemId or not self.wrongSlotIdList then
		return
	end

	self:setItemInfo()

	local wrongItemList, wrongTypeList = ManufactureModel.instance:getAllWrongManufactureItemList(self.buildingUid, self.manufactureItemId, #self.wrongSlotIdList)

	self:setStatusItems(wrongTypeList)
	self:setWrongItems(wrongItemList)
end

function RoomManufactureWrongTipItem:setItemInfo()
	local itemId = ManufactureConfig.instance:getItemId(self.manufactureItemId)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)
	local qualityImg = RoomManufactureEnum.RareImageMap[config.rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imagequality, qualityImg)

	local batchIconPath = ManufactureConfig.instance:getBatchIconPath(self.manufactureItemId)

	icon = batchIconPath or icon

	self._simageproductionIcon:LoadImage(icon)

	self._txtproductionName.text = ManufactureConfig.instance:getManufactureItemName(self.manufactureItemId)
end

function RoomManufactureWrongTipItem:setStatusItems(wrongTypeList)
	self.statusItemList = {}

	local hasError = false

	for _, wrongType in ipairs(wrongTypeList) do
		hasError = wrongType ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		if hasError then
			break
		end
	end

	gohelper.setActive(self._gowaitbg, not hasError)
	gohelper.setActive(self._gopausebg, hasError)
	gohelper.CreateObjList(self, self._onSetStatusItem, wrongTypeList, self._golayoutstatus, self._goStatusItem)
end

function RoomManufactureWrongTipItem:_onSetStatusItem(obj, data, index)
	local statusItem = self:getUserDataTb_()

	statusItem.go = obj
	statusItem.wrongType = data
	statusItem.simagestatus = obj:GetComponent(gohelper.Type_Image)
	statusItem.txtstatus = gohelper.findChildText(obj, "#txt_status")

	local wrongIcon
	local wrongTxt = ""
	local displaySetting = RoomManufactureEnum.ManufactureWrongDisplay[data]

	if displaySetting then
		wrongIcon = displaySetting.icon
		wrongTxt = luaLang(displaySetting.desc)
	end

	if not string.nilorempty(wrongIcon) then
		UISpriteSetMgr.instance:setRoomSprite(statusItem.simagestatus, wrongIcon)
	end

	statusItem.txtstatus.text = wrongTxt
	self.statusItemList[index] = statusItem
end

function RoomManufactureWrongTipItem:setWrongItems(wrongItemList)
	self:clearWrongItemList()
	gohelper.setActive(self._godec, wrongItemList and #wrongItemList > 0)
	gohelper.CreateObjList(self, self._onSetWrongItem, wrongItemList, self._gowrongs, self._gowrongItem)
end

function RoomManufactureWrongTipItem:clearWrongItemList()
	if self.wrongItemList then
		for _, wrongItem in ipairs(self.wrongItemList) do
			wrongItem.needitemIcon:UnLoadImage()
			wrongItem.btnjump:RemoveClickListener()
		end
	end

	self.wrongItemList = {}
end

function RoomManufactureWrongTipItem:_onSetWrongItem(obj, data, index)
	local wrongItem = self:getUserDataTb_()

	wrongItem.go = obj
	wrongItem.data = data
	wrongItem.goneedItem = gohelper.findChild(obj, "#go_needItem")
	wrongItem.needitemquality = gohelper.findChildImage(obj, "#go_needItem/item/#image_quality")
	wrongItem.needitemIcon = gohelper.findChildSingleImage(obj, "#go_needItem/item/#simage_productionIcon")
	wrongItem.needitemName = gohelper.findChildText(obj, "#go_needItem/#txt_tipItemName")
	wrongItem.txtneed = gohelper.findChildText(obj, "#go_needItem/#txt_need")
	wrongItem.goneedLink = gohelper.findChild(obj, "#go_needLink")
	wrongItem.simagestart = gohelper.findChildImage(obj, "#go_needLink/#simage_start")
	wrongItem.simageend = gohelper.findChildImage(obj, "#go_needLink/#simage_end")
	wrongItem.btnjump = gohelper.findChildClickWithDefaultAudio(obj, "#btn_jump")
	wrongItem.txtjump = gohelper.findChildText(obj, "#btn_jump/#txt_jump")

	wrongItem.btnjump:AddClickListener(self.onWrongItemJumpClick, self, index)

	local wrongType = wrongItem.data.wrongType
	local isLinkPath = wrongType == RoomManufactureEnum.ManufactureWrongType.NoLinkPath

	gohelper.setActive(wrongItem.goneedItem, not isLinkPath)
	gohelper.setActive(wrongItem.goneedLink, isLinkPath)

	if isLinkPath then
		local startIcon = RoomConfig.instance:getBuildingTypeIcon(wrongItem.data.buildingType)
		local endIcon = RoomConfig.instance:getBuildingTypeIcon(self.buildingType)

		UISpriteSetMgr.instance:setRoomSprite(wrongItem.simagestart, startIcon)
		UISpriteSetMgr.instance:setRoomSprite(wrongItem.simageend, endIcon)
	else
		local manufactureItemId = wrongItem.data.manufactureItemId
		local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)
		local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)
		local qualityImg = RoomManufactureEnum.RareImageMap[config.rare]

		UISpriteSetMgr.instance:setCritterSprite(wrongItem.needitemquality, qualityImg)

		local batchIconPath = ManufactureConfig.instance:getBatchIconPath(manufactureItemId)

		icon = batchIconPath or icon

		wrongItem.needitemIcon:LoadImage(icon)

		wrongItem.needitemName.text = ManufactureConfig.instance:getManufactureItemName(manufactureItemId)

		local curQuantity = ManufactureModel.instance:getManufactureItemCount(manufactureItemId)
		local curQuantityWitchColor = string.format("<color=#D26D69>%s</color>", curQuantity)

		wrongItem.txtneed.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_wrong_need_count"), curQuantityWitchColor, wrongItem.data.needQuantity)
	end

	local displaySetting = RoomManufactureEnum.ManufactureWrongDisplay[wrongType]

	wrongItem.txtjump.text = luaLang(displaySetting.jumpDesc)
	self.wrongItemList[index] = wrongItem
end

function RoomManufactureWrongTipItem:onDestroy()
	self._simageproductionIcon:UnLoadImage()
	self:clearWrongItemList()
end

return RoomManufactureWrongTipItem
