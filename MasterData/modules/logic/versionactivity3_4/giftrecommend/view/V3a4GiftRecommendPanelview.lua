-- chunkname: @modules/logic/versionactivity3_4/giftrecommend/view/V3a4GiftRecommendPanelview.lua

module("modules.logic.versionactivity3_4.giftrecommend.view.V3a4GiftRecommendPanelview", package.seeall)

local V3a4GiftRecommendPanelview = class("V3a4GiftRecommendPanelview", V3a4GiftRecommendBaseView)

function V3a4GiftRecommendPanelview:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "root/reward1/#image_icon")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "root/reward2/#image_icon")
	self._imageicon3 = gohelper.findChildImage(self.viewGO, "root/reward3/#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4GiftRecommendPanelview:addEvents()
	V3a4GiftRecommendPanelview.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V3a4GiftRecommendPanelview:removeEvents()
	V3a4GiftRecommendPanelview.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
end

function V3a4GiftRecommendPanelview:_btncloseOnClick()
	self:closeThis()
end

function V3a4GiftRecommendPanelview:_editableInitView()
	V3a4GiftRecommendPanelview.super._editableInitView(self)
end

return V3a4GiftRecommendPanelview
