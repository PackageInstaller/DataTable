-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentRewardItem.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentRewardItem", package.seeall)

local GoldenMilletPresentRewardItem = class("GoldenMilletPresentRewardItem", RougeSimpleItemBase)

function GoldenMilletPresentRewardItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._gocanget = gohelper.findChild(self.viewGO, "#go_canget")
	self._goreceive = gohelper.findChild(self.viewGO, "#go_receive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GoldenMilletPresentRewardItem:addEvents()
	return
end

function GoldenMilletPresentRewardItem:removeEvents()
	return
end

function GoldenMilletPresentRewardItem:ctor(...)
	GoldenMilletPresentRewardItem.super.ctor(self, ...)
end

function GoldenMilletPresentRewardItem:_editableInitView()
	GoldenMilletPresentRewardItem.super._editableInitView(self)

	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._goicon)

	local hasGetGo = gohelper.findChild(self._goreceive, "go_hasget")

	self._hasgetAnim = hasGetGo:GetComponent(gohelper.Type_Animator)
end

function GoldenMilletPresentRewardItem:_isType101RewardGet()
	local p = self:parent()

	return p:_isType101RewardGet()
end

function GoldenMilletPresentRewardItem:_isType101RewardCouldGet()
	local p = self:parent()

	return p:_isType101RewardCouldGet()
end

function GoldenMilletPresentRewardItem:setData(mo)
	GoldenMilletPresentRewardItem.super.setData(self, mo)

	local isClaimable = self:_isType101RewardCouldGet()
	local isClaimed = self:_isType101RewardGet()
	local itemType = mo[1]
	local itemId = mo[2]

	if not mo[3] then
		self:_setActive_canget(isClaimable)
		self:_setActive_goreceive(isClaimed)
		self._itemIcon:setMOValue(itemType, itemId, mo[3])
		self._itemIcon:isShowEquipAndItemCount(false)
		self._itemIcon:customOnClickCallback(self._onItemClick, self)
	end
end

function GoldenMilletPresentRewardItem:onDestroyView()
	GoldenMilletPresentRewardItem.super.onDestroyView(self)
end

function GoldenMilletPresentRewardItem:_onItemClick()
	local p = self:parent()

	p:onRewardItemClick(self)
end

function GoldenMilletPresentRewardItem:_setActive_goreceive(isActive)
	gohelper.setActive(self._goreceive, isActive)
end

function GoldenMilletPresentRewardItem:_setActive_canget(isActive)
	gohelper.setActive(self._gocanget, isActive)
end

local kHasGetAnim = "go_hasget_in"
local kIdleAnim = "go_hasget_idle"

function GoldenMilletPresentRewardItem:playAnim_hasget(bIdle)
	if bIdle then
		if not kIdleAnim then
			local animName = kHasGetAnim

			self:_setActive_canget(false)
			self._hasgetAnim:Play(animName, 0, 0)
		end
	end
end

function GoldenMilletPresentRewardItem:_set_Received()
	self:_setActive_canget(false)
	self:_setActive_goreceive(true)
	self._hasgetAnim:Play(kHasGetAnim, 0, 1)
end

return GoldenMilletPresentRewardItem
