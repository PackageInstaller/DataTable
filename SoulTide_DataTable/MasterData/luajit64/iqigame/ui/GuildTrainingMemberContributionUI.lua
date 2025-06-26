-- chunkname: @IQIGame\\UI\\GuildTrainingMemberContributionUI.lua

local GuildTrainingMemberContributionUI = {
	trainingMemberRenderPool = {},
	trainingPlayerRanks = {}
}

GuildTrainingMemberContributionUI = Base:Extend("GuildTrainingMemberContributionUI", "IQIGame.Onigao.UI.GuildTrainingMemberContributionUI", GuildTrainingMemberContributionUI)

local GuildTrainingMemberRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingMemberContribution.GuildTrainingMemberRender")

function GuildTrainingMemberContributionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
end

function GuildTrainingMemberContributionUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingMemberContributionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingMemberContributionUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingMemberContributionUI:GetBGM(userData)
	return nil
end

function GuildTrainingMemberContributionUI:OnOpen(userData)
	self:UpdateView()
end

function GuildTrainingMemberContributionUI:OnClose(userData)
	return
end

function GuildTrainingMemberContributionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingMemberContributionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function GuildTrainingMemberContributionUI:OnPause()
	return
end

function GuildTrainingMemberContributionUI:OnResume()
	return
end

function GuildTrainingMemberContributionUI:OnCover()
	return
end

function GuildTrainingMemberContributionUI:OnReveal()
	return
end

function GuildTrainingMemberContributionUI:OnRefocus(userData)
	return
end

function GuildTrainingMemberContributionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingMemberContributionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingMemberContributionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingMemberContributionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingMemberContributionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.trainingMemberRenderPool) do
		v:Dispose()
	end
end

function GuildTrainingMemberContributionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingMemberContributionUI:IsParticipate(memberPOD)
	local trainingPlayers = GuildTrainingModule.centerGuildTrainingPlayerRanks or {}

	for i, v in pairs(trainingPlayers) do
		if v.pid == memberPOD.player.pid then
			return true, v
		end
	end

	local data = {}

	data.pid = memberPOD.player.pid
	data.name = memberPOD.player.pName
	data.score = 0
	data.createTime = 0

	return false, data
end

function GuildTrainingMemberContributionUI:UpdateView()
	self.trainingPlayerRanks = {}

	if GuildModule.guildPOD.members then
		for i, v in pairs(GuildModule.guildPOD.members) do
			local top, data = self:IsParticipate(v)

			table.insert(self.trainingPlayerRanks, data)
		end
	end

	table.sort(self.trainingPlayerRanks, function(a, b)
		if a.score == b.score then
			return a.createTime < b.createTime
		end

		return a.score > b.score
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.trainingPlayerRanks)
end

function GuildTrainingMemberContributionUI:OnRenderGridCell(cell)
	local trainingPlayerRankPOD = self.trainingPlayerRanks[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.trainingMemberRenderPool[instanceID]

	if renderCell == nil then
		renderCell = GuildTrainingMemberRender.New(cell.gameObject)
		self.trainingMemberRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(cell.index + 1, trainingPlayerRankPOD)
end

return GuildTrainingMemberContributionUI
