-- chunkname: @modules/logic/store/view/StoreTipView.lua

module("modules.logic.store.view.StoreTipView", package.seeall)

local StoreTipView = class("StoreTipView", BaseView)

function StoreTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._gomonthcardtip = gohelper.findChild(self.viewGO, "#go_monthcardtip")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent")
	self._txttip = gohelper.findChildText(self.viewGO, "#go_monthcardtip/tipscroll/Viewport/#go_tipcontent/#txt_tip")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "#go_monthcardtip/bg/#simage_icon1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_monthcardtip/bg/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreTipView:addEvents()
	return
end

function StoreTipView:removeEvents()
	return
end

function StoreTipView:_editableInitView()
	self._simageicon2:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simageicon1:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_monthcardtip/title")
end

function StoreTipView:onClickModalMask()
	self:closeThis()
end

function StoreTipView:_desc()
	return self.viewParam.desc or ""
end

function StoreTipView:_title()
	return self.viewParam.title or luaLang("p_storetipview_title")
end

function StoreTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_open)

	self._txttip.text = self:_desc()
	self._txtTitle.text = self:_title()
end

function StoreTipView:onClose()
	return
end

function StoreTipView:onDestroyView()
	self._simageicon1:UnLoadImage()
	self._simageicon2:UnLoadImage()
end

return StoreTipView
