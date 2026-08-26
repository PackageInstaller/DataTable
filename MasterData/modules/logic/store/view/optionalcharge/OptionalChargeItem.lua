-- chunkname: @modules/logic/store/view/optionalcharge/OptionalChargeItem.lua

module("modules.logic.store.view.optionalcharge.OptionalChargeItem", package.seeall)

local OptionalChargeItem = class("OptionalChargeItem", LuaCompBase)

function OptionalChargeItem:init(go)
	self._imageQuality = gohelper.findChildImage(go, "#img_Quality")
	self._simageItem = gohelper.findChildSingleImage(go, "#simage_Item")
	self._txtNum = gohelper.findChildText(go, "image_NumBG/#txt_Num")
	self._txtItemName = gohelper.findChildText(go, "#txt_ItemName")
	self.goSelected = gohelper.findChild(go, "#go_Selected")
	self.click = gohelper.findChildClick(go, "click")
	self.longPress = SLFramework.UGUI.UILongPressListener.GetWithPath(go, "click")

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self:refreshSelect()
end

function OptionalChargeItem:onStart()
	self.click:AddClickListener(self._onClickItem, self)
	self.longPress:AddLongPressListener(self._onClickInfo, self)
end

function OptionalChargeItem:onDestroy()
	self.click:RemoveClickListener()
	self.longPress:RemoveLongPressListener()

	if self._simageItem then
		self._simageItem:UnLoadImage()
	end
end

function OptionalChargeItem:setValue(itemStr, callback, callbackObj, areaIndex, index)
	self.itemStr = itemStr
	self.itemArr = string.splitToNumber(itemStr, "#")
	self.clickCallback = callback
	self.view = callbackObj
	self.areaIndex = areaIndex
	self.index = index

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self.itemArr[1], self.itemArr[2])

	UISpriteSetMgr.instance:setOptionalGiftSprite(self._imageQuality, "bg_pinjidi_" .. config.rare)
	self._simageItem:LoadImage(icon)

	self._txtNum.text = GameUtil.numberDisplay(self.itemArr[3])
	self._txtItemName.text = config.name
end

function OptionalChargeItem:refreshSelect(isSelected)
	gohelper.setActive(self.goSelected, isSelected)
end

function OptionalChargeItem:_onClickInfo()
	MaterialTipController.instance:showMaterialInfo(self.itemArr[1], self.itemArr[2], false, nil, nil, nil, nil, nil, nil, self.view.closeThis, self.view)
end

function OptionalChargeItem:_onClickItem()
	if self.clickCallback then
		self.clickCallback(self.view, self.areaIndex, self.index)
	end
end

return OptionalChargeItem
