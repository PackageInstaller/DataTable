-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortTabView.lua

module("logic.extensions.season.view.SeasonPassPortTabView", package.seeall)

local SeasonPassPortTabView = class("SeasonPassPortTabView", ViewComponent)

SeasonPassPortTabView.TabType = {
	Energy = 2,
	Passport = 1
}

function SeasonPassPortTabView:ctor()
	SeasonPassPortTabView.super.ctor(self)

	self._selectTab = SeasonPassPortTabView.TabType.Passport
end

function SeasonPassPortTabView:unbindEvents()
	SeasonPassPortTabView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnPassport:RemoveClickListener()
	self._btnEnergy:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function SeasonPassPortTabView:bindEvents()
	SeasonPassPortTabView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnPassport:AddClickListener(self._onClickPassport, self)
	self._btnEnergy:AddClickListener(self._onClickEnergy, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function SeasonPassPortTabView:buildUI()
	SeasonPassPortTabView.super.buildUI(self)

	self._viewBgGo = self:getGo("bg")
	self._container = self:getGo("container")
	self._btnClose = self:getBtn("btnClose")
	self._btnPassport = self:getBtn("btnPassport")
	self._btnEnergy = self:getBtn("btnEnergy")
	self._btnTip = self:getBtn("btnTip")
	self._tabPassportRP = self:getGo("btnPassport/redpoint")
	self._tabEnergyRP = self:getGo("btnEnergy/redpoint")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time/txt")
	self._changePassportTab = self._btnPassport.gameObject:GetComponent(typeof(UIChangeGroup))
	self._changeEnergyTab = self._btnEnergy.gameObject:GetComponent(typeof(UIChangeGroup))
end

function SeasonPassPortTabView:onExit()
	SeasonPassPortTabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPassPortUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPassPortEnergyUpdate, self._refreshView, self)

	self._model = nil
end

function SeasonPassPortTabView:onEnter()
	SeasonPassPortTabView.super.onEnter(self)

	self._model = SeasonPassPortModel.instance

	local params = self._viewPresentor:getOpenParam()

	if params and params[1] then
		self._selectTab = params[1]
	end

	if self._selectTab == 1 then
		self:_onClickPassport()
	else
		self:_onClickEnergy()
	end

	self._seasonId = SeasonModel.instance:getSeasonId()

	self:_setMainViewData()
	GlobalDispatcher:addListener(GlobalNotify.SeasonPassPortUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonPassPortEnergyUpdate, self._refreshView, self)
	SeasonModeWarOrderController.instance:sendRequestSeasonInfo()
	SeasonModeWarOrderController.instance:sendRequestSeasonTaskInfo()
end

function SeasonPassPortTabView:_refreshView()
	self:_refreshRedDot()
end

function SeasonPassPortTabView:_setMainViewData()
	local data = self._model:getPassMainViewData(self._seasonId)

	self._txtTime.text = data.timeTxt
end

function SeasonPassPortTabView:_changeTab(tabType)
	self._changePassportTab:SetState(tabType == SeasonPassPortTabView.TabType.Passport and 1 or 0)
	self._changeEnergyTab:SetState(tabType == SeasonPassPortTabView.TabType.Energy and 1 or 0)
end

function SeasonPassPortTabView:_refreshRedDot()
	local passportRedDot = self._model:canFindEnergy() or self._model:canReceiveFinalReward() or self._model:canReceiveOneKey()
	local energyRedDot = self._model:canReceiveTask()

	goutil.setActive(self._tabPassportRP, passportRedDot)
	goutil.setActive(self._tabEnergyRP, energyRedDot)
end

function SeasonPassPortTabView:_onClickPassport()
	self._selectTab = SeasonPassPortTabView.TabType.Passport

	self:_onClickViewTab(ViewName.SeasonPassPortView)
	self:_changeTab(SeasonPassPortTabView.TabType.Passport)
end

function SeasonPassPortTabView:_onClickEnergy()
	self._selectTab = SeasonPassPortTabView.TabType.Energy

	self:_onClickViewTab(ViewName.SeasonPassPortEnergyView)
	self:_changeTab(SeasonPassPortTabView.TabType.Energy)
end

function SeasonPassPortTabView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "seasonpassport_rule")
end

function SeasonPassPortTabView:_onClickViewTab(viewname, data)
	self:showTabAt(self._container, viewname, data)
end

function SeasonPassPortTabView:_onClickClose()
	self:close()
end

return SeasonPassPortTabView
