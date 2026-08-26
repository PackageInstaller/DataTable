-- chunkname: @modules/logic/gift/view/GiftMultipleChoiceListItem.lua

module("modules.logic.gift.view.GiftMultipleChoiceListItem", package.seeall)

local GiftMultipleChoiceListItem = class("GiftMultipleChoiceListItem", ListScrollCell)

function GiftMultipleChoiceListItem:init(go)
	self._itemPos = gohelper.findChild(go, "itemPos")
	self._name = gohelper.findChildText(go, "name")
	self._choose = gohelper.findChild(go, "mask")
	self._clickGO = gohelper.findChild(go, "click")
	self._goneed = gohelper.findChild(go, "#go_needtag")
	self._clickitem = gohelper.getClick(self._clickGO)
	self._longclickItem = SLFramework.UGUI.UILongPressListener.Get(self._clickGO)

	self._longclickItem:SetLongPressTime({
		0.5,
		99999
	})
end

function GiftMultipleChoiceListItem:addEventListeners()
	self._clickitem:AddClickListener(self._onClickItem, self)
	self._longclickItem:AddLongPressListener(self._onLongClickItem, self)
	GiftController.instance:registerCallback(GiftEvent.MultipleChoice, self._refreshItem, self)
end

function GiftMultipleChoiceListItem:removeEventListeners()
	self._clickitem:RemoveClickListener()
	self._longclickItem:RemoveLongPressListener()
	GiftController.instance:unregisterCallback(GiftEvent.MultipleChoice, self._refreshItem, self)
end

function GiftMultipleChoiceListItem:_refreshItem()
	gohelper.setActive(self._choose, self._mo.index == GiftModel.instance:getMultipleChoiceIndex())
end

function GiftMultipleChoiceListItem:_onClickItem()
	gohelper.setActive(self._choose, true)
	GiftModel.instance:setMultipleChoiceIndex(self._mo.index)
	GiftModel.instance:setMultipleChoiceId(self._mo.materilId)
	GiftController.instance:dispatchEvent(GiftEvent.MultipleChoice)
end

function GiftMultipleChoiceListItem:_onLongClickItem()
	MaterialTipController.instance:showMaterialInfo(self._mo.materilType, self._mo.materilId)
end

function GiftMultipleChoiceListItem:onUpdateMO(mo)
	self._mo = mo

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._mo.materilType, self._mo.materilId)

	if self._mo.materilType == MaterialEnum.MaterialType.Equip then
		self._itemIcon = IconMgr.instance:getCommonEquipIcon(self._itemPos)

		self._itemIcon:setMOValue(self._mo.materilType, self._mo.materilId, self._mo.quantity, nil, true)
		self._itemIcon:hideLv(true)
	else
		self._itemIcon = IconMgr.instance:getCommonItemIcon(self._itemPos)

		self._itemIcon:setMOValue(self._mo.materilType, self._mo.materilId, self._mo.quantity, nil, true)
	end

	self._name.text = config.name

	gohelper.setActive(self._goneed, GiftModel.instance:isGiftNeed(self._mo.materilId))
	self:_refreshItem()
end

function GiftMultipleChoiceListItem:onDestroy()
	return
end

return GiftMultipleChoiceListItem
