-- chunkname: @modules/logic/act189/view/ShortenAct_PanelView.lua

module("modules.logic.act189.view.ShortenAct_PanelView", package.seeall)

local ShortenAct_PanelView = class("ShortenAct_PanelView", ShortenActView_impl)

function ShortenAct_PanelView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/limittimebg/#txt_time")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/right/#simage_title")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_tasklist")
	self._go28days = gohelper.findChild(self.viewGO, "root/#go_28days")
	self._go35days = gohelper.findChild(self.viewGO, "root/#go_35days")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShortenAct_PanelView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function ShortenAct_PanelView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function ShortenAct_PanelView:_btnCloseOnClick()
	self:closeThis()
end

function ShortenAct_PanelView:_btnemptyTopOnClick()
	self:closeThis()
end

function ShortenAct_PanelView:_btnemptyBottomOnClick()
	self:closeThis()
end

function ShortenAct_PanelView:_btnemptyLeftOnClick()
	self:closeThis()
end

function ShortenAct_PanelView:_btnemptyRightOnClick()
	self:closeThis()
end

function ShortenAct_PanelView:_editableInitView()
	ShortenAct_PanelView.super._editableInitView(self)
end

return ShortenAct_PanelView
