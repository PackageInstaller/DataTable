-- chunkname: @IQIGame\\UI\\FishingActivityRankUI.lua

local FishingActivityRankUI = {
	RankCellPool = {}
}

FishingActivityRankUI = Base:Extend("FishingActivityRankUI", "IQIGame.Onigao.UI.FishingActivityRankUI", FishingActivityRankUI)

require("IQIGame.UIExternalApi.FishingActivityRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local FishingActivityRankCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityRank.FishingActivityRankCell")

function FishingActivityRankUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = FishingActivityRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(FishingActivityRankUIApi:GetString("NoneRankText"))
end

function FishingActivityRankUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityRankUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityRankUI:GetBGM(userData)
	return nil
end

function FishingActivityRankUI:OnOpen(userData)
	self:UpdateView()
end

function FishingActivityRankUI:OnClose(userData)
	return
end

function FishingActivityRankUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FishingActivityRankUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FishingActivityRankUI:OnPause()
	return
end

function FishingActivityRankUI:OnResume()
	return
end

function FishingActivityRankUI:OnCover()
	return
end

function FishingActivityRankUI:OnReveal()
	return
end

function FishingActivityRankUI:OnRefocus(userData)
	return
end

function FishingActivityRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function FishingActivityRankUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivityRankUI:UpdateView()
	self:RefreshRank()
end

function FishingActivityRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.FishingActivitySingleBestRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function FishingActivityRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function FishingActivityRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = FishingActivityRankCell.New(cellGo.gameObject)
		self.RankCellPool[instanceID] = rankingItem
	end

	if index == 0 then
		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, myScore, customData, rankType)
	elseif index == -1 then
		rankingItem.showFormationUI = false

		rankingItem:SetGoalieData(myScore, myRanking, rankType)
		self.RankingUIController.RankingGoalieGo:SetActive(true)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

return FishingActivityRankUI
