-- chunkname: @IQIGame\\UI\\AmusementParkGameBlocksRankUI.lua

local AmusementParkGameBlocksRankUI = {
	RankCellPool = {}
}

AmusementParkGameBlocksRankUI = Base:Extend("AmusementParkGameBlocksRankUI", "IQIGame.Onigao.UI.AmusementParkGameBlocksRankUI", AmusementParkGameBlocksRankUI)

require("IQIGame.UIExternalApi.AmusementParkGameBlocksRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local AmusementParkPuzzleGameRankCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPuzzleGame.AmusementParkPuzzleGameRankCell")

function AmusementParkGameBlocksRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = AmusementParkGameBlocksRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(AmusementParkGameBlocksRankUIApi:GetString("NoneRankText"))
end

function AmusementParkGameBlocksRankUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameBlocksRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameBlocksRankUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameBlocksRankUI:GetBGM(userData)
	return nil
end

function AmusementParkGameBlocksRankUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkGameBlocksRankUI:OnClose(userData)
	return
end

function AmusementParkGameBlocksRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGameBlocksRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGameBlocksRankUI:OnPause()
	return
end

function AmusementParkGameBlocksRankUI:OnResume()
	return
end

function AmusementParkGameBlocksRankUI:OnCover()
	return
end

function AmusementParkGameBlocksRankUI:OnReveal()
	return
end

function AmusementParkGameBlocksRankUI:OnRefocus(userData)
	return
end

function AmusementParkGameBlocksRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameBlocksRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameBlocksRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameBlocksRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameBlocksRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function AmusementParkGameBlocksRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkGameBlocksRankUI:UpdateView()
	self:RefreshRank()
end

function AmusementParkGameBlocksRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkStackedBlocksRank, AmusementParkPuzzleGameModule.puzzleGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function AmusementParkGameBlocksRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function AmusementParkGameBlocksRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = AmusementParkPuzzleGameRankCell.New(cellGo.gameObject)
		self.RankCellPool[instanceID] = rankingItem
	end

	if index == 0 then
		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, myScore, customData, rankType)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

return AmusementParkGameBlocksRankUI
