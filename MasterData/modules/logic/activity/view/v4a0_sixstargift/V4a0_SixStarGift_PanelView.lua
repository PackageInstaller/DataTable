-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGift_PanelView.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGift_PanelView", package.seeall)

local V4a0_SixStarGift_PanelView = class("V4a0_SixStarGift_PanelView", V4a0_SixStarGiftImpl)

function V4a0_SixStarGift_PanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
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

function V4a0_SixStarGift_PanelView:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V4a0_SixStarGift_PanelView:removeEvents()
	self._btntip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function V4a0_SixStarGift_PanelView:ctor(...)
	V4a0_SixStarGift_PanelView.super.ctor(self, ...)
end

function V4a0_SixStarGift_PanelView:_editableInitView()
	V4a0_SixStarGift_PanelView.super._editableInitView(self)
end

function V4a0_SixStarGift_PanelView:onDestroyView()
	V4a0_SixStarGift_PanelView.super.onDestroyView(self)
end

function V4a0_SixStarGift_PanelView:onClickModalMask()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function V4a0_SixStarGift_PanelView:onOpen()
	V4a0_SixStarGift_PanelView.super.onOpen(self)
end

function V4a0_SixStarGift_PanelView:_onPayFinished()
	V4a0_SixStarGift_PanelView.super._onPayFinished(self)
	self:closeThis()
end

return V4a0_SixStarGift_PanelView
