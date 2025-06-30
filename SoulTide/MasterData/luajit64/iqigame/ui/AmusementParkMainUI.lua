-- chunkname: @IQIGame\\UI\\AmusementParkMainUI.lua

local AmusementParkMainUI = {
	isShowUI = true,
	roTicketCellPool = {}
}

AmusementParkMainUI = Base:Extend("AmusementParkMainUI", "IQIGame.Onigao.UI.AmusementParkMainUI", AmusementParkMainUI)

require("IQIGame.UIExternalApi.AmusementParkMainUIApi")

local AmusementParkMainMsgView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMain.AmusementParkMainMsgView")
local ROTicketCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.ROTicketCell")

function AmusementParkMainUI:OnInit()
	function self.DelegateOnClickBtnRank()
		self:OnClickBtnRank()
	end

	function self.DelegateOnClickBtnOut()
		self:OnClickBtnOut()
	end

	function self.DelegateOnClickBtnPersonnelAllotment()
		self:OnClickBtnPersonnelAllotment()
	end

	function self.DelegateOnClickBtnGetIncome()
		self:OnClickBtnGetIncome()
	end

	function self.DelegateOnClickBtnOperate()
		self:OnClickBtnOperate()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnInn()
		self:OnClickBtnInn()
	end

	function self.DelegateOnClickBtnEvent()
		self:OnClickBtnEvent()
	end

	function self.DelegateOnClickBtnShowUI()
		self:OnClickBtnShowUI()
	end

	function self.DelegateEditStateEvent(isEdit)
		self:OnEditStateEvent(isEdit)
	end

	function self.DelegatePlotEnd()
		self:RefreshPlotEvent()
	end

	function self.DelegateUpdateEvent()
		self:RefreshRedPoint()
	end

	function self.DelegateReceiveIncome()
		self:OnReceiveIncome()
	end

	function self.DelegateBuildLevelUp()
		self:OnBuildLevelUp()
	end

	function self.DelegateUpdateInfo()
		self:OnUpdateInfo()
	end

	self.amusementParkMsgView = AmusementParkMainMsgView.New(self.AmusementMsg)

	function self.amusementParkMsgView.hideUICallBack()
		self:HideUI()
	end

	self.roTicketCellPool = {}

	local cfgControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]
	local roTicketCell1 = ROTicketCell.New(self.TicketGo1)

	roTicketCell1:RefreshData(cfgControlData.MoneyId)

	self.roTicketCellPool[1] = roTicketCell1

	local roTicketCell2 = ROTicketCell.New(self.TicketGo2)

	roTicketCell2:RefreshData(cfgControlData.ExpId)

	self.roTicketCellPool[2] = roTicketCell2
end

function AmusementParkMainUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkMainUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkMainUI:GetBGM(userData)
	return nil
end

function AmusementParkMainUI:OnOpen(userData)
	self:RefreshView()
	AmusementParkModule.AmusementParkScene:ShowScene(true)
	AmusementParkModule.CheckResumeDialog()
end

function AmusementParkMainUI:OnClose(userData)
	return
end

function AmusementParkMainUI:OnAddListeners()
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRank)
	self.BtnOut:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnOut)
	self.BtnPersonnelAllotment:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnPersonnelAllotment)
	self.BtnGetIncome:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGetIncome)
	self.BtnOperate:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnOperate)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnInn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnInn)
	self.BtnEvent:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnEvent)
	self.BtnShowUI:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnShowUI)
	EventDispatcher.AddEventListener(EventID.APEditStateEvent, self.DelegateEditStateEvent)
	EventDispatcher.AddEventListener(EventID.APPlotEndEvent, self.DelegatePlotEnd)
	EventDispatcher.AddEventListener(EventID.APUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.AddEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.AddEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
end

function AmusementParkMainUI:OnRemoveListeners()
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRank)
	self.BtnOut:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnOut)
	self.BtnPersonnelAllotment:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnPersonnelAllotment)
	self.BtnGetIncome:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGetIncome)
	self.BtnOperate:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnOperate)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnInn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnInn)
	self.BtnEvent:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnEvent)
	self.BtnShowUI:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnShowUI)
	EventDispatcher.RemoveEventListener(EventID.APEditStateEvent, self.DelegateEditStateEvent)
	EventDispatcher.RemoveEventListener(EventID.APPlotEndEvent, self.DelegatePlotEnd)
	EventDispatcher.RemoveEventListener(EventID.APUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.RemoveEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
end

function AmusementParkMainUI:OnPause()
	return
end

function AmusementParkMainUI:OnResume()
	return
end

function AmusementParkMainUI:OnCover()
	return
end

function AmusementParkMainUI:OnReveal()
	return
end

function AmusementParkMainUI:OnRefocus(userData)
	return
end

function AmusementParkMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.amusementParkMsgView:Dispose()

	self.amusementParkMsgView = nil

	for i, v in pairs(self.roTicketCellPool) do
		v:Dispose()
	end
end

function AmusementParkMainUI:HideUI()
	self.isShowUI = false

	self:RefreshView()
end

function AmusementParkMainUI:OnEditStateEvent(isEdit)
	self.UIController.gameObject:SetActive(not isEdit)
end

function AmusementParkMainUI:OnBuildLevelUp()
	self:RefreshView()
end

function AmusementParkMainUI:OnReceiveIncome()
	self:RefreshIncome()
end

function AmusementParkMainUI:OnUpdateInfo()
	self:RefreshView()
end

function AmusementParkMainUI:RefreshIncome()
	local isShow, num, maxNum = AmusementParkModule.CanGetReceiveIncome()

	self.BtnGetIncome:SetActive(num > 0)
end

function AmusementParkMainUI:RefreshView()
	self.Panel1:SetActive(self.isShowUI)
	self.Panel2:SetActive(self.isShowUI)
	self.BtnShowUI:SetActive(not self.isShowUI)
	self.amusementParkMsgView:UpdateView()
	self:RefreshPlotEvent()
	self:RefreshRedPoint()
	self:RefreshIncome()
end

function AmusementParkMainUI:RefreshPlotEvent()
	self.haveNewPlot, self.nextPloEvent = AmusementParkModule.CheckEventPlot()

	self.BtnEvent:SetActive(self.haveNewPlot)
end

function AmusementParkMainUI:RefreshRedPoint()
	local result = AmusementParkModule.CheckEventRed()

	self.RedPoint:SetActive(result)
end

function AmusementParkMainUI:OnClickBtnRank()
	UIModule.Open(Constant.UIControllerName.AmusementParkRankUI, Constant.UILayer.UI)
end

function AmusementParkMainUI:OnClickBtnOut()
	AmusementParkModule.GetLittleGameInfo()
	UIModule.Open(Constant.UIControllerName.AmusementParkOverViewUI, Constant.UILayer.UI)
end

function AmusementParkMainUI:OnClickBtnPersonnelAllotment()
	UIModule.Open(Constant.UIControllerName.AmusementParkPlayerUI, Constant.UILayer.UI, {
		Index = 1
	})
end

function AmusementParkMainUI:OnClickBtnGetIncome()
	AmusementParkModule.ReceiveIncome()
end

function AmusementParkMainUI:OnClickBtnOperate()
	UIModule.Open(Constant.UIControllerName.AmusementParkMainEditUI, Constant.UILayer.UI)
end

function AmusementParkMainUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	AmusementParkModule.ExitAmusementParkScene()
end

function AmusementParkMainUI:OnClickBtnInn()
	UIModule.Open(Constant.UIControllerName.AmusementParkDetailUI, Constant.UILayer.UI)
end

function AmusementParkMainUI:OnClickBtnEvent()
	self.haveNewPlot, self.nextPloEvent = AmusementParkModule.CheckEventPlot()

	if self.nextPloEvent then
		AmusementParkModule.OpenDialog(self.nextPloEvent.cid)
	end

	log("点击触发剧情")
end

function AmusementParkMainUI:OnClickBtnShowUI()
	self.isShowUI = true

	self:RefreshView()
end

return AmusementParkMainUI
