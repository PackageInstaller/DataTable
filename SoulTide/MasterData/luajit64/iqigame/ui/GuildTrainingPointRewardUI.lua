-- chunkname: @IQIGame\\UI\\GuildTrainingPointRewardUI.lua

local GuildTrainingPointRewardUI = {
	trainingPointReward = {},
	trainingPointRewardRenderPool = {}
}

GuildTrainingPointRewardUI = Base:Extend("GuildTrainingPointRewardUI", "IQIGame.Onigao.UI.GuildTrainingPointRewardUI", GuildTrainingPointRewardUI)

require("IQIGame.UIExternalApi.GuildTrainingPointRewardUIApi")

local GuildTrainingPointRewardRender = require("IQIGame.UI.Guild.GuildTraining.GuildTrainingPointReward.GuildTrainingPointRewardRender")

function GuildTrainingPointRewardUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateTrainingMemberEvent()
		self:OnUpdateTrainingMember()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.trainingPointReward = {}

	for i, v in pairsCfg(CfgGuildTrainingPointRewardTable) do
		table.insert(self.trainingPointReward, v)
	end

	table.sort(self.trainingPointReward, function(a, b)
		return a.Sort > b.Sort
	end)
end

function GuildTrainingPointRewardUI:GetPreloadAssetPaths()
	return nil
end

function GuildTrainingPointRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildTrainingPointRewardUI:IsManualShowOnOpen(userData)
	return false
end

function GuildTrainingPointRewardUI:GetBGM(userData)
	return nil
end

function GuildTrainingPointRewardUI:OnOpen(userData)
	self:UpdateView()
end

function GuildTrainingPointRewardUI:OnClose(userData)
	return
end

function GuildTrainingPointRewardUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateUpdateTrainingMemberEvent)
end

function GuildTrainingPointRewardUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateTrainingMemberEvent, self.DelegateUpdateTrainingMemberEvent)
end

function GuildTrainingPointRewardUI:OnPause()
	return
end

function GuildTrainingPointRewardUI:OnResume()
	return
end

function GuildTrainingPointRewardUI:OnCover()
	return
end

function GuildTrainingPointRewardUI:OnReveal()
	return
end

function GuildTrainingPointRewardUI:OnRefocus(userData)
	return
end

function GuildTrainingPointRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildTrainingPointRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildTrainingPointRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildTrainingPointRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildTrainingPointRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.trainingPointRewardRenderPool) do
		v:Dispose()
	end
end

function GuildTrainingPointRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildTrainingPointRewardUI:OnUpdateTrainingMember()
	self:UpdateView()
end

function GuildTrainingPointRewardUI:UpdateView()
	UGUIUtil.SetText(self.TextScoreMax, GuildTrainingPointRewardUIApi:GetString("TextScoreMax", GuildTrainingModule.GuildTrainingPOD.maxIntegral))
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.trainingPointReward)
end

function GuildTrainingPointRewardUI:OnRenderGridCell(cell)
	local cfgData = self.trainingPointReward[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.trainingPointRewardRenderPool[instanceID]

	if renderCell == nil then
		renderCell = GuildTrainingPointRewardRender.New(cell.gameObject)
		self.trainingPointRewardRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(cfgData)
end

return GuildTrainingPointRewardUI
