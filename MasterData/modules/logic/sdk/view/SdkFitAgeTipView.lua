-- chunkname: @modules/logic/sdk/view/SdkFitAgeTipView.lua

module("modules.logic.sdk.view.SdkFitAgeTipView", package.seeall)

local SdkFitAgeTipView = class("SdkFitAgeTipView", BaseView)

function SdkFitAgeTipView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_line")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_sure")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SdkFitAgeTipView:addEvents()
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function SdkFitAgeTipView:removeEvents()
	self._btnsure:RemoveClickListener()
end

function SdkFitAgeTipView:_btnsureOnClick()
	self:closeThis()
end

function SdkFitAgeTipView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getSdkIcon("bg_beijing"))
	self._simageline:LoadImage(ResUrl.getSdkIcon("bg_hengxian"))
end

function SdkFitAgeTipView:onUpdateParam()
	return
end

function SdkFitAgeTipView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.SdkFitAgeTipView, self._btnsureOnClick, self)
end

function SdkFitAgeTipView:onClose()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
end

function SdkFitAgeTipView:onDestroyView()
	return
end

return SdkFitAgeTipView
