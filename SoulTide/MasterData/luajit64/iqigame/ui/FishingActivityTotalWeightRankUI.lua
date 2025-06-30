-- chunkname: @IQIGame\\UI\\FishingActivityTotalWeightRankUI.lua

local FishingActivityTotalWeightRankUI = {
	RankCellPool = {}
}

FishingActivityTotalWeightRankUI = Base:Extend("FishingActivityTotalWeightRankUI", "IQIGame.Onigao.UI.FishingActivityTotalWeightRankUI", FishingActivityTotalWeightRankUI)

require("IQIGame.UIExternalApi.FishingActivityTotalWeightRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local FishingActivityTotalWeightRankCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityTotalWeightRank.FishingActivityTotalWeightRankCell")

function FishingActivityTotalWeightRankUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = FishingActivityTotalWeightRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(FishingActivityTotalWeightRankUIApi:GetString("NoneRankText"))
end

function FishingActivityTotalWeightRankUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityTotalWeightRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityTotalWeightRankUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityTotalWeightRankUI:GetBGM(userData)
	return nil
end

function FishingActivityTotalWeightRankUI:OnOpen(userData)
	self:UpdateView()
end

function FishingActivityTotalWeightRankUI:OnClose(userData)
	return
end

function FishingActivityTotalWeightRankUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FishingActivityTotalWeightRankUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FishingActivityTotalWeightRankUI:OnPause()
	return
end

function FishingActivityTotalWeightRankUI:OnResume()
	return
end

function FishingActivityTotalWeightRankUI:OnCover()
	return
end

function FishingActivityTotalWeightRankUI:OnReveal()
	return
end

function FishingActivityTotalWeightRankUI:OnRefocus(userData)
	return
end

function FishingActivityTotalWeightRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityTotalWeightRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityTotalWeightRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityTotalWeightRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityTotalWeightRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function FishingActivityTotalWeightRankUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivityTotalWeightRankUI:UpdateView()
	self:RefreshRank()
end

function FishingActivityTotalWeightRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.FishingActivityTotalWeightRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function FishingActivityTotalWeightRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function FishingActivityTotalWeightRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = FishingActivityTotalWeightRankCell.New(cellGo.gameObject)
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

return FishingActivityTotalWeightRankUI
