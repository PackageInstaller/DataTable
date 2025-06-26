-- chunkname: @IQIGame\\UI\\GuildTrainingRankRewardUI.lua

local GuildTrainingRankRewardUI = {
	rankRenderPool = {},
	cfgTrainingRankRewardDataTab = {}
}

GuildTrainingRankRewardUI = Base:Extend("GuildTrainingRankRewardUI", "IQIGame.Onigao.UI.GuildTrainingRankRewardUI", GuildTrainingRankRewardUI)

local GuildTrainingRankRewardRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingRankReward.GuildTrainingRankRewardRender")

function GuildTrainingRankRewardUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.cfgTrainingRankRewardDataTab = {}

	for i, v in pairsCfg(CfgGuildTrainingRankRewardTable) do
		table.insert(self.cfgTrainingRankRewardDataTab, v)
	end

	table.sort(self.cfgTrainingRankRewardDataTab, function(a, b)
		return a.Id < b.Id
	end)
end

function GuildTrainingRankRewardUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingRankRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingRankRewardUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingRankRewardUI:GetBGM(userData)
	return nil
end

function GuildTrainingRankRewardUI:OnOpen(userData)
	self:UpdateView()
end

function GuildTrainingRankRewardUI:OnClose(userData)
	return
end

function GuildTrainingRankRewardUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingRankRewardUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingRankRewardUI:OnPause()
	return
end

function GuildTrainingRankRewardUI:OnResume()
	return
end

function GuildTrainingRankRewardUI:OnCover()
	return
end

function GuildTrainingRankRewardUI:OnReveal()
	return
end

function GuildTrainingRankRewardUI:OnRefocus(userData)
	return
end

function GuildTrainingRankRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingRankRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingRankRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingRankRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingRankRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rankRenderPool) do
		v:Dispose()
	end
end

function GuildTrainingRankRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingRankRewardUI:UpdateView()
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.cfgTrainingRankRewardDataTab)
end

function GuildTrainingRankRewardUI:OnRenderGridCell(cell)
	local cfgData = self.cfgTrainingRankRewardDataTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rankRenderPool[instanceID]

	if renderCell == nil then
		renderCell = GuildTrainingRankRewardRender.New(cell.gameObject)
		self.rankRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(cfgData)
end

return GuildTrainingRankRewardUI
