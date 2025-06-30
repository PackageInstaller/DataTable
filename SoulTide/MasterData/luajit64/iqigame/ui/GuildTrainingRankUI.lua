-- chunkname: @IQIGame\\UI\\GuildTrainingRankUI.lua

local GuildTrainingRankUI = {
	guildTrainingRankRenderPool = {},
	guildRanks = {},
	TrainingRankRewardCells = {}
}

GuildTrainingRankUI = Base:Extend("GuildTrainingRankUI", "IQIGame.Onigao.UI.GuildTrainingRankUI", GuildTrainingRankUI)

require("IQIGame.UIExternalApi.GuildTrainingRankUIApi")

local GuildTrainingRankData = require("IQIGame.Module.Guild.GuildTraining.GuildTrainingRankData")
local GuildTrainingRankRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingRank.GuildTrainingRankRender")
local GuildHeadCell = require("IQIGame.UI.Guild.GuildMain.GuildHeadCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local GuildTrainingRankRewardCell = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingRankReward.GuildTrainingRankRewardCell")

function GuildTrainingRankUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnRankReward()
		self:OnClickBtnRankReward()
	end

	function self.DelegateUpdateTrainingRank()
		self:OnUpdateTrainingRank()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.guildHeadCell = GuildHeadCell.New(self.MyGuildHead)

	self.MyGuildRewardMould:SetActive(false)

	self.TrainingRankRewardCellPool = UIObjectPool.New(4, function()
		return GuildTrainingRankRewardCell.New(UnityEngine.Object.Instantiate(self.MyGuildRewardMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function GuildTrainingRankUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingRankUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingRankUI:GetBGM(userData)
	return nil
end

function GuildTrainingRankUI:OnOpen(userData)
	GuildTrainingModule.GetRanking()
end

function GuildTrainingRankUI:OnClose(userData)
	return
end

function GuildTrainingRankUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRankReward)
	EventDispatcher.AddEventListener(EventID.GuildUpdateTrainingRankEvent, self.DelegateUpdateTrainingRank)
end

function GuildTrainingRankUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRankReward)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateTrainingRankEvent, self.DelegateUpdateTrainingRank)
end

function GuildTrainingRankUI:OnPause()
	return
end

function GuildTrainingRankUI:OnResume()
	return
end

function GuildTrainingRankUI:OnCover()
	return
end

function GuildTrainingRankUI:OnReveal()
	return
end

function GuildTrainingRankUI:OnRefocus(userData)
	return
end

function GuildTrainingRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.guildTrainingRankRenderPool) do
		v:Dispose()
	end

	self.guildHeadCell:Dispose()

	for i = 1, #self.TrainingRankRewardCells do
		local cell = self.TrainingRankRewardCells[i]

		cell.View:SetActive(false)
		self.TrainingRankRewardCellPool:Release(cell)
	end

	self.TrainingRankRewardCells = {}

	self.TrainingRankRewardCellPool:Dispose()
end

function GuildTrainingRankUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingRankUI:OnClickBtnRankReward()
	UIModule.Open(Constant.UIControllerName.GuildTrainingRankRewardUI, Constant.UILayer.UI)
end

function GuildTrainingRankUI:OnUpdateTrainingRank()
	self:UpdateView()
end

function GuildTrainingRankUI:UpdateView()
	self.guildRanks = {}

	self.TextMyGuildRank:SetActive(GuildTrainingModule.myGuildRankType == 1)

	local index = 0

	for i, v in pairs(GuildTrainingModule.guildRankings) do
		index = index + 1

		local data = GuildTrainingRankData.New(v.guid, index, 1, v.headIcon, v.avatarFrame, v.name, v.value)

		table.insert(self.guildRanks, data)
	end

	if GuildModule.guildPOD then
		self.guildHeadCell:SetData(GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.level)
		UGUIUtil.SetText(self.TextMyGuildName, GuildModule.guildPOD.base.name)

		local myGuildRankData = GuildTrainingRankData.New(GuildModule.guildPOD.base.id, GuildTrainingModule.myGuildRanking, GuildTrainingModule.myGuildRankType, GuildModule.guildPOD.base.headIcon, GuildModule.guildPOD.base.avatarFrame, GuildModule.guildPOD.base.guildName, GuildTrainingModule.myGuildScore)

		if GuildTrainingModule.myGuildRanking > 0 then
			local path = UIGlobalApi.GetImagePath(myGuildRankData.cfgRankRewardData.Image)

			AssetUtil.LoadImage(self, path, self.MyGuildRankIcon:GetComponent("Image"))
			UGUIUtil.SetText(self.TextMyGuildRank, GuildTrainingModule.myGuildRanking)

			for i, v in pairs(self.TrainingRankRewardCells) do
				self.TrainingRankRewardCellPool:Release(v)
				v.View:SetActive(false)
				v.View.transform:SetParent(self.UIController.transform, false)
			end

			self.TrainingRankRewardCells = {}

			for i = 1, #myGuildRankData.cfgRankRewardData.RewardShow, 2 do
				local itemID = myGuildRankData.cfgRankRewardData.RewardShow[i]
				local itemNum = myGuildRankData.cfgRankRewardData.RewardShow[i + 1]

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

	local rankScore = GuildTrainingModule.myGuildScore

	self.NotNull:SetActive(GuildTrainingModule.myGuildRanking > 0)
	self.Null:SetActive(GuildTrainingModule.myGuildRanking <= 0)
	UGUIUtil.SetText(self.TextMyGuildScore, GuildTrainingRankUIApi:GetString("GuildScore", rankScore))
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.guildRanks)
end

function GuildTrainingRankUI:OnRenderGridCell(cell)
	local guildRankData = self.guildRanks[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.guildTrainingRankRenderPool[instanceID]

	if renderCell == nil then
		renderCell = GuildTrainingRankRender.New(cell.gameObject)
		self.guildTrainingRankRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(guildRankData)
end

return GuildTrainingRankUI
