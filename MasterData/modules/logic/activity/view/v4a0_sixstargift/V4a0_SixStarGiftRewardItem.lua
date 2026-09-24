-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGiftRewardItem.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGiftRewardItem", package.seeall)

local V4a0_SixStarGiftRewardItem = class("V4a0_SixStarGiftRewardItem", RougeSimpleItemBase)

function V4a0_SixStarGiftRewardItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "txtbg/#txt_num")
	self._goclaim = gohelper.findChild(self.viewGO, "#go_claim")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "#go_claim/#btn_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_SixStarGiftRewardItem:addEvents()
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function V4a0_SixStarGiftRewardItem:removeEvents()
	self._btnclaim:RemoveClickListener()
end

function V4a0_SixStarGiftRewardItem:_btnclaimOnClick()
	self:_onItemClick()
end

function V4a0_SixStarGiftRewardItem:ctor(...)
	V4a0_SixStarGiftRewardItem.super.ctor(self, ...)
end

function V4a0_SixStarGiftRewardItem:_editableInitView()
	V4a0_SixStarGiftRewardItem.super._editableInitView(self)

	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._goicon)
end

function V4a0_SixStarGiftRewardItem:_isType101RewardGet()
	local p = self:parent()

	return p:_isType101RewardGet()
end

function V4a0_SixStarGiftRewardItem:_isType101RewardCouldGet()
	local p = self:parent()

	return p:_isType101RewardCouldGet()
end

function V4a0_SixStarGiftRewardItem:setData(mo)
	V4a0_SixStarGiftRewardItem.super.setData(self, mo)

	local isClaimable = self:_isType101RewardCouldGet()
	local isClaimed = self:_isType101RewardGet()
	local itemType = mo[1]
	local itemId = mo[2]

	if not mo[3] then
		self:_setActive_canget(isClaimable)
		self:_setActive_hasget(isClaimed)
		self._itemIcon:setMOValue(itemType, itemId, mo[3])
		self._itemIcon:isShowQuality(false)
		self._itemIcon:isShowEquipAndItemCount(false)
		self._itemIcon:customOnClickCallback(self._onItemClick, self)

		self._txtnum.text = string.format(luaLang("V3a9_DragonBoatActivity_RewardItem_txtrewardcount"), mo[3])
	end
end

function V4a0_SixStarGiftRewardItem:onDestroyView()
	V4a0_SixStarGiftRewardItem.super.onDestroyView(self)
end

function V4a0_SixStarGiftRewardItem:_onItemClick()
	local p = self:parent()

	p:onRewardItemClick(self)
end

function V4a0_SixStarGiftRewardItem:_setActive_hasget(isActive)
	gohelper.setActive(self._gohasget, isActive)
end

function V4a0_SixStarGiftRewardItem:_setActive_canget(isActive)
	gohelper.setActive(self._goclaim, isActive)
end

local kHasGetAnim = "go_hasget_in"
local kIdleAnim = "go_hasget_idle"

function V4a0_SixStarGiftRewardItem:playAnim_hasget(bIdle)
	if bIdle then
		if not kIdleAnim then
			self:_setActive_canget(false)
		end
	end
end

function V4a0_SixStarGiftRewardItem:_set_Received()
	self:_setActive_canget(false)
	self:_setActive_hasget(true)
end

return V4a0_SixStarGiftRewardItem
