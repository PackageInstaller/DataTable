-- chunkname: @IQIGame\\UI\\RoleInfoDetailsUI.lua

local RoleInfoDetailsUI = {
	subPanel = {},
	tabs = {}
}

RoleInfoDetailsUI = Base:Extend("RoleInfoDetailsUI", "IQIGame.Onigao.UI.RoleInfoDetailsUI", RoleInfoDetailsUI)

local RoleInfoDetailsPanelName = require("IQIGame.UI.RoleInfoDetails.RoleInfoDetailsPanelName")
local RoleDetailsView = require("IQIGame.UI.RoleInfoDetails.RoleDetailsView")
local RoleAudioView = require("IQIGame.UI.RoleInfoDetails.RoleAudioView")
local RoleDeedsView = require("IQIGame.UI.RoleInfoDetails.RoleDeedsView")
local RoleBaseInfoView = require("IQIGame.UI.RoleInfoDetails.RoleBaseInfoView")
local RoleStageView = require("IQIGame.UI.RoleInfoDetails.RoleStageView")

function RoleInfoDetailsUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function RoleInfoDetailsUI:InitComponent()
	self.baseInfoPanel = RoleBaseInfoView.New(self.BaseInfoPanel)
	self.subPanel[RoleInfoDetailsPanelName.DetailsPanel] = RoleDetailsView.New(self.DetailsPanel)
	self.subPanel[RoleInfoDetailsPanelName.AudioPanel] = RoleAudioView.New(self.AudioPanel)
	self.subPanel[RoleInfoDetailsPanelName.DeedsPanel] = RoleDeedsView.New(self.DeedsPanel)
	self.subPanel[RoleInfoDetailsPanelName.StagePanel] = RoleStageView.New(self.StagePanel)

	local toggleLen = self.MainTabs.transform.childCount

	for i = 1, toggleLen do
		self.tabs[i] = self.MainTabs.transform:GetChild(i - 1)
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function RoleInfoDetailsUI:InitDelegate()
	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.heroFavorRefreshEvent()
		self:HeroFavorRefreshEvent()
	end
end

function RoleInfoDetailsUI:GetPreloadAssetPaths()
	return nil
end

function RoleInfoDetailsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleInfoDetailsUI:IsManualShowOnOpen(userData)
	return false
end

function RoleInfoDetailsUI:GetBGM(userData)
	return nil
end

function RoleInfoDetailsUI:OnOpen(userData)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())

	self.heroCid = userData.heroCid

	self.baseInfoPanel:SetData(self.heroCid)
	self:ToggleTo(RoleInfoDetailsPanelName.DetailsPanel)

	self.tabs[RoleInfoDetailsPanelName.DetailsPanel]:GetComponent("Toggle").isOn = true

	if userData and userData.AutoSelectFavorStage then
		self:ToggleTo(RoleInfoDetailsPanelName.StagePanel)

		self.tabs[RoleInfoDetailsPanelName.StagePanel]:GetComponent("Toggle").isOn = true
	end
end

function RoleInfoDetailsUI:OnClose(userData)
	return
end

function RoleInfoDetailsUI:OnAddListeners()
	local toggle

	for i = 1, #self.tabs do
		toggle = self.tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.HeroFavorRefreshEvent, self.heroFavorRefreshEvent)
end

function RoleInfoDetailsUI:OnRemoveListeners()
	local toggle

	for i = 1, #self.tabs do
		toggle = self.tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.HeroFavorRefreshEvent, self.heroFavorRefreshEvent)
end

function RoleInfoDetailsUI:OnPause()
	return
end

function RoleInfoDetailsUI:OnResume()
	return
end

function RoleInfoDetailsUI:OnCover()
	return
end

function RoleInfoDetailsUI:OnReveal()
	return
end

function RoleInfoDetailsUI:OnRefocus(userData)
	return
end

function RoleInfoDetailsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleInfoDetailsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleInfoDetailsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleInfoDetailsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleInfoDetailsUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.baseInfoPanel:Dispose()

	local len = #self.subPanel

	for i = 1, len do
		self.subPanel[i]:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function RoleInfoDetailsUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.tabs do
			if self.tabs[i].gameObject == currentTarget then
				self:ToggleTo(i)

				return
			end
		end
	end
end

function RoleInfoDetailsUI:ToggleTo(panelIndex)
	for i = 1, #self.subPanel do
		if panelIndex == i then
			self.subPanel[i]:Show()
			self.subPanel[i]:SetData(self.heroCid)

			self.currentToggleIndex = i
		else
			self.subPanel[i]:Hide()
		end
	end
end

function RoleInfoDetailsUI:HeroFavorRefreshEvent()
	if self.currentToggleIndex then
		self.subPanel[self.currentToggleIndex]:SetData(self.heroCid)
	end
end

return RoleInfoDetailsUI
