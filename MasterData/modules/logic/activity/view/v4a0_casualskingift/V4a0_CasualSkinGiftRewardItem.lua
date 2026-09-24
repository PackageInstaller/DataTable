-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGiftRewardItem.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGiftRewardItem", package.seeall)

local V4a0_CasualSkinGiftRewardItem = class("V4a0_CasualSkinGiftRewardItem", RougeSimpleItemBase)

function V4a0_CasualSkinGiftRewardItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_CasualSkinGiftRewardItem:addEvents()
	return
end

function V4a0_CasualSkinGiftRewardItem:removeEvents()
	return
end

function V4a0_CasualSkinGiftRewardItem:_btnclaimOnClick()
	self:_onItemClick()
end

function V4a0_CasualSkinGiftRewardItem:ctor(...)
	V4a0_CasualSkinGiftRewardItem.super.ctor(self, ...)
end

function V4a0_CasualSkinGiftRewardItem:_editableInitView()
	V4a0_CasualSkinGiftRewardItem.super._editableInitView(self)

	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "")
end

function V4a0_CasualSkinGiftRewardItem:_editableAddEvents()
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function V4a0_CasualSkinGiftRewardItem:_editableRemoveEvents()
	self._btnclaim:RemoveClickListener()
end

function V4a0_CasualSkinGiftRewardItem:_isType101RewardGet()
	local p = self:parent()

	return p:_isType101RewardGet()
end

function V4a0_CasualSkinGiftRewardItem:_isType101RewardCouldGet()
	local p = self:parent()

	return p:_isType101RewardCouldGet()
end

function V4a0_CasualSkinGiftRewardItem:setData(mo)
	V4a0_CasualSkinGiftRewardItem.super.setData(self, mo)
end

function V4a0_CasualSkinGiftRewardItem:onDestroyView()
	V4a0_CasualSkinGiftRewardItem.super.onDestroyView(self)
end

function V4a0_CasualSkinGiftRewardItem:_onItemClick()
	local p = self:parent()

	p:onRewardItemClick(self)
end

function V4a0_CasualSkinGiftRewardItem:_setActive_hasget(isActive)
	return
end

function V4a0_CasualSkinGiftRewardItem:_setActive_canget(isActive)
	return
end

function V4a0_CasualSkinGiftRewardItem:playAnim_hasget(bIdle)
	return
end

function V4a0_CasualSkinGiftRewardItem:_set_Received()
	return
end

return V4a0_CasualSkinGiftRewardItem
