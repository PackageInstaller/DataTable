-- chunkname: @IQIGame\\UI\\RestaurantOperationMainUI.lua

local RestaurantOperationMainUI = {
	isPlaying = false,
	haveNewPlot = false,
	ChangeSceneEffectPlayId = 0
}

RestaurantOperationMainUI = Base:Extend("RestaurantOperationMainUI", "IQIGame.Onigao.UI.RestaurantOperationMainUI", RestaurantOperationMainUI)

require("IQIGame.UIExternalApi.RestaurantOperationMainUIApi")

local ROMainMsgView = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationMain.ROMainMsgView")

function RestaurantOperationMainUI:OnInit()
	function self.DelegateOnCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnBtnGetIncome()
		self:OnClickBtnGetIncome()
	end

	function self.DelegateOnBtnPersonnelAllotment()
		self:OnClickBtnPersonnelAllotment()
	end

	function self.DelegateOnBtnOperate()
		self:OnClickBtnOperate()
	end

	function self.DelegateOnBtnOut()
		self:OnClickBtnOut()
	end

	function self.DelegateOnBtnRank()
		self:OnClickBtnRank()
	end

	function self.DelegateOnBtnInn()
		self:OnClickBtnInn()
	end

	function self.DelegateBtnEvent()
		self:OnBtnEvent()
	end

	function self.DelegateReceiveIncome()
		self:OnReceiveIncome()
	end

	function self.DelegatePlotEnd()
		self:RefreshPlotEvent()
	end

	function self.DelegateUpdateEvent()
		self:RefreshRedPoint()
	end

	function self.DelegateBuildLevelUp()
		self:OnBuildLevelUp()
	end

	self.roMainMsgView = ROMainMsgView.New(self.RestaurantMsg)

	self.BtnOperate:SetActive(false)
end

function RestaurantOperationMainUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationMainUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationMainUI:GetBGM(userData)
	return nil
end

function RestaurantOperationMainUI:OnOpen(userData)
	self:StopEffect()

	local isPlayEff = userData.PlayEffect

	if isPlayEff then
		self:PlayEffect(true, function()
			self:UpdateView()
		end)
	else
		self:UpdateView()
	end

	RestaurantOperationModule.ROScene:ShowScene(true)
end

function RestaurantOperationMainUI:OnClose(userData)
	self:StopEffect()
end

function RestaurantOperationMainUI:OnAddListeners()
	self.BtnInn:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnInn)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnRank)
	self.BtnOut:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnOut)
	self.BtnOperate:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnOperate)
	self.BtnPersonnelAllotment:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnPersonnelAllotment)
	self.BtnGetIncome:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnGetIncome)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtn)
	self.BtnEvent:GetComponent("Button").onClick:AddListener(self.DelegateBtnEvent)
	EventDispatcher.AddEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.AddEventListener(EventID.ROPlotEndEvent, self.DelegatePlotEnd)
	EventDispatcher.AddEventListener(EventID.ROUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.AddEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
end

function RestaurantOperationMainUI:OnRemoveListeners()
	self.BtnInn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnInn)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnRank)
	self.BtnOut:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnOut)
	self.BtnOperate:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnOperate)
	self.BtnPersonnelAllotment:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnPersonnelAllotment)
	self.BtnGetIncome:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnGetIncome)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtn)
	self.BtnEvent:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEvent)
	EventDispatcher.RemoveEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.RemoveEventListener(EventID.ROPlotEndEvent, self.DelegatePlotEnd)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
end

function RestaurantOperationMainUI:OnPause()
	return
end

function RestaurantOperationMainUI:OnResume()
	return
end

function RestaurantOperationMainUI:OnCover()
	return
end

function RestaurantOperationMainUI:OnReveal()
	return
end

function RestaurantOperationMainUI:OnRefocus(userData)
	return
end

function RestaurantOperationMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.roMainMsgView:Dispose()
end

function RestaurantOperationMainUI:OnUpdateItem()
	return
end

function RestaurantOperationMainUI:OnReceiveIncome()
	self:UpdateView()
end

function RestaurantOperationMainUI:OnBuildLevelUp()
	self:UpdateView()
end

function RestaurantOperationMainUI:RefreshPlotEvent()
	self.haveNewPlot, self.nextPloEvent = RestaurantOperationModule.CheckEventPlot()

	self.BtnEvent:SetActive(self.haveNewPlot)
end

function RestaurantOperationMainUI:UpdateView()
	local isShow, num, maxNum = RestaurantOperationModule.CanGetReceiveIncome()

	self.BtnGetIncome:SetActive(num > 0)
	self:RefreshPlotEvent()
	self.roMainMsgView:UpdateView()
	self:RefreshRedPoint()
end

function RestaurantOperationMainUI:StopEffect()
	self.EffectOpen:SetActive(false)
	self.EffectClose:SetActive(false)

	if self.changeTimer then
		self.changeTimer:Stop()

		self.changeTimer = nil
	end
end

function RestaurantOperationMainUI:PlayEffect(isOpen, callBack)
	self:StopEffect()

	self.isPlaying = true

	if isOpen then
		self.EffectOpen:SetActive(true)
	else
		self.EffectClose:SetActive(true)
	end

	self.changeTimer = Timer.New(function()
		if callBack then
			callBack()
		end

		self.isPlaying = false
	end, 2)

	self.changeTimer:Start()
end

function RestaurantOperationMainUI:OnClickBtnInn()
	if self.isPlaying then
		return
	end

	UIModule.Open(Constant.UIControllerName.RestaurantOperationDetailUI, Constant.UILayer.UI)
end

function RestaurantOperationMainUI:OnClickBtnRank()
	if self.isPlaying then
		return
	end

	UIModule.Open(Constant.UIControllerName.RestaurantOperationRankUI, Constant.UILayer.UI)
end

function RestaurantOperationMainUI:OnClickBtnOut()
	if self.isPlaying then
		return
	end

	self:PlayEffect(false, function()
		UIModule.CloseSelf(self)
		RestaurantOperationModule.ChangeSceneArea(RestaurantOperationConstant.SceneType.Scene_Outside)
	end)
end

function RestaurantOperationMainUI:OnClickBtnOperate()
	return
end

function RestaurantOperationMainUI:OnClickBtnPersonnelAllotment()
	if self.isPlaying then
		return
	end

	UIModule.Open(Constant.UIControllerName.RestaurantOperationPlayerUI, Constant.UILayer.UI)
end

function RestaurantOperationMainUI:OnClickBtnGetIncome()
	if self.isPlaying then
		return
	end

	RestaurantOperationModule.ReceiveIncome()
end

function RestaurantOperationMainUI:OnBtnEvent()
	if self.isPlaying then
		return
	end

	if self.nextPloEvent then
		RestaurantOperationModule.OpenDialog(self.nextPloEvent.cid)
	end
end

function RestaurantOperationMainUI:RefreshRedPoint()
	local result = RestaurantOperationModule.CheckEventRed()

	self.RedPoint:SetActive(result)
end

function RestaurantOperationMainUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	RestaurantOperationModule.ExitRestaurantScene()
end

return RestaurantOperationMainUI
