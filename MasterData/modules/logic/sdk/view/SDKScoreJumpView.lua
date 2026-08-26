-- chunkname: @modules/logic/sdk/view/SDKScoreJumpView.lua

module("modules.logic.sdk.view.SDKScoreJumpView", package.seeall)

local SDKScoreJumpView = class("SDKScoreJumpView", BaseView)

function SDKScoreJumpView:onInitView()
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn1/#btn_cancel")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn2/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SDKScoreJumpView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnclose:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function SDKScoreJumpView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function SDKScoreJumpView:_btncancelOnClick()
	self:closeThis()
end

function SDKScoreJumpView:_btnconfirmOnClick()
	self:closeThis()

	local version = UnityEngine.Application.version

	if GameChannelConfig.isGpGlobal() and version == "1.0.4" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.en.reverse1999")

		return
	elseif GameChannelConfig.isGpJapan() and version == "1.0.5" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.jp.reverse1999.and")

		return
	elseif GameChannelConfig.isEfun() and BootNativeUtil.isAndroid() and version == "1.0.2" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.mover.twcfwl1999")

		return
	end

	if GameChannelConfig.isGpJapan() then
		SDKMgr.instance:appReview()
	end

	if GameChannelConfig.isEfun() then
		SDKMgr.instance:appReview()
	end

	if GameChannelConfig.isGpGlobal() then
		SDKMgr.instance:appReview()
	end
end

function SDKScoreJumpView:_editableInitView()
	self._simagebgimg_top = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")

	self._simagebgimg_top:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._simagebgimg_bot = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")

	self._simagebgimg_bot:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function SDKScoreJumpView:onUpdateParam()
	return
end

function SDKScoreJumpView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.SDKScoreJumpView, self.closeThis, self)
end

function SDKScoreJumpView:onClose()
	return
end

function SDKScoreJumpView:onClickModalMask()
	self:closeThis()
end

function SDKScoreJumpView:onDestroyView()
	return
end

return SDKScoreJumpView
