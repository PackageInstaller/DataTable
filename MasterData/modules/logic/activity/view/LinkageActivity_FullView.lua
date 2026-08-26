-- chunkname: @modules/logic/activity/view/LinkageActivity_FullView.lua

module("modules.logic.activity.view.LinkageActivity_FullView", package.seeall)

local LinkageActivity_FullView = class("LinkageActivity_FullView", LinkageActivity_FullViewBase)

function LinkageActivity_FullView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_FullView:addEvents()
	LinkageActivity_FullView.super.addEvents(self)
end

function LinkageActivity_FullView:removeEvents()
	LinkageActivity_FullView.super.removeEvents(self)
end

local kPageType = {
	SkinShop = 1,
	Sign = 2
}

function LinkageActivity_FullView:ctor(...)
	LinkageActivity_FullView.super.ctor(self, ...)
end

function LinkageActivity_FullView:_editableInitView()
	self._txtLimitTime.text = ""
	self._pageGo1 = gohelper.findChild(self.viewGO, "Root/Page1")
	self._pageGo2 = gohelper.findChild(self.viewGO, "Root/Page2")
end

function LinkageActivity_FullView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	LinkageActivity_FullView.super.onDestroyView(self)
end

function LinkageActivity_FullView:onStart()
	self:addPage(kPageType.SkinShop, self._pageGo1, LinkageActivity_FullView_Page1)
	self:addPage(kPageType.Sign, self._pageGo2, LinkageActivity_FullView_Page2)

	if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self:actId()) then
		self:selectedPage_Sign()
	else
		self:selectedPage_SkinShop()
	end
end

function LinkageActivity_FullView:onRefresh()
	LinkageActivity_FullView.super.onRefresh(self)
	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function LinkageActivity_FullView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function LinkageActivity_FullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function LinkageActivity_FullView:selectedPage_Sign()
	self:selectedPage(kPageType.Sign)
end

function LinkageActivity_FullView:selectedPage_SkinShop()
	self:selectedPage(kPageType.SkinShop)
end

return LinkageActivity_FullView
