-- chunkname: @modules/logic/survival/view/map/SurvivalMapResultPanelView.lua

module("modules.logic.survival.view.map.SurvivalMapResultPanelView", package.seeall)

local SurvivalMapResultPanelView = class("SurvivalMapResultPanelView", BaseView)

function SurvivalMapResultPanelView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_failed")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
end

function SurvivalMapResultPanelView:addEvents()
	self._btnclose:AddClickListener(self._onClickClose, self)
end

function SurvivalMapResultPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
end

function SurvivalMapResultPanelView:onOpen()
	local isWin = self.viewParam.isWin

	gohelper.setActive(self._gosuccess, isWin)
	gohelper.setActive(self._gofail, not isWin)

	if isWin then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_1)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_fail)
	end
end

function SurvivalMapResultPanelView:onClickModalMask()
	self:_onClickClose()
end

function SurvivalMapResultPanelView:_onClickClose()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	ViewMgr.instance:openView(ViewName.SurvivalMapResultView, self.viewParam)
	self:closeThis()
end

function SurvivalMapResultPanelView:_onViewOpen(viewName)
	if viewName == ViewName.SurvivalMapResultView then
		self:closeThis()
	end
end

return SurvivalMapResultPanelView
