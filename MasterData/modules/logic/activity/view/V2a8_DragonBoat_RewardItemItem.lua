-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_RewardItemItem.lua

module("modules.logic.activity.view.V2a8_DragonBoat_RewardItemItem", package.seeall)

local V2a8_DragonBoat_RewardItemItem = class("V2a8_DragonBoat_RewardItemItem", RougeSimpleItemBase)

function V2a8_DragonBoat_RewardItemItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_DragonBoat_RewardItemItem:addEvents()
	return
end

function V2a8_DragonBoat_RewardItemItem:removeEvents()
	return
end

function V2a8_DragonBoat_RewardItemItem:ctor(ctorParam)
	V2a8_DragonBoat_RewardItemItem.super.ctor(self, ctorParam)
end

function V2a8_DragonBoat_RewardItemItem:_editableInitView()
	self._item = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(self.viewGO, "go_icon"))
	self._hasgetGo = gohelper.findChild(self.viewGO, "hasget")
	self._cangetGo = gohelper.findChild(self.viewGO, "canget")

	self:setActive_cangetGo(false)
	self:setActive_hasgetGo(false)
end

function V2a8_DragonBoat_RewardItemItem:setData(mo)
	V2a8_DragonBoat_RewardItemItem.super.setData(self, mo)

	local itemCo = mo

	self._item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	self._item:setScale(0.5)
	self._item:setCountFontSize(46)
	self._item:setCountTxtSize(35)
	self._item:SetCountBgHeight(22.72)
	self._item:setHideLvAndBreakFlag(true)
	self._item:hideEquipLvAndBreak(true)
	self._item:customOnClickCallback(self._customOnClickCallback, self)
end

function V2a8_DragonBoat_RewardItemItem:_customOnClickCallback()
	if self:_onItemClick() then
		return
	end

	local itemCo = self._mo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V2a8_DragonBoat_RewardItemItem:setActive_cangetGo(isActive)
	gohelper.setActive(self._cangetGo, isActive and true or false)
end

function V2a8_DragonBoat_RewardItemItem:setActive_hasgetGo(isActive)
	gohelper.setActive(self._hasgetGo, isActive and true or false)
	self._item:setGetMask(isActive)
end

function V2a8_DragonBoat_RewardItemItem:_onItemClick()
	local p = self:_assetGetParent()

	return p:onItemClick()
end

return V2a8_DragonBoat_RewardItemItem
