-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_AssistView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_AssistView", package.seeall)

local V3a9_BossRush_AssistView = class("V3a9_BossRush_AssistView", PickAssistView)

function V3a9_BossRush_AssistView:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btndetail:AddClickListener(self._onHeroDetailClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self.addEventCb(self, PickAssistController.instance, PickAssistEvent.BeforeRefreshAssistList, self.onBeforeRefreshAssistList, self)
	self.addEventCb(self, PickAssistController.instance, PickAssistEvent.SetCareer, self.refreshIsEmpty, self)
	self.addEventCb(self, PickAssistController.instance, PickAssistEvent.RefreshSelectAssistHero, self._onRefreshSelectAssistHero, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
end

function V3a9_BossRush_AssistView:removeEvents()
	self._btnrefresh:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self.removeEventCb(self, PickAssistController.instance, PickAssistEvent.BeforeRefreshAssistList, self.onBeforeRefreshAssistList, self)
	self.removeEventCb(self, PickAssistController.instance, PickAssistEvent.SetCareer, self.refreshIsEmpty, self)
	self.removeEventCb(self, PickAssistController.instance, PickAssistEvent.RefreshSelectAssistHero, self._onRefreshSelectAssistHero, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
end

function V3a9_BossRush_AssistView:_btnclassifyOnClick()
	local param = {
		filterType = CharacterEnum.FilterType.HeroGroup,
		EnterType = V3a9BossRushEnum.SearchFilterType.Asssit
	}

	ViewMgr.instance:openView(ViewName.V3a9_BossRush_SearchFilterView, param)
end

function V3a9_BossRush_AssistView:_btnconfirmOnClick()
	local selectedMO = PickAssistListModel.instance:getSelectedMO()

	V3a9_BossRushModel.instance:setAssistMo(selectedMO)
	V3a9_BossRush_AssistView.super._btnconfirmOnClick(self)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onUseAssistHero)
end

function V3a9_BossRush_AssistView:_onRefreshSelectAssistHero()
	self:refreshBtnDetail()

	local selectedMO = PickAssistListModel.instance:getSelectedMO()

	V3a9_BossRushExpandBondModel.instance:refreshAssestExpandBondGroup(selectedMO)
	self._expandBondsExpandPanel:refreshExpandBonds()
end

function V3a9_BossRush_AssistView:_editableInitView()
	V3a9_BossRush_AssistView.super._editableInitView(self)

	self._goBonds = gohelper.findChild(self.viewGO, "#go_Bonds")
	self._expandBondsExpandPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._goBonds, V3a9_BossRush_ExpandBondsExpandPanel)

	local path = self.viewContainer:getSetting().otherRes[2]
	local itemRes = self.viewContainer:getRes(path)
	local tiproot = gohelper.findChild(self.viewGO, "tipRoot")

	self._expandBondsExpandPanel:setItemRes(itemRes, tiproot)
	self._expandBondsExpandPanel:setParam(11, false, true)

	self._classifyBtns = self:getUserDataTb_()
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_classify")

	for i = 1, 2 do
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
	end
end

function V3a9_BossRush_AssistView:onOpen()
	V3a9_BossRush_AssistView.super.onOpen(self)
	self:_refreshBtnIcon()
	self._expandBondsExpandPanel:onOpen()
end

function V3a9_BossRush_AssistView:_refreshBtnIcon()
	local hasFilter = CharacterSearchFilterModel.instance:hasFilter()

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
end

function V3a9_BossRush_AssistView:_onFilterList(param)
	self:_refreshBtnIcon()
	PickAssistListModel.instance:setListByCareerAndBattleTags()
end

function V3a9_BossRush_AssistView:onClose()
	V3a9_BossRush_AssistView.super.onClose(self)
	V3a9_BossRushController.instance:closeExpandBondsTipView()
end

return V3a9_BossRush_AssistView
