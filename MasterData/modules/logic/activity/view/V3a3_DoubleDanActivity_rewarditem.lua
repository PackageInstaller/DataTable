-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivity_rewarditem.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivity_rewarditem", package.seeall)

local V3a3_DoubleDanActivity_rewarditem = class("V3a3_DoubleDanActivity_rewarditem", RougeSimpleItemBase)

function V3a3_DoubleDanActivity_rewarditem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a3_DoubleDanActivity_rewarditem:addEvents()
	return
end

function V3a3_DoubleDanActivity_rewarditem:removeEvents()
	return
end

function V3a3_DoubleDanActivity_rewarditem:_editableInitView()
	V3a3_DoubleDanActivity_rewarditem.super._editableInitView(self)

	self._image_rare = gohelper.findChildImage(self.viewGO, "image_rare")
	self._txt_count = gohelper.findChildText(self.viewGO, "countbg/txt_count")
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(self.viewGO, "simage_icon"))
	self._btn_click = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
end

function V3a3_DoubleDanActivity_rewarditem:_editableAddEvents()
	self._btn_click:AddClickListener(self._btn_clickOnClick, self)
end

function V3a3_DoubleDanActivity_rewarditem:_editableRemoveEvents()
	self._btn_click:RemoveClickListener()
end

function V3a3_DoubleDanActivity_rewarditem:_btn_clickOnClick()
	self:_onItemClick()
end

function V3a3_DoubleDanActivity_rewarditem:_isType101RewardGet()
	local p = self:parent()

	return p:_isType101RewardGet()
end

function V3a3_DoubleDanActivity_rewarditem:setData(mo)
	V3a3_DoubleDanActivity_rewarditem.super.setData(self, mo)

	local isClaimed = self:_isType101RewardGet()
	local itemType = mo[1]
	local itemId = mo[2]

	if not mo[3] then
		local itemCount = 0
		local itemCO, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

		self:_setActive_goLocked(isClaimed)
		self._itemIcon:setMOValue(itemType, itemId, itemCount)
		self._itemIcon:isShowQuality(false)
		self._itemIcon:isShowEquipAndItemCount(false)
		self._itemIcon:customOnClickCallback(self._onItemClick, self)

		if self._itemIcon:isEquipIcon() then
			self._itemIcon:setScale(0.7)
		else
			self._itemIcon:setScale(0.8)
		end

		self:_refresh_image_rare(itemCO.rare)

		self._txt_count.text = luaLang("multiple") .. itemCount
	end
end

function V3a3_DoubleDanActivity_rewarditem:_onItemClick()
	local p = self:parent()

	if p:onRewardItemClick() then
		return
	end

	local mo = self._mo

	if not mo then
		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function V3a3_DoubleDanActivity_rewarditem:_refresh_image_rare(itemRare)
	UISpriteSetMgr.instance:setUiFBSprite(self._image_rare, "bg_pinjidi_" .. tostring(itemRare or 0))
end

function V3a3_DoubleDanActivity_rewarditem:_setActive_goLocked(isActive)
	gohelper.setActive(self._goLocked, isActive)
end

return V3a3_DoubleDanActivity_rewarditem
