-- chunkname: @modules/logic/store/view/optionalcharge/OptionalChargeView.lua

module("modules.logic.store.view.optionalcharge.OptionalChargeView", package.seeall)

local OptionalChargeView = class("OptionalChargeView", BaseView)

function OptionalChargeView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_TitleEn")
	self._txtSelectNum = gohelper.findChildText(self.viewGO, "Title/image_TitleTips/#txt_SelectNum")
	self._goArea1 = gohelper.findChild(self.viewGO, "Gift1/#go_Area1")
	self._goArea2 = gohelper.findChild(self.viewGO, "Gift2/#go_Area2")
	self._goArea3 = gohelper.findChild(self.viewGO, "Gift3/#go_Area3")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Buy")
	self._txtPrice = gohelper.findChildText(self.viewGO, "#btn_Buy/#txt_Price")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goOptionalItem = gohelper.findChild(self.viewGO, "OptionalItem")
	self._goGift1Special = gohelper.findChild(self.viewGO, "Gift1Special")
	self._goGift1 = gohelper.findChild(self.viewGO, "Gift1")
	self._simageItem1 = gohelper.findChildSingleImage(self.viewGO, "Gift1Special/Item1/simage_Item")
	self._simageItem2 = gohelper.findChildSingleImage(self.viewGO, "Gift1Special/Item2/simage_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OptionalChargeView:addEvents()
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function OptionalChargeView:removeEvents()
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function OptionalChargeView:_btnBuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if tabletool.len(self.selectIndexs) ~= 3 then
		GameFacade.showToast(ToastEnum.OptionalChargeSelectNotEnough)

		return
	end

	PayController.instance:startPay(self._mo.id, self.selectIndexs)
end

function OptionalChargeView:_btnCloseOnClick()
	self:closeThis()
end

function OptionalChargeView:_editableInitView()
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)

	self.selectIndexs = {}

	self:initSelectItem()
end

function OptionalChargeView:onUpdateParam()
	return
end

function OptionalChargeView:onOpen()
	self._mo = self.viewParam
	self.chargeGoodsCfg = self.viewParam.config
	self.optionalGroups = StoreConfig.instance:getChargeOptionalGroup(self._mo.id)

	self:initOptionalItem()

	self._txtTitle.text = self.chargeGoodsCfg.name
	self._txtTitleEn.text = self.chargeGoodsCfg.nameEn

	local costStr = string.format("<color=#e98457>%s</color>", PayModel.instance:getProductPrice(self._mo.id))

	self._txtPrice.text = formatLuaLang("price_cost", costStr)

	gohelper.setActive(self._goGift1, self.optionalGroups[1].rare == 0)
	gohelper.setActive(self._goGift1Special, self.optionalGroups[1].rare == 1)
	self:refreshSelect()
	StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self.chargeGoodsCfg)
end

function OptionalChargeView:onClose()
	return
end

function OptionalChargeView:onDestroyView()
	self._simageItem1:UnLoadImage()
	self._simageItem2:UnLoadImage()

	for _, specialItem in pairs(self.optionalItemList[1]) do
		local longPress = specialItem.longPress

		if longPress then
			longPress:RemoveLongPressListener()
		end
	end
end

function OptionalChargeView:initOptionalItem()
	self.optionalItemList = {}

	if self.optionalGroups[1].rare == 0 then
		gohelper.setActive(self._goGift1, true)
		gohelper.setActive(self._goGift1Special, false)
		self:creatOptionalItem(self._goArea1, self.optionalGroups[1].items, 1)
	else
		gohelper.setActive(self._goGift1, false)
		gohelper.setActive(self._goGift1Special, true)
		self:creatSpecialItem(self.optionalGroups[1].items)
	end

	self:creatOptionalItem(self._goArea2, self.optionalGroups[2].items, 2)
	self:creatOptionalItem(self._goArea3, self.optionalGroups[3].items, 3)
	gohelper.setActive(self._goOptionalItem, false)
end

function OptionalChargeView:initSelectItem()
	self.selectItems = {}

	for i = 1, 3 do
		local selectItem = self:getUserDataTb_()
		local rootPath = "SelectItems/ItemSlot" .. i

		selectItem.itemGo = gohelper.findChild(self.viewGO, rootPath .. "/go_commonitemicon")
		selectItem.itemIcon = IconMgr.instance:getCommonItemIcon(selectItem.itemGo)

		selectItem.itemIcon:isEnableClick(false)
		selectItem.itemIcon:setCountFontSize(37.8)

		selectItem.goAddEffect = gohelper.findChild(self.viewGO, rootPath .. "/add")

		gohelper.setActive(selectItem.itemGo, false)
		gohelper.setActive(selectItem.goAddEffect, false)

		self.selectItems[i] = selectItem
	end
end

function OptionalChargeView:refreshSelect(areaId, isNew)
	local count = tabletool.len(self.selectIndexs)

	self._txtSelectNum.text = string.format("<color=#e98457>%d</color>/%d", count, #self.optionalGroups)

	if areaId then
		local selectIndex = self.selectIndexs[areaId]
		local selectItem = self.selectItems[areaId]

		if isNew then
			gohelper.setActive(selectItem.itemGo, true)
		else
			gohelper.setActive(selectItem.goAddEffect, false)
		end

		gohelper.setActive(selectItem.goAddEffect, true)

		local itemArr = self.optionalItemList[areaId][selectIndex].itemArr

		selectItem.itemIcon:setMOValue(itemArr[1], itemArr[2], itemArr[3])
	end
end

function OptionalChargeView:creatSpecialItem(itemsStr)
	self._simageItem1:LoadImage(ResUrl.getEquipSuit("1000"))
	self._simageItem2:LoadImage(ResUrl.getPropItemIcon("481005"))

	local itemArrs = string.split(itemsStr, "|")

	self.optionalItemList[1] = {}

	for i = 1, 2 do
		local specialItem = self:getUserDataTb_()

		specialItem.itemArr = string.splitToNumber(itemArrs[i], "#")

		local config = ItemConfig.instance:getItemConfig(specialItem.itemArr[1], specialItem.itemArr[2])
		local itemPath = "Gift1Special/Item" .. i
		local go = gohelper.findChild(self.viewGO, itemPath)
		local txtName = gohelper.findChildText(go, "image_Name/txt_Name")

		txtName.text = config.name .. luaLang("multiple") .. specialItem.itemArr[3]
		specialItem.sFrame = gohelper.findChild(go, "go_SelectedFrame")
		specialItem.sYes = gohelper.findChild(go, "go_SelectedYes")

		local click = gohelper.findChildClick(go, "btn_click")

		self.addClickCb(self, click, self._clickSpecialItem, self, i)

		specialItem.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(go, "btn_click")

		specialItem.longPress:SetLongPressTime({
			0.5,
			99999
		})
		specialItem.longPress:AddLongPressListener(self._longPressSpecial, self, i)
		gohelper.setActive(specialItem.sFrame, false)
		gohelper.setActive(specialItem.sYes, false)

		self.optionalItemList[1][i] = specialItem
	end
end

function OptionalChargeView:_clickSpecialItem(index)
	if self.selectIndexs[1] == index then
		return
	end

	local oldIndex = self.selectIndexs[1]

	self.selectIndexs[1] = index

	for k, specialItem in ipairs(self.optionalItemList[1]) do
		gohelper.setActive(specialItem.sFrame, k == index)
		gohelper.setActive(specialItem.sYes, k == index)
	end

	self:refreshSelect(1, oldIndex == nil)
	self:_track(1, oldIndex, index)
end

function OptionalChargeView:_longPressSpecial(index)
	local specialItem = self.optionalItemList[1][index]
	local itemArr = specialItem.itemArr

	MaterialTipController.instance:showMaterialInfo(itemArr[1], itemArr[2], false, nil, nil, nil, nil, nil, nil, self.closeThis, self)
end

function OptionalChargeView:creatOptionalItem(parent, itemsStr, areaId)
	local itemArrs = string.split(itemsStr, "|")

	self.optionalItemList[areaId] = {}

	for i = 1, #itemArrs do
		local go = gohelper.clone(self._goOptionalItem, parent)
		local optionalItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, OptionalChargeItem)

		optionalItem:setValue(itemArrs[i], self.clickOptional, self, areaId, i)

		self.optionalItemList[areaId][i] = optionalItem
	end
end

function OptionalChargeView:clickOptional(areaId, index)
	if self.selectIndexs[areaId] == index then
		return
	end

	local oldIndex = self.selectIndexs[areaId]

	self.selectIndexs[areaId] = index

	for k, optionalItem in ipairs(self.optionalItemList[areaId]) do
		optionalItem:refreshSelect(k == index)
	end

	self:refreshSelect(areaId, oldIndex == nil)
	self:_track(areaId, oldIndex, index)
end

function OptionalChargeView:_payFinished()
	self:closeThis()
end

function OptionalChargeView:_track(areaId, oldIndex, index)
	local oldName = oldIndex and self:_getItemNameByIndex(areaId, oldIndex) or ""
	local newName = self:_getItemNameByIndex(areaId, index)

	StatController.instance:track(StatEnum.EventName.SelectOptionalCharge, {
		[StatEnum.EventProperties.PackName] = self.chargeGoodsCfg.name,
		[StatEnum.EventProperties.StuffGearId] = tostring(areaId),
		[StatEnum.EventProperties.BeforeStuffName] = oldName,
		[StatEnum.EventProperties.AfterStuffName] = newName,
		[StatEnum.EventProperties.SelectedStuffName] = self:_getSelectItemNameList()
	})
end

function OptionalChargeView:_getSelectItemNameList()
	local list = {}

	for i = 1, 3 do
		local selectIndex = self.selectIndexs[i]

		list[#list + 1] = selectIndex and self:_getItemNameByIndex(i, selectIndex) or ""
	end

	return list
end

function OptionalChargeView:_getItemNameByIndex(areaId, index)
	local itemArr = self.optionalItemList[areaId][index].itemArr
	local config = ItemConfig.instance:getItemConfig(itemArr[1], itemArr[2])

	return config.name
end

return OptionalChargeView
