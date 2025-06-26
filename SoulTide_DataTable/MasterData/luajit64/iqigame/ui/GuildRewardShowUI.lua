-- chunkname: @IQIGame\\UI\\GuildRewardShowUI.lua

local GuildRewardShowUI = {
	challengeRewards = {},
	rewardShowCellPool = {},
	canGetReward = {}
}

GuildRewardShowUI = Base:Extend("GuildRewardShowUI", "IQIGame.Onigao.UI.GuildRewardShowUI", GuildRewardShowUI)

require("IQIGame.UIExternalApi.GuildRewardShowUIApi")

local GuildRewardShowCell = require("IQIGame.UI.Guild.GuildRewardShow.GuildRewardShowCell")

function GuildRewardShowUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildRewardShowUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.BtnGetAllReward, GuildRewardShowUIApi:GetString("BtnGetAllRewardLabel"))

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end

	function self.DelegateCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateBtnGetAllReward()
		self:OnBtnGetAllReward()
	end

	function self.DelegateGuildChallengeUpdateEvent()
		self:OnGuildChallengeUpdateEvent()
	end
end

function GuildRewardShowUI:GetPreloadAssetPaths()
	return nil
end

function GuildRewardShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildRewardShowUI:IsManualShowOnOpen(userData)
	return false
end

function GuildRewardShowUI:GetBGM(userData)
	return nil
end

function GuildRewardShowUI:OnOpen(userData)
	self:UpdateView()
end

function GuildRewardShowUI:OnClose(userData)
	return
end

function GuildRewardShowUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.BtnGetAllReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnGetAllReward)
	EventDispatcher.AddEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
end

function GuildRewardShowUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.BtnGetAllReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnGetAllReward)
	EventDispatcher.RemoveEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
end

function GuildRewardShowUI:OnPause()
	return
end

function GuildRewardShowUI:OnResume()
	return
end

function GuildRewardShowUI:OnCover()
	return
end

function GuildRewardShowUI:OnReveal()
	return
end

function GuildRewardShowUI:OnRefocus(userData)
	return
end

function GuildRewardShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildRewardShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildRewardShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildRewardShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildRewardShowUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardShowCellPool) do
		v:Dispose()
	end
end

function GuildRewardShowUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildRewardShowUI:OnGuildChallengeUpdateEvent()
	self:UpdateView()
end

function GuildRewardShowUI:UpdateView()
	self.challengeRewards, self.canGetReward = GuildChallengeModule.GetGuildChallengeRewardList()

	table.sort(self.challengeRewards, function(a, b)
		if a.state == b.state then
			return a.cfgInfo.Sort < b.cfgInfo.Sort
		end

		return a.state < b.state
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.challengeRewards)
end

function GuildRewardShowUI:OnRenderCell(cell)
	local data = self.challengeRewards[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local showCell = self.rewardShowCellPool[instanceID]

	if showCell == nil then
		showCell = GuildRewardShowCell.New(cell.gameObject)
		self.rewardShowCellPool[instanceID] = showCell
	end

	showCell:SetData(data)
end

function GuildRewardShowUI:OnBtnGetAllReward()
	GuildChallengeModule.GetScore(function()
		self:UpdateView()

		if #self.canGetReward > 0 then
			GuildChallengeModule.GetRewards(self.canGetReward)
		end
	end)
end

return GuildRewardShowUI
