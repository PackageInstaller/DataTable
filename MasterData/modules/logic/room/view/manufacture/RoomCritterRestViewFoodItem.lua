-- chunkname: @modules/logic/room/view/manufacture/RoomCritterRestViewFoodItem.lua

module("modules.logic.room.view.manufacture.RoomCritterRestViewFoodItem", package.seeall)

local RoomCritterRestViewFoodItem = class("RoomCritterRestViewFoodItem", ListScrollCellExtend)

function RoomCritterRestViewFoodItem:onInitView()
	self._imagequality = gohelper.findChildImage(self.viewGO, "#simage_quality")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_num/#txt_num")
	self._goprefer = gohelper.findChild(self.viewGO, "#go_prefer")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")
	self._goclickEff = gohelper.findChild(self.viewGO, "click_full")

	gohelper.setActive(self._goclickEff, false)
end

function RoomCritterRestViewFoodItem:addEvents()
	self._btnclick:AddClickListener(self.onClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshQuantity, self)
end

function RoomCritterRestViewFoodItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshQuantity, self)
end

function RoomCritterRestViewFoodItem:onClick()
	local buildingUid, critterSeatSlotId = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local critterUid = buildingMO:getRestingCritter(critterSeatSlotId)

	if not critterUid then
		return
	end

	local itemId = self._mo.id
	local hasQuantity = ItemModel.instance:getItemCount(itemId)

	if hasQuantity <= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.IsJumpCritterStoreBuyFood, MsgBoxEnum.BoxType.Yes_No, self._confirmJumpStore, nil, nil, self, nil, nil, self._name)

		return
	end

	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local mood = 0

	if critterMO then
		mood = critterMO:getMoodValue()
	end

	local cfgMaxMood = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local maxMood = tonumber(cfgMaxMood) or 0

	if mood ~= 0 and maxMood <= mood then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomFeedCritterMaxMood, MsgBoxEnum.BoxType.Yes_No, function()
			self:sendFeedRequest(critterUid)
		end)
	else
		self:sendFeedRequest(critterUid)
	end
end

function RoomCritterRestViewFoodItem:_confirmJumpStore()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.CritterStore)
end

function RoomCritterRestViewFoodItem:sendFeedRequest(critterUid)
	local foodData = {
		quantity = 1,
		type = MaterialEnum.MaterialType.Item,
		id = self._mo.id
	}

	RoomRpc.instance:sendFeedCritterRequest(critterUid, foodData, self._afterFeed, self)
end

function RoomCritterRestViewFoodItem:_afterFeed(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isFavorite = false
	local selectedBuildingUid, critterSeatSlotId = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(selectedBuildingUid)
	local critterUid = buildingMO and buildingMO:getRestingCritter(critterSeatSlotId)
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

	if critterMO then
		local critterId = critterMO:getDefineId()

		isFavorite = CritterConfig.instance:isFavoriteFood(critterId, self._mo.id)
	end

	self:playClickEff()

	local dict = {
		[msg.critterUid] = true
	}

	CritterController.instance:dispatchEvent(CritterEvent.CritterFeedFood, dict, isFavorite)
end

function RoomCritterRestViewFoodItem:playClickEff()
	gohelper.setActive(self._goclickEff, false)
	gohelper.setActive(self._goclickEff, true)
end

function RoomCritterRestViewFoodItem:onUpdateMO(mo)
	self._mo = mo

	local itemId = self._mo.id
	local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)

	self._name = config.name

	local qualityImg = RoomManufactureEnum.RareImageMap[config.rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imagequality, qualityImg)
	self._simageicon:LoadImage(icon)
	self:refreshQuantity()
	gohelper.setActive(self._goprefer, self._mo.isFavorite)
	gohelper.setActive(self._goclickEff, false)
end

function RoomCritterRestViewFoodItem:refreshQuantity()
	local itemId = self._mo.id

	self._txtnum.text = ItemModel.instance:getItemCount(itemId)
end

function RoomCritterRestViewFoodItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return RoomCritterRestViewFoodItem
