-- chunkname: @modules/logic/act189/view/ShortenAct_FullView.lua

module("modules.logic.act189.view.ShortenAct_FullView", package.seeall)

local ShortenAct_FullView = class("ShortenAct_FullView", ShortenActView_impl)

function ShortenAct_FullView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/limittimebg/#txt_time")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/right/#simage_title")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_tasklist")
	self._go28days = gohelper.findChild(self.viewGO, "root/#go_28days")
	self._go35days = gohelper.findChild(self.viewGO, "root/#go_35days")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShortenAct_FullView:addEvents()
	return
end

function ShortenAct_FullView:removeEvents()
	return
end

function ShortenAct_FullView:_editableInitView()
	ShortenAct_FullView.super._editableInitView(self)
	Activity189Controller.instance:sendGetAct189InfoRequest(self:actId())
end

function ShortenAct_FullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	ShortenAct_FullView.super.onOpen(self)
end

return ShortenAct_FullView
