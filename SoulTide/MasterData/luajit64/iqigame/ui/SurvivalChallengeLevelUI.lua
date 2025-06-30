-- chunkname: @IQIGame\\UI\\SurvivalChallengeLevelUI.lua

local SurvivalChallengeLevelUIController = require("IQIGame.UI._DailyActivityUI.SurvivalChallenge.SurvivalChallengeLevelUIController")
local SurvivalChallengeLevelUI = {}

SurvivalChallengeLevelUI = Base:Extend("SurvivalChallengeLevelUI", "IQIGame.Onigao.UI.SurvivalChallengeLevelUI", SurvivalChallengeLevelUI)

function SurvivalChallengeLevelUI:GetViewPath()
	local cfgControlData = CfgSurvivalChallengeControlTable[SurvivalModule.GlobalCid]

	return cfgControlData.SurvivalChallengeLevel
end

function SurvivalChallengeLevelUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function SurvivalChallengeLevelUI:GetPreloadAssetPaths()
	self.Controller = SurvivalChallengeLevelUIController.New(self.UIController)

	local paths = {}

	table.insert(paths, UIGlobalApi.GetUIPrefab(self:GetViewPath()))

	local subPaths = self.Controller:GetPreloadAssetPaths()

	if subPaths ~= nil then
		for i = 1, #subPaths do
			table.insert(paths, subPaths[i])
		end
	end

	return paths
end

function SurvivalChallengeLevelUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function SurvivalChallengeLevelUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function SurvivalChallengeLevelUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function SurvivalChallengeLevelUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function SurvivalChallengeLevelUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function SurvivalChallengeLevelUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function SurvivalChallengeLevelUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function SurvivalChallengeLevelUI:OnPause()
	self.Controller:OnPause()
end

function SurvivalChallengeLevelUI:OnResume()
	self.Controller:OnResume()
end

function SurvivalChallengeLevelUI:OnCover()
	self.Controller:OnCover()
end

function SurvivalChallengeLevelUI:OnReveal()
	self.Controller:OnReveal()
end

function SurvivalChallengeLevelUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function SurvivalChallengeLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function SurvivalChallengeLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function SurvivalChallengeLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function SurvivalChallengeLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function SurvivalChallengeLevelUI:OnDestroy()
	self.Controller:OnDestroy()
end

return SurvivalChallengeLevelUI
