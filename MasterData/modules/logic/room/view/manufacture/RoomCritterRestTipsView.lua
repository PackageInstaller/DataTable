-- chunkname: @modules/logic/room/view/manufacture/RoomCritterRestTipsView.lua

module("modules.logic.room.view.manufacture.RoomCritterRestTipsView", package.seeall)

local RoomCritterRestTipsView = class("RoomCritterRestTipsView", BaseView)
local COST_FONT_SIZE = 43

function RoomCritterRestTipsView:onInitView()
	self._simagerestarea = gohelper.findChildSingleImage(self.viewGO, "root/info/#simage_restarea")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn/#txt_nameen")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/info/#txt_namecn/#image_icon")
	self._gocostitem = gohelper.findChild(self.viewGO, "root/costs/content/#go_costitem")
	self._btnbuild = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_build")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterRestTipsView:addEvents()
	self._btnbuild:AddClickListener(self._btnbuildOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUnlockSeatSlot, self.closeThis, self)
end

function RoomCritterRestTipsView:removeEvents()
	self._btnbuild:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterUnlockSeatSlot, self.closeThis, self)
end

function RoomCritterRestTipsView:_btnbuildOnClick()
	if not self._isCanUpgrade then
		GameFacade.showToast(ToastEnum.RoomNotEnoughMatBuySeatSlot)

		return
	end

	CritterController.instance:buySeatSlot(self.buildingUid, self.seatSlotId)
end

function RoomCritterRestTipsView:_btncloseOnClick()
	self:closeThis()
end

function RoomCritterRestTipsView:_onItemChanged()
	self:refreshCost()
end

function RoomCritterRestTipsView:_editableInitView()
	local imgPath = ResUrl.getRoomCritterIcon("room_rest_area_1")

	self._simagerestarea:LoadImage(imgPath)

	self._costItemList = {}
end

function RoomCritterRestTipsView:onUpdateParam()
	self.buildingUid = self.viewParam.buildingUid
	self.seatSlotId = self.viewParam.seatSlotId
end

function RoomCritterRestTipsView:onOpen()
	self:onUpdateParam()
	self:refreshBuildingInfo()
	self:refreshCost()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function RoomCritterRestTipsView:refreshBuildingInfo()
	local name = ""
	local nameEn = ""
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.buildingUid)
	local buildingConfig = buildingMO and buildingMO.config

	if buildingConfig then
		name = buildingConfig.name
		nameEn = buildingConfig.nameEn
	end

	self._txtnamecn.text = name
	self._txtnameen.text = nameEn

	local manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(buildingMO.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, manuBuildingIcon)
end

function RoomCritterRestTipsView:refreshCost()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.buildingUid)
	local costInfoList = ManufactureConfig.instance:getRestBuildingSeatSlotCost(buildingMO and buildingMO.buildingId)
	local isCanUpgrade = true

	for i, costInfo in ipairs(costInfoList) do
		local costType = costInfo.type
		local costId = costInfo.id
		local costNum = costInfo.quantity
		local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)
		local enough = costNum <= hasQuantity
		local costItem = self._costItemList[i]

		if not costItem then
			costItem = self:getUserDataTb_()
			costItem.index = i
			costItem.go = gohelper.cloneInPlace(self._gocostitem, "item" .. i)
			costItem.parent = gohelper.findChild(costItem.go, "go_itempos")
			costItem.itemIcon = IconMgr.instance:getCommonItemIcon(costItem.parent)

			table.insert(self._costItemList, costItem)
		end

		costItem.itemIcon:setMOValue(costType, costId, costNum)
		costItem.itemIcon:setCountFontSize(COST_FONT_SIZE)
		costItem.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)

		local isCurrency = costType == MaterialEnum.MaterialType.Currency
		local countStr = ""

		countStr = enough and (isCurrency and GameUtil.numberDisplay(costNum) or string.format("%s/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costNum))) or isCurrency and string.format("<color=#d97373>%s</color>", GameUtil.numberDisplay(costNum)) or string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costNum))

		local countText = costItem.itemIcon:getCount()

		countText.text = countStr
		isCanUpgrade = isCanUpgrade and enough

		gohelper.setActive(costItem.go, true)
	end

	self._isCanUpgrade = isCanUpgrade

	for i = #costInfoList + 1, #self._costItemList do
		local costItem = self._costItemList[i]

		gohelper.setActive(costItem.go, false)
	end

	ZProj.UGUIHelper.SetGrayscale(self._btnbuild.gameObject, not self._isCanUpgrade)
end

function RoomCritterRestTipsView:onClose()
	return
end

function RoomCritterRestTipsView:onDestroyView()
	return
end

return RoomCritterRestTipsView
