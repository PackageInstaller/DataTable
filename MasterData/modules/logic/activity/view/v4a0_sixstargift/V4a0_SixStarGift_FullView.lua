-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGift_FullView.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGift_FullView", package.seeall)

local V4a0_SixStarGift_FullView = class("V4a0_SixStarGift_FullView", V4a0_SixStarGiftImpl)

function V4a0_SixStarGift_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Right/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#simage_Title/#btn_tip")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Btn/#btn_buy")
	self._gohasbuy = gohelper.findChild(self.viewGO, "Root/Right/Btn/#go_hasbuy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_SixStarGift_FullView:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V4a0_SixStarGift_FullView:removeEvents()
	self._btntip:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function V4a0_SixStarGift_FullView:ctor(...)
	V4a0_SixStarGift_FullView.super.ctor(self, ...)
end

function V4a0_SixStarGift_FullView:_editableInitView()
	V4a0_SixStarGift_FullView.super._editableInitView(self)
end

function V4a0_SixStarGift_FullView:onDestroyView()
	V4a0_SixStarGift_FullView.super.onDestroyView(self)
end

function V4a0_SixStarGift_FullView:onOpen()
	V4a0_SixStarGift_FullView.super.onOpen(self)
end

return V4a0_SixStarGift_FullView
