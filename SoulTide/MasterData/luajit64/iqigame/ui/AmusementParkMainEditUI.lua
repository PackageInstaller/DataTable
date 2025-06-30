-- chunkname: @IQIGame\\UI\\AmusementParkMainEditUI.lua

local AmusementParkMainEditUI = {
	isShowUI = true
}

AmusementParkMainEditUI = Base:Extend("AmusementParkMainEditUI", "IQIGame.Onigao.UI.AmusementParkMainEditUI", AmusementParkMainEditUI)

local AmusementParkMainEditMsgView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainEdit.AmusementParkMainEditMsgView")

function AmusementParkMainEditUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnShowUI()
		self:OnClickBtnShowUI()
	end

	function self.DelegateReceiveIncome()
		self:OnReceiveIncome()
	end

	function self.DelegateBuildLevelUp()
		self:OnBuildLevelUp()
	end

	function self.DelegateBtnSave()
		self:OnBtnSave()
	end

	function self.DelegateBtnCancel()
		self:OnBtnCancel()
	end

	function self.DelegateUpdateInfo()
		self:OnUpdateInfo()
	end

	self.amusementParkEditMsgView = AmusementParkMainEditMsgView.New(self.AmusementEditMsg)

	function self.amusementParkEditMsgView.hideUICallBack()
		self:HideUI()
	end
end

function AmusementParkMainEditUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkMainEditUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkMainEditUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkMainEditUI:GetBGM(userData)
	return nil
end

function AmusementParkMainEditUI:OnOpen(userData)
	self.amusementParkEditMsgView:RecordData()
	self:RefreshView()

	AmusementParkModule.AmusementParkScene.IsEdit = true

	EventDispatcher.Dispatch(EventID.APEditStateEvent, true)
end

function AmusementParkMainEditUI:OnClose(userData)
	AmusementParkModule.AmusementParkScene.IsEdit = false

	EventDispatcher.Dispatch(EventID.APEditStateEvent, false)
end

function AmusementParkMainEditUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnShowUI:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnShowUI)
	self.BtnSave:GetComponent("Button").onClick:AddListener(self.DelegateBtnSave)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateBtnCancel)
	EventDispatcher.AddEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.AddEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.AddEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
end

function AmusementParkMainEditUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnShowUI:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnShowUI)
	self.BtnSave:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSave)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnCancel)
	EventDispatcher.RemoveEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.RemoveEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.RemoveEventListener(EventID.APUpdateInfoEvent, self.DelegateUpdateInfo)
end

function AmusementParkMainEditUI:OnPause()
	return
end

function AmusementParkMainEditUI:OnResume()
	return
end

function AmusementParkMainEditUI:OnCover()
	return
end

function AmusementParkMainEditUI:OnReveal()
	return
end

function AmusementParkMainEditUI:OnRefocus(userData)
	return
end

function AmusementParkMainEditUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkMainEditUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkMainEditUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkMainEditUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkMainEditUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.amusementParkEditMsgView:Dispose()

	self.amusementParkEditMsgView = nil
end

function AmusementParkMainEditUI:OnClickCloseBtn()
	AmusementParkModule.GetAmusementParkInfoTemporarily()
end

function AmusementParkMainEditUI:HideUI()
	self.isShowUI = false

	self:RefreshView()
end

function AmusementParkMainEditUI:OnClickBtnShowUI()
	self.isShowUI = true

	self:RefreshView()
end

function AmusementParkMainEditUI:OnBuildLevelUp()
	self:RefreshView()
end

function AmusementParkMainEditUI:OnReceiveIncome()
	self:RefreshView()
end

function AmusementParkMainEditUI:OnUpdateInfo()
	self:RefreshView()
end

function AmusementParkMainEditUI:OnBtnSave()
	AmusementParkModule.ConfirmChanges()
	self:OnClickCloseBtn()
end

function AmusementParkMainEditUI:OnBtnCancel()
	AmusementParkModule.GetAmusementParkInfoTemporarily()
end

function AmusementParkMainEditUI:RefreshView()
	self.Panel1:SetActive(self.isShowUI)
	self.Panel2:SetActive(self.isShowUI)
	self.BtnShowUI:SetActive(not self.isShowUI)
	self.amusementParkEditMsgView:UpdateView()
end

return AmusementParkMainEditUI
