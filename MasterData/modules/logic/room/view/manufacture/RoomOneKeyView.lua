-- chunkname: @modules/logic/room/view/manufacture/RoomOneKeyView.lua

module("modules.logic.room.view.manufacture.RoomOneKeyView", package.seeall)

local RoomOneKeyView = class("RoomOneKeyView", BaseView)

function RoomOneKeyView:onInitView()
	self._btnfill = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_fill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goAddPop = gohelper.findChild(self.viewGO, "right/#go_addPop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomOneKeyView:addEvents()
	self._btnfill:AddClickListener(self._btnfillOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshCustomizeItem, self)
end

function RoomOneKeyView:removeEvents()
	self._btnfill:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshCustomizeItem, self)
end

function RoomOneKeyView:_btnfillOnClick()
	ManufactureController.instance:oneKeyManufactureItem(self.curOneKeyType)
end

function RoomOneKeyView:_btncloseOnClick()
	self:closeThis()
end

function RoomOneKeyView:_btnclickOnClick(oneKeyType)
	if self.curOneKeyType and self.curOneKeyType == oneKeyType then
		return
	end

	local animName
	local newTypeIsCustomize = oneKeyType == RoomManufactureEnum.OneKeyType.Customize

	if self.curOneKeyType and newTypeIsCustomize then
		animName = "left"
	elseif self.curOneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		animName = "back"
	end

	if self._viewAnimator and not string.nilorempty(animName) then
		self._viewAnimator.enabled = true

		self._viewAnimator:Play(animName, 0, 0)
	end

	self:setAddPopActive(newTypeIsCustomize)

	self.curOneKeyType = oneKeyType

	if self.optionItemDict then
		for type, optionItem in pairs(self.optionItemDict) do
			gohelper.setActive(optionItem.goselected, type == oneKeyType)
		end
	end
end

function RoomOneKeyView:onClickModalMask()
	self:closeThis()
end

function RoomOneKeyView:_editableInitView()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:clearOptionItem()

	for _, oneKeyType in pairs(RoomManufactureEnum.OneKeyType) do
		local goType = gohelper.findChild(self.viewGO, "root/#scroll_option/Viewport/Content/#go_type" .. oneKeyType)

		self.optionItemDict[oneKeyType] = self:createOptionItem(goType, oneKeyType)
	end

	local defaultOneKeyType = ManufactureModel.instance:getRecordOneKeyType()

	self:_btnclickOnClick(defaultOneKeyType)
end

function RoomOneKeyView:createOptionItem(optionGO, oneKeyType)
	local result = self:getUserDataTb_()

	result.oneKeyType = oneKeyType
	result.txtdesc = gohelper.findChildText(optionGO, "#txt_desc")
	result.godesc = result.txtdesc.gameObject
	result.goselected = gohelper.findChild(optionGO, "selectdBg/#go_selected")
	result.btnclick = gohelper.findChildClickWithAudio(optionGO, "#btn_click")

	result.btnclick:AddClickListener(self._btnclickOnClick, self, oneKeyType)

	result.gohasItem = gohelper.findChild(optionGO, "#go_hasItem")

	if not gohelper.isNil(result.gohasItem) then
		result.rarebg = gohelper.findChildImage(optionGO, "#go_hasItem/#image_quality")
		result.itemicon = gohelper.findChildSingleImage(optionGO, "#go_hasItem/#image_quality/#simage_productionIcon")
		result.txtitemname = gohelper.findChildText(optionGO, "#go_hasItem/#image_quality/#txt_name")
		result.txtitemnum = gohelper.findChildText(optionGO, "#go_hasItem/#txt_num")
	end

	return result
end

function RoomOneKeyView:onUpdateParam()
	return
end

function RoomOneKeyView:onOpen()
	local isGetOrderInfo = RoomTradeModel.instance:isGetOrderInfo()

	if not isGetOrderInfo then
		RoomRpc.instance:sendGetOrderInfoRequest()
	end

	self:refreshCustomizeItem()
end

function RoomOneKeyView:refreshCustomizeItem()
	local optionItem = self.optionItemDict[RoomManufactureEnum.OneKeyType.Customize]

	if not optionItem or gohelper.isNil(optionItem.gohasItem) then
		return
	end

	local selectedManufactureItem, count = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if selectedManufactureItem then
		local itemId = ManufactureConfig.instance:getItemId(selectedManufactureItem)
		local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)
		local qualityImg = RoomManufactureEnum.RareImageMap[config.rare]

		UISpriteSetMgr.instance:setCritterSprite(optionItem.rarebg, qualityImg)

		local batchIconPath = ManufactureConfig.instance:getBatchIconPath(selectedManufactureItem)

		icon = batchIconPath or icon

		optionItem.itemicon:LoadImage(icon)

		local itemName = ManufactureConfig.instance:getManufactureItemName(selectedManufactureItem)
		local nameArr = string.split(itemName, "*")

		optionItem.txtitemname.text = nameArr[1]
		optionItem.txtitemnum.text = luaLang("multiple") .. count
	end

	gohelper.setActive(optionItem.gohasItem, selectedManufactureItem)
	gohelper.setActive(optionItem.godesc, not selectedManufactureItem)
end

function RoomOneKeyView:setAddPopActive(isShow)
	if self.isShowAddPop == isShow then
		return
	end

	local preIsShow = self.isShowAddPop

	self.isShowAddPop = isShow

	local txtColor = self.isShowAddPop and "#B97B45" or "#ACACAC"
	local optionItem = self.optionItemDict[RoomManufactureEnum.OneKeyType.Customize]

	if optionItem then
		UIColorHelper.set(optionItem.txtdesc, txtColor)
		UIColorHelper.set(optionItem.txtitemname, txtColor)
	end

	gohelper.setActive(self._goAddPop, self.isShowAddPop)

	if preIsShow then
		local selectedItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		if not selectedItem then
			self:_btnclickOnClick(RoomManufactureEnum.OneKeyType.ShortTime)
		end
	end
end

function RoomOneKeyView:clearOptionItem()
	if self.optionItemDict then
		for _, optionItem in pairs(self.optionItemDict) do
			if optionItem.itemicon then
				optionItem.itemicon:UnLoadImage()

				optionItem.itemicon = nil
			end

			if optionItem.btnclick then
				optionItem.btnclick:RemoveClickListener()
			end
		end
	end

	self.optionItemDict = {}
end

function RoomOneKeyView:onClose()
	OneKeyAddPopListModel.instance:resetSelectManufactureItemFromCache()
end

function RoomOneKeyView:onDestroyView()
	self:clearOptionItem()
end

return RoomOneKeyView
