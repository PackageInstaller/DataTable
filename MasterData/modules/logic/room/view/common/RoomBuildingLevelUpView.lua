-- chunkname: @modules/logic/room/view/common/RoomBuildingLevelUpView.lua

module("modules.logic.room.view.common.RoomBuildingLevelUpView", package.seeall)

local RoomBuildingLevelUpView = class("RoomBuildingLevelUpView", BaseView)
local COST_FONT_SIZE = 43

function RoomBuildingLevelUpView:onInitView()
	self._simageproductIcon = gohelper.findChildSingleImage(self.viewGO, "root/info/#simage_productIcon")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn/#txt_nameen")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/info/#txt_namecn/#image_icon")
	self._golevelupInfoItem = gohelper.findChild(self.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	self._txtlevelupInfo = gohelper.findChildText(self.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_levelupInfo")
	self._txtcurNum = gohelper.findChildText(self.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_curNum")
	self._txtnextNum = gohelper.findChildText(self.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_nextNum")
	self._gocost = gohelper.findChild(self.viewGO, "root/costs")
	self._gocostitem = gohelper.findChild(self.viewGO, "root/costs/content/#go_costitem")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_levelup")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot")
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txtNeed = gohelper.findChildText(self.viewGO, "root/#txt_need")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBuildingLevelUpView:addEvents()
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
end

function RoomBuildingLevelUpView:removeEvents()
	self._btnlevelup:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
end

function RoomBuildingLevelUpView:_btnlevelupOnClick()
	if not self._isCanUpgrade then
		if not self._costEnough then
			GameFacade.showToast(ToastEnum.RoomUpgradeFailByNotEnough)
		elseif self._extraCheckFailToast then
			GameFacade.showToast(self._extraCheckFailToast)
		end

		return
	end

	if self._costInfoList then
		local hasCost = #self._costInfoList > 0

		if hasCost then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUpgradeManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, self._confirmLevelUp, nil, nil, self)
		else
			self:_confirmLevelUp()
		end
	end
end

function RoomBuildingLevelUpView:_confirmLevelUp()
	ManufactureController.instance:upgradeManufactureBuilding(self._buildingUid)
end

function RoomBuildingLevelUpView:_btncloseOnClick()
	self:closeThis()
end

function RoomBuildingLevelUpView:_onItemChanged()
	self:refreshCost()
	self:refreshCanUpgrade()
end

function RoomBuildingLevelUpView:_onBuildingLevelUp(levelUpBuildingDict)
	if not levelUpBuildingDict or not levelUpBuildingDict[self._buildingUid] then
		return
	end

	ViewMgr.instance:closeView(ViewName.RoomBuildingLevelUpView, true, false)
	ViewMgr.instance:openView(ViewName.RoomManufactureBuildingLevelUpTipsView, {
		buildingUid = self._buildingUid
	})
end

function RoomBuildingLevelUpView:_onTradeLevelChange()
	self:refreshCanUpgrade()
end

function RoomBuildingLevelUpView:_editableInitView()
	gohelper.setActive(self._golevelupInfoItem, false)
	gohelper.setActive(self._gocostitem, false)

	self._levelUpInfoItemList = {}
	self._costItemList = {}
end

function RoomBuildingLevelUpView:onUpdateParam()
	self._buildingUid = self.viewParam.buildingUid
	self._levelUpInfoList = self.viewParam.levelUpInfoList
	self._costInfoList = self.viewParam.costInfoList or {}
	self._extraCheckFunc = self.viewParam.extraCheckFunc
	self._extraCheckFuncObj = self.viewParam.extraCheckFuncObj

	self:refreshUI()
end

function RoomBuildingLevelUpView:onOpen()
	self:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function RoomBuildingLevelUpView:refreshUI()
	self:refreshTitleInfo()
	self:refreshLevelUpInfo()
	self:refreshCost()
	self:refreshCanUpgrade()
end

function RoomBuildingLevelUpView:refreshTitleInfo()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)

	self._txtnamecn.text = buildingMO.config.name
	self._txtnameen.text = buildingMO.config.nameEn

	local manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(buildingMO.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, manuBuildingIcon)

	local icon = buildingMO:getLevelUpIcon()

	if not string.nilorempty(icon) then
		self._simageproductIcon:LoadImage(ResUrl.getRoomImage("critter/" .. icon))
	else
		icon = buildingMO:getIcon()

		self._simageproductIcon:LoadImage(ResUrl.getRoomImage("building/" .. icon))
	end
end

function RoomBuildingLevelUpView:refreshLevelUpInfo()
	if not self._levelUpInfoList then
		return
	end

	for i, levelUpInfo in ipairs(self._levelUpInfoList) do
		local levelUpInfoItem = self._levelUpInfoItemList[i]

		if not levelUpInfoItem then
			levelUpInfoItem = self:getUserDataTb_()
			levelUpInfoItem.go = gohelper.cloneInPlace(self._golevelupInfoItem, "item" .. i)
			levelUpInfoItem.trans = levelUpInfoItem.go.transform
			levelUpInfoItem.bg = gohelper.findChild(levelUpInfoItem.go, "go_bg")
			levelUpInfoItem.txtdesc = gohelper.findChildText(levelUpInfoItem.go, "#txt_levelupInfo")
			levelUpInfoItem.goDesc = gohelper.findChild(levelUpInfoItem.go, "#go_desc")
			levelUpInfoItem.curNum = gohelper.findChildText(levelUpInfoItem.go, "#go_desc/#txt_curNum")
			levelUpInfoItem.nextNum = gohelper.findChildText(levelUpInfoItem.go, "#go_desc/#txt_nextNum")
			levelUpInfoItem.goNewItemLayout = gohelper.findChild(levelUpInfoItem.go, "#go_newItemLayout")
			levelUpInfoItem.goNewItem = gohelper.findChild(levelUpInfoItem.go, "#go_newItemLayout/#go_newItem")

			table.insert(self._levelUpInfoItemList, levelUpInfoItem)
		end

		levelUpInfoItem.txtdesc.text = levelUpInfo.desc

		local infoItemHeight = recthelper.getHeight(levelUpInfoItem.trans)
		local isShowNewItem = not not levelUpInfo.newItemInfoList

		if isShowNewItem then
			gohelper.CreateObjList(self, self._onSetNewItem, levelUpInfo.newItemInfoList, levelUpInfoItem.goNewItemLayout, levelUpInfoItem.goNewItem)

			infoItemHeight = recthelper.getHeight(levelUpInfoItem.goNewItemLayout.transform)
		else
			levelUpInfoItem.curNum.text = levelUpInfo.currentDesc
			levelUpInfoItem.nextNum.text = levelUpInfo.nextDesc
		end

		recthelper.setHeight(levelUpInfoItem.trans, infoItemHeight)
		gohelper.setActive(levelUpInfoItem.goDesc, not isShowNewItem)
		gohelper.setActive(levelUpInfoItem.goNewItemLayout, isShowNewItem)
		gohelper.setActive(levelUpInfoItem.bg, i % 2 ~= 0)
		gohelper.setActive(levelUpInfoItem.go, true)
	end

	for i = #self._levelUpInfoList + 1, #self._levelUpInfoItemList do
		local levelUpInfoItem = self._levelUpInfoItemList[i]

		gohelper.setActive(levelUpInfoItem.go, false)
	end
end

function RoomBuildingLevelUpView:_onSetNewItem(obj, data, index)
	local newItemType = data.type
	local newItemId = data.id

	if not data.quantity then
		local newItemQuantity = 0
		local itemIcon = IconMgr.instance:getCommonItemIcon(obj)

		itemIcon:setCountFontSize(COST_FONT_SIZE)
		itemIcon:setMOValue(newItemType, newItemId, newItemQuantity)
		itemIcon:isShowCount(newItemQuantity ~= 0)
	end
end

function RoomBuildingLevelUpView:refreshCost()
	self._costEnough = true

	if self._costInfoList then
		local hasCost = #self._costInfoList > 0

		gohelper.setActive(self._gocost, hasCost)

		if not hasCost then
			return
		end

		for i, costInfo in ipairs(self._costInfoList) do
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
			self._costEnough = self._costEnough and enough

			gohelper.setActive(costItem.go, true)
		end

		for i = #self._costInfoList + 1, #self._costItemList do
			local costItem = self._costItemList[i]

			gohelper.setActive(costItem.go, false)
		end
	end
end

function RoomBuildingLevelUpView:refreshCanUpgrade()
	local extraCheckResult = true
	local extraCheckFailToast, needDesc

	if self._extraCheckFunc then
		extraCheckResult, extraCheckFailToast, needDesc = self._extraCheckFunc(self._extraCheckFuncObj, self._buildingUid)
		self._txtNeed.text = needDesc or ""
	end

	gohelper.setActive(self._txtNeed, needDesc)

	self._isCanUpgrade = extraCheckResult and self._costEnough
	self._extraCheckFailToast = extraCheckFailToast

	ZProj.UGUIHelper.SetGrayscale(self._btnlevelup.gameObject, not self._isCanUpgrade)
	gohelper.setActive(self._golevelupbeffect, self._isCanUpgrade)
end

function RoomBuildingLevelUpView:onClose()
	return
end

function RoomBuildingLevelUpView:onDestroyView()
	self._simageproductIcon:UnLoadImage()
end

return RoomBuildingLevelUpView
