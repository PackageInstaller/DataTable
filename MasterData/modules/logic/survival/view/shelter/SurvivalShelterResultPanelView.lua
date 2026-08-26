-- chunkname: @modules/logic/survival/view/shelter/SurvivalShelterResultPanelView.lua

module("modules.logic.survival.view.shelter.SurvivalShelterResultPanelView", package.seeall)

local SurvivalShelterResultPanelView = class("SurvivalShelterResultPanelView", BaseView)

function SurvivalShelterResultPanelView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_failed")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
end

function SurvivalShelterResultPanelView:addEvents()
	self._btnclose:AddClickListener(self._onClickClose, self)
end

function SurvivalShelterResultPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
end

function SurvivalShelterResultPanelView:onOpen()
	local isWin = self.viewParam.isWin

	gohelper.setActive(self._gosuccess, isWin)
	gohelper.setActive(self._gofail, not isWin)

	if isWin then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_1)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_fail)
	end
end

function SurvivalShelterResultPanelView:onClickModalMask()
	self:_onClickClose()
end

function SurvivalShelterResultPanelView:_onClickClose()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onViewOpen, self)
	SurvivalController.instance:enterSurvivalSettle()
	self:closeThis()
end

function SurvivalShelterResultPanelView:_onViewOpen(viewName)
	if viewName == ViewName.SurvivalCeremonyClosingView then
		self:closeThis()
	end
end

return SurvivalShelterResultPanelView
