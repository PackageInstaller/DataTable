-- chunkname: @modules/logic/towercompose/view/TowerComposePickAssistView.lua

module("modules.logic.towercompose.view.TowerComposePickAssistView", package.seeall)

local TowerComposePickAssistView = class("TowerComposePickAssistView", PickAssistView)

function TowerComposePickAssistView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg1/#simage_bg1")
	self._golefttopbtns = gohelper.findChild(self.viewGO, "#go_lefttopbtns")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._scrollselection = gohelper.findChildScrollRect(self.viewGO, "#scroll_selection")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_refresh")
	self._simageprogress = gohelper.findChildImage(self.viewGO, "bottom/#btn_refresh/#simage_progress")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_detail")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposePickAssistView:addEvents()
	TowerComposePickAssistView.super.addEvents(self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectAssistCallBack, self.onSelectAssistCallBack, self)
end

function TowerComposePickAssistView:removeEvents()
	TowerComposePickAssistView.super.removeEvents(self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.SelectAssistCallBack, self.onSelectAssistCallBack, self)
end

function TowerComposePickAssistView:_editableInitView()
	return
end

function TowerComposePickAssistView:onUpdateParam()
	return
end

function TowerComposePickAssistView:onOpen()
	self.scrollView = self.viewContainer and self.viewContainer.scrollView
	self.isClickConfirm = false

	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshCD, self, 0.01)
end

function TowerComposePickAssistView:refreshUI()
	self:refreshCD()
	self:refreshIsEmpty()
	self:refreshBtnDetail()
end

function TowerComposePickAssistView:_btnconfirmOnClick()
	if self.isClickConfirm then
		return
	end

	self.isClickConfirm = true

	PickAssistController.instance:pickOver()
end

function TowerComposePickAssistView:onSelectAssistCallBack(pickAssistHeroMO)
	self.isClickConfirm = false

	if pickAssistHeroMO then
		GameFacade.showToast(ToastEnum.TowerComposeSelectAssist, pickAssistHeroMO.name)
		self:closeThis()
	else
		GameFacade.showToast(ToastEnum.TowerComposeNotSelectAssist)
	end
end

function TowerComposePickAssistView:onDestroyView()
	PickAssistController.instance:onCloseView()
end

return TowerComposePickAssistView
