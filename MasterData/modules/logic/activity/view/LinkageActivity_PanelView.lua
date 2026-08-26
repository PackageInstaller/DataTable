-- chunkname: @modules/logic/activity/view/LinkageActivity_PanelView.lua

module("modules.logic.activity.view.LinkageActivity_PanelView", package.seeall)

local LinkageActivity_PanelView = class("LinkageActivity_PanelView", LinkageActivity_PanelViewBase)

function LinkageActivity_PanelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_PanelView:addEvents()
	LinkageActivity_PanelView.super.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function LinkageActivity_PanelView:removeEvents()
	self._btnClose:RemoveClickListener()
	LinkageActivity_PanelView.super.removeEvents(self)
end

function LinkageActivity_PanelView:ctor(...)
	LinkageActivity_PanelView.super.ctor(self, ...)
end

function LinkageActivity_PanelView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	LinkageActivity_PanelView.super.onDestroyView(self)
end

function LinkageActivity_PanelView:onClickModalMask()
	self:closeThis()
end

function LinkageActivity_PanelView:_btnCloseOnClick()
	self:closeThis()
end

function LinkageActivity_PanelView:_editableInitView()
	self._txtLimitTime.text = ""
	self._pageGo1 = gohelper.findChild(self.viewGO, "Page1")
	self._pageGo2 = gohelper.findChild(self.viewGO, "Page2")
end

function LinkageActivity_PanelView:onStart()
	self:addPage(1, self._pageGo1, LinkageActivity_PanelView_Page1)
	self:addPage(2, self._pageGo2, LinkageActivity_PanelView_Page2)
	self:selectedPage(2)
end

function LinkageActivity_PanelView:onRefresh()
	LinkageActivity_PanelView.super.onRefresh(self)
	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function LinkageActivity_PanelView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function LinkageActivity_PanelView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return LinkageActivity_PanelView
