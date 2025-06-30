-- chunkname: @IQIGame\\UI\\DramaChallengeLotteryMachineUI.lua

local DramaChallengeLotteryMachineUIController = require("IQIGame.UI.DramChallengeLotteryMachine.DramaChallengeLotteryMachineUIController")
local DramaChallengeLotteryMachineUI = {}

DramaChallengeLotteryMachineUI = Base:Extend("DramaChallengeLotteryMachineUI", "IQIGame.Onigao.UI.DramaChallengeLotteryMachineUI", DramaChallengeLotteryMachineUI)

function DramaChallengeLotteryMachineUI:GetViewPath()
	local PlotChallengeTable = PlotChallengeModule.GetPlotChallengeTable()

	return PlotChallengeTable.LotteryMachinePrefab
end

function DramaChallengeLotteryMachineUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetDailyDupExploreHallBGPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DramaChallengeLotteryMachineUI:GetPreloadAssetPaths()
	self.Controller = DramaChallengeLotteryMachineUIController.New(self.UIController)

	local paths = {}

	table.insert(paths, UIGlobalApi.GetDailyDupExploreHallBGPrefab(self:GetViewPath()))

	local subPaths = self.Controller:GetPreloadAssetPaths()

	if subPaths ~= nil then
		for i = 1, #subPaths do
			table.insert(paths, subPaths[i])
		end
	end

	return paths
end

function DramaChallengeLotteryMachineUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DramaChallengeLotteryMachineUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DramaChallengeLotteryMachineUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DramaChallengeLotteryMachineUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DramaChallengeLotteryMachineUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DramaChallengeLotteryMachineUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DramaChallengeLotteryMachineUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DramaChallengeLotteryMachineUI:OnPause()
	self.Controller:OnPause()
end

function DramaChallengeLotteryMachineUI:OnResume()
	self.Controller:OnResume()
end

function DramaChallengeLotteryMachineUI:OnCover()
	self.Controller:OnCover()
end

function DramaChallengeLotteryMachineUI:OnReveal()
	self.Controller:OnReveal()
end

function DramaChallengeLotteryMachineUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DramaChallengeLotteryMachineUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DramaChallengeLotteryMachineUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DramaChallengeLotteryMachineUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DramaChallengeLotteryMachineUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DramaChallengeLotteryMachineUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DramaChallengeLotteryMachineUI
