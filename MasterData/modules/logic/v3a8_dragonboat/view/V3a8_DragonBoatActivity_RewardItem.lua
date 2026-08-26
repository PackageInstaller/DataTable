-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_RewardItem.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_RewardItem", package.seeall)

local V3a8_DragonBoatActivity_RewardItem = class("V3a8_DragonBoatActivity_RewardItem", RougeSimpleItemBase)

function V3a8_DragonBoatActivity_RewardItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_hasget")
	self._gocanget = gohelper.findChild(self.viewGO, "#go_canget")
	self._goexpired = gohelper.findChild(self.viewGO, "#go_expired")
	self._txtrewardcount = gohelper.findChildText(self.viewGO, "#txt_rewardcount")
	self._txtvotenum = gohelper.findChildText(self.viewGO, "#txt_votenum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_RewardItem:addEvents()
	return
end

function V3a8_DragonBoatActivity_RewardItem:removeEvents()
	return
end

function V3a8_DragonBoatActivity_RewardItem:ctor(...)
	V3a8_DragonBoatActivity_RewardItem.super.ctor(self, ...)
end

function V3a8_DragonBoatActivity_RewardItem:onDestroyView()
	V3a8_DragonBoatActivity_RewardItem.super.onDestroyView(self)
end

function V3a8_DragonBoatActivity_RewardItem:_editableInitView()
	V3a8_DragonBoatActivity_RewardItem.super._editableInitView(self)

	self._item = IconMgr.instance:getCommonPropItemIcon(self._goicon)

	self:setActive_cangetGo(false)
	self:setActive_hasgetGo(false)
	self:setActive_goexpired(false)
end

function V3a8_DragonBoatActivity_RewardItem:setData(mo)
	V3a8_DragonBoatActivity_RewardItem.super.setData(self, mo)

	local itemType = mo[1]
	local itemId = mo[2]
	local itemCount = mo[3]
	local itemCO, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)
	local isClaimed = self:isClaimed()
	local isExpired = self:isExpired()
	local isClaimable = self:isClaimable()

	self:setActive_cangetGo(isClaimable and not isClaimed)
	self:setActive_hasgetGo(isClaimed)
	self:setActive_goexpired(isExpired and not isClaimed)
	self._item:setMOValue(itemType, itemId, itemCount)
	self._item:isShowQuality(false)
	self._item:isShowEquipAndItemCount(false)
	self._item:customOnClickCallback(self._customOnClickCallback, self)

	if self._item:isEquipIcon() then
		self._item:setScale(0.7)
	else
		self._item:setScale(0.8)
	end

	self:_setBg(itemCO.rare)

	self._txtrewardcount.text = string.format(luaLang("V3a9_DragonBoatActivity_RewardItem_txtrewardcount"), itemCount)
	self._txtvotenum.text = string.format(luaLang("V3a8_DragonBoatActivity_RewardItem_txtvotenum"), self:index())
end

function V3a8_DragonBoatActivity_RewardItem:isExpired()
	local c = self:baseViewContainer()

	return c:isExpired(self:index())
end

function V3a8_DragonBoatActivity_RewardItem:isClaimed()
	local c = self:baseViewContainer()

	return c:isClaimed(self:index())
end

function V3a8_DragonBoatActivity_RewardItem:isClaimable()
	local c = self:baseViewContainer()

	return c:isClaimable(self:index())
end

function V3a8_DragonBoatActivity_RewardItem:_setBg(itemRare)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_" .. tostring(itemRare or 0))
end

function V3a8_DragonBoatActivity_RewardItem:_customOnClickCallback()
	if self:_onItemClick() then
		return
	end

	local itemCo = self._mo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V3a8_DragonBoatActivity_RewardItem:setActive_cangetGo(isActive)
	gohelper.setActive(self._gocanget, isActive)
end

function V3a8_DragonBoatActivity_RewardItem:setActive_hasgetGo(isActive)
	gohelper.setActive(self._gohasget, isActive)
	self._item:setGetMask(isActive)
end

function V3a8_DragonBoatActivity_RewardItem:setActive_goexpired(isActive)
	gohelper.setActive(self._goexpired, isActive)
end

function V3a8_DragonBoatActivity_RewardItem:_onItemClick()
	local p = self:_assetGetParent()

	return p:onRewardItemClick()
end

return V3a8_DragonBoatActivity_RewardItem
