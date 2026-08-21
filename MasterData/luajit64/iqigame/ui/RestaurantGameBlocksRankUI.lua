-- chunkname: @IQIGame\\UI\\RestaurantGameBlocksRankUI.lua

local RestaurantGameBlocksRankUI = {
	RankCellPool = {}
}

RestaurantGameBlocksRankUI = Base:Extend("RestaurantGameBlocksRankUI", "IQIGame.Onigao.UI.RestaurantGameBlocksRankUI", RestaurantGameBlocksRankUI)

require("IQIGame.UIExternalApi.RestaurantGameBlocksRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local PuzzleGameRankCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.PuzzleGame.PuzzleGameRankCell")

function RestaurantGameBlocksRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = RestaurantGameBlocksRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(RestaurantGameBlocksRankUIApi:GetString("NoneRankText"))
end

function RestaurantGameBlocksRankUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameBlocksRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameBlocksRankUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameBlocksRankUI:GetBGM(userData)
	return nil
end

function RestaurantGameBlocksRankUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameBlocksRankUI:OnClose(userData)
	return
end

function RestaurantGameBlocksRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameBlocksRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameBlocksRankUI:OnPause()
	return
end

function RestaurantGameBlocksRankUI:OnResume()
	return
end

function RestaurantGameBlocksRankUI:OnCover()
	return
end

function RestaurantGameBlocksRankUI:OnReveal()
	return
end

function RestaurantGameBlocksRankUI:OnRefocus(userData)
	return
end

function RestaurantGameBlocksRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameBlocksRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameBlocksRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameBlocksRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameBlocksRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function RestaurantGameBlocksRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RestaurantGameBlocksRankUI:UpdateView()
	self:RefreshRank()
end

function RestaurantGameBlocksRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationPuzzleGameRank, ROPuzzleGameModule.puzzleGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function RestaurantGameBlocksRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function RestaurantGameBlocksRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = PuzzleGameRankCell.New(cellGo.gameObject)
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

return RestaurantGameBlocksRankUI
