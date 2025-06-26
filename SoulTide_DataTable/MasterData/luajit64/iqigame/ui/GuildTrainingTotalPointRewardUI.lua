-- chunkname: @IQIGame\\UI\\GuildTrainingTotalPointRewardUI.lua

local GuildTrainingTotalPointRewardUI = {
	trainingTotalPointRewards = {},
	TrainingRankRewardCells = {},
	totalPointRewardRenderPool = {}
}

GuildTrainingTotalPointRewardUI = Base:Extend("GuildTrainingTotalPointRewardUI", "IQIGame.Onigao.UI.GuildTrainingTotalPointRewardUI", GuildTrainingTotalPointRewardUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildTrainingRankRewardCell = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingRankReward.GuildTrainingRankRewardCell")
local GuildTrainingTotalPointRewardRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingTotalPointReward.GuildTrainingTotalPointRewardRender")

function GuildTrainingTotalPointRewardUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.trainingTotalPointRewards = {}

	for i, v in pairsCfg(CfgGuildTrainingTotalPointRewardTable) do
		table.insert(self.trainingTotalPointRewards, v)
	end

	table.sort(self.trainingTotalPointRewards, function(a, b)
		return a.Sort > b.Sort
	end)
	self.RewardMould:SetActive(false)

	self.TrainingRankRewardCellPool = UIObjectPool.New(4, function()
		return GuildTrainingRankRewardCell.New(UnityEngine.Object.Instantiate(self.RewardMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function GuildTrainingTotalPointRewardUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingTotalPointRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingTotalPointRewardUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingTotalPointRewardUI:GetBGM(userData)
	return nil
end

function GuildTrainingTotalPointRewardUI:OnOpen(userData)
	self:UpdateView()
end

function GuildTrainingTotalPointRewardUI:OnClose(userData)
	return
end

function GuildTrainingTotalPointRewardUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingTotalPointRewardUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingTotalPointRewardUI:OnPause()
	return
end

function GuildTrainingTotalPointRewardUI:OnResume()
	return
end

function GuildTrainingTotalPointRewardUI:OnCover()
	return
end

function GuildTrainingTotalPointRewardUI:OnReveal()
	return
end

function GuildTrainingTotalPointRewardUI:OnRefocus(userData)
	return
end

function GuildTrainingTotalPointRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingTotalPointRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingTotalPointRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingTotalPointRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingTotalPointRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.totalPointRewardRenderPool) do
		v:Dispose()
	end

	for i = 1, #self.TrainingRankRewardCells do
		local cell = self.TrainingRankRewardCells[i]

		cell.View:SetActive(false)
		self.TrainingRankRewardCellPool:Release(cell)
	end

	self.TrainingRankRewardCells = {}

	self.TrainingRankRewardCellPool:Dispose()
end

function GuildTrainingTotalPointRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingTotalPointRewardUI:UpdateView()
	self.myGuildCfgData = nil

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.trainingTotalPointRewards)

	if self.myGuildCfgData == nil then
		for i = 1, #self.trainingTotalPointRewards do
			local cfgData = self.trainingTotalPointRewards[i]

			if self.myGuildCfgData == nil and GuildTrainingModule.myGuildScore >= cfgData.PointsLowerLimit then
				self.myGuildCfgData = cfgData
			end
		end
	end

	self:ShowMyGuildData()
end

function GuildTrainingTotalPointRewardUI:ShowMyGuildData()
	self.Null:SetActive(GuildTrainingModule.myGuildScore == 0)
	self.Now:SetActive(GuildTrainingModule.myGuildScore > 0)
	UGUIUtil.SetText(self.TextScore, GuildTrainingModule.myGuildScore)

	for i, v in pairs(self.TrainingRankRewardCells) do
		self.TrainingRankRewardCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.TrainingRankRewardCells = {}

	if self.myGuildCfgData then
		for i = 1, #self.myGuildCfgData.RewardShow, 2 do
			local itemID = self.myGuildCfgData.RewardShow[i]
			local itemNum = self.myGuildCfgData.RewardShow[i + 1]

			if CfgItemTable[itemID].IsPanelShow then
				local itemCell = self.TrainingRankRewardCellPool:Obtain()

				itemCell.View:SetActive(true)
				itemCell.View.transform:SetParent(self.RewardNode.transform, false)
				itemCell:SetData(itemID, itemNum)
				table.insert(self.TrainingRankRewardCells, itemCell)
			end
		end
	end
end

function GuildTrainingTotalPointRewardUI:OnRenderGridCell(cell)
	local cfgData = self.trainingTotalPointRewards[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.totalPointRewardRenderPool[instanceID]

	if renderCell == nil then
		renderCell = GuildTrainingTotalPointRewardRender.New(cell.gameObject)
		self.totalPointRewardRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(cfgData)
end

return GuildTrainingTotalPointRewardUI
