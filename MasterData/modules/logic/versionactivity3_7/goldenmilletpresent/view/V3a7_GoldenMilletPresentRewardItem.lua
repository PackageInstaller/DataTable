-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentRewardItem.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentRewardItem", package.seeall)

local V3a7_GoldenMilletPresentRewardItem = class("V3a7_GoldenMilletPresentRewardItem", RougeSimpleItemBase)

function V3a7_GoldenMilletPresentRewardItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._gocanget = gohelper.findChild(self.viewGO, "#go_canget")
	self._goreceive = gohelper.findChild(self.viewGO, "#go_receive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_GoldenMilletPresentRewardItem:addEvents()
	return
end

function V3a7_GoldenMilletPresentRewardItem:removeEvents()
	return
end

function V3a7_GoldenMilletPresentRewardItem:ctor(...)
	V3a7_GoldenMilletPresentRewardItem.super.ctor(self, ...)
end

function V3a7_GoldenMilletPresentRewardItem:_editableInitView()
	V3a7_GoldenMilletPresentRewardItem.super._editableInitView(self)

	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._goicon)

	local hasGetGo = gohelper.findChild(self._goreceive, "go_hasget")

	self._hasgetAnim = hasGetGo:GetComponent(gohelper.Type_Animator)
end

function V3a7_GoldenMilletPresentRewardItem:_isType101RewardGet()
	local p = self:parent()

	return p:_isType101RewardGet()
end

function V3a7_GoldenMilletPresentRewardItem:_isType101RewardCouldGet()
	local p = self:parent()

	return p:_isType101RewardCouldGet()
end

function V3a7_GoldenMilletPresentRewardItem:setData(mo)
	V3a7_GoldenMilletPresentRewardItem.super.setData(self, mo)

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

function V3a7_GoldenMilletPresentRewardItem:onDestroyView()
	V3a7_GoldenMilletPresentRewardItem.super.onDestroyView(self)
end

function V3a7_GoldenMilletPresentRewardItem:_onItemClick()
	local p = self:parent()

	p:onRewardItemClick(self)
end

function V3a7_GoldenMilletPresentRewardItem:_setActive_goreceive(isActive)
	gohelper.setActive(self._goreceive, isActive)
end

function V3a7_GoldenMilletPresentRewardItem:_setActive_canget(isActive)
	gohelper.setActive(self._gocanget, isActive)
end

local kHasGetAnim = "go_hasget_in"
local kIdleAnim = "go_hasget_idle"

function V3a7_GoldenMilletPresentRewardItem:playAnim_hasget(bIdle)
	if bIdle then
		if not kIdleAnim then
			local animName = kHasGetAnim

			self:_setActive_canget(false)
			self._hasgetAnim:Play(animName, 0, 0)
		end
	end
end

function V3a7_GoldenMilletPresentRewardItem:_set_Received()
	self:_setActive_canget(false)
	self:_setActive_goreceive(true)
	self._hasgetAnim:Play(kHasGetAnim, 0, 1)
end

return V3a7_GoldenMilletPresentRewardItem
