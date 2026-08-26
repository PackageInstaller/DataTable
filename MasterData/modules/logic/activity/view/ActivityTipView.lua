-- chunkname: @modules/logic/activity/view/ActivityTipView.lua

module("modules.logic.activity.view.ActivityTipView", package.seeall)

local ActivityTipView = class("ActivityTipView", BaseView)

function ActivityTipView:onInitView()
	self._btnbgclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bgclick")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._btnmask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tip/#btn_mask")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tip/#txt_desc")
	self._scrollruledesc = gohelper.findChildScrollRect(self.viewGO, "#go_tip/#scroll_ruledesc")
	self._txttip = gohelper.findChildText(self.viewGO, "#go_tip/#scroll_ruledesc/Viewport/Content/#txt_tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityTipView:addEvents()
	self._btnbgclick:AddClickListener(self._btnbgclickOnClick, self)
	self._btnmask:AddClickListener(self._btnmaskOnClick, self)
end

function ActivityTipView:removeEvents()
	self._btnbgclick:RemoveClickListener()
	self._btnmask:RemoveClickListener()
end

function ActivityTipView:_btnbgclickOnClick()
	self:closeThis()
end

function ActivityTipView:_editableInitView()
	self._viewName = nil
end

function ActivityTipView:_btnmaskOnClick()
	return
end

function ActivityTipView:onOpen()
	self:_refresh()
end

function ActivityTipView:onClose()
	return
end

function ActivityTipView:onClickModalMask()
	self:closeThis()
end

function ActivityTipView:_refresh()
	gohelper.addChild(self.viewParam.rootGo, self.viewGO)

	local width = recthelper.getWidth(self.viewParam.rootGo.transform)

	transformhelper.setLocalPosXY(self._gotip.transform, width, 0)

	self._txtdesc.text = self.viewParam.title
	self._txttip.text = self.viewParam.desc
end

function ActivityTipView:onDestroyView()
	return
end

return ActivityTipView
