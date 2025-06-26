-- chunkname: @IQIGame\\UI\\GachaPoolPanelUI.lua

local GachaPoolPanelUI = {
	rewardCells = {}
}

GachaPoolPanelUI = Base:Extend("GachaPoolPanelUI", "IQIGame.Onigao.UI.GachaPoolPanelUI", GachaPoolPanelUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ActivityGachaItemCell = require("IQIGame.UI.Activity.GachaPool.ActivityGachaItemCell")

function GachaPoolPanelUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.rewardCellPool = UIObjectPool.New(10, function()
		return ActivityGachaItemCell.New(UnityEngine.Object.Instantiate(self.ItemCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function GachaPoolPanelUI:GetPreloadAssetPaths()
	return nil
end

function GachaPoolPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GachaPoolPanelUI:IsManualShowOnOpen(userData)
	return false
end

function GachaPoolPanelUI:GetBGM(userData)
	return nil
end

function GachaPoolPanelUI:OnOpen(userData)
	self.cfgGachaPoolGlobalData = userData

	self:UpdateView()
end

function GachaPoolPanelUI:OnClose(userData)
	return
end

function GachaPoolPanelUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function GachaPoolPanelUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function GachaPoolPanelUI:OnPause()
	return
end

function GachaPoolPanelUI:OnResume()
	return
end

function GachaPoolPanelUI:OnCover()
	return
end

function GachaPoolPanelUI:OnReveal()
	return
end

function GachaPoolPanelUI:OnRefocus(userData)
	return
end

function GachaPoolPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GachaPoolPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GachaPoolPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GachaPoolPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GachaPoolPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCells) do
		self.rewardCellPool:Release(v)
	end

	self.rewardCells = {}

	self.rewardCellPool:Dispose()
end

function GachaPoolPanelUI:UpdateView()
	local rewards = self.cfgGachaPoolGlobalData.Rewards
	local rewardMap = {}
	local maxRare = 0

	for i = 1, #rewards do
		local cfgGachaPoolRewardData = CfgGachaPoolRewardTable[rewards[i]]

		rewardMap[cfgGachaPoolRewardData.Rare] = rewardMap[cfgGachaPoolRewardData.Rare] or {}

		table.insert(rewardMap[cfgGachaPoolRewardData.Rare], cfgGachaPoolRewardData)

		maxRare = math.max(maxRare, cfgGachaPoolRewardData.Rare)
	end

	for i, v in pairs(self.rewardCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.rewardCellPool:Release(v)
	end

	self.rewardCells = {}

	for i = 1, maxRare do
		local rewardsOfThisRare = rewardMap[i]

		if rewardsOfThisRare ~= nil then
			for j = 1, #rewardsOfThisRare do
				local cfgData = rewardsOfThisRare[j]
				local cell = self.rewardCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self["RewardGridLv" .. i].transform, false)
				cell:SetRefreshShowData(cfgData)
				table.insert(self.rewardCells, cell)
			end
		end
	end
end

function GachaPoolPanelUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return GachaPoolPanelUI
