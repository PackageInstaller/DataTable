-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsReadView.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadView", package.seeall)

local SportsNewsReadView = class("SportsNewsReadView", BaseView)

function SportsNewsReadView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "txt_TitleEn")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/#txt_Descr")
	self._goRedPoint = gohelper.findChild(self.viewGO, "#go_RedPoint")
	self._imagepic = gohelper.findChildSingleImage(self.viewGO, "image_Pic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsReadView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SportsNewsReadView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SportsNewsReadView:_btncloseOnClick()
	self:closeThis()
end

function SportsNewsReadView:_btnstartbtnOnClick()
	return
end

function SportsNewsReadView:_editableInitView()
	return
end

function SportsNewsReadView:onOpen()
	local orderMO = self.viewParam.orderMO

	self._txtTitle.text = tostring(orderMO.cfg.name)
	self._txtTitleEn.text = tostring(orderMO.cfg.titledesc)
	self._txtDescr.text = orderMO.cfg.infoDesc

	local iconName = orderMO.cfg.bossPic

	self._imagepic:LoadImage(ResUrl.getV1a5News(iconName))
end

function SportsNewsReadView:onDestroyView()
	self._imagepic:UnLoadImage()
end

function SportsNewsReadView:onClickModalMask()
	self:closeThis()
end

return SportsNewsReadView
