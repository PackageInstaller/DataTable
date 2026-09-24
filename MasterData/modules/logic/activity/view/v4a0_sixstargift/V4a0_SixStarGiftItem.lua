-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGiftItem.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGiftItem", package.seeall)

local V4a0_SixStarGiftItem = class("V4a0_SixStarGiftItem", RougeSimpleItemBase)

function V4a0_SixStarGiftItem:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_SixStarGiftItem:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function V4a0_SixStarGiftItem:removeEvents()
	self._btncheck:RemoveClickListener()
end

function V4a0_SixStarGiftItem:_btncheckOnClick()
	local p = self:parent()

	p:onPresentBtnClick(self)
end

function V4a0_SixStarGiftItem:ctor(...)
	V4a0_SixStarGiftItem.super.ctor(self, ...)
end

function V4a0_SixStarGiftItem:_editableInitView()
	V4a0_SixStarGiftItem.super._editableInitView(self)
end

function V4a0_SixStarGiftItem:setData(mo)
	V4a0_SixStarGiftItem.super.setData(self, mo)
end

function V4a0_SixStarGiftItem:onDestroyView()
	V4a0_SixStarGiftItem.super.onDestroyView(self)
end

return V4a0_SixStarGiftItem
