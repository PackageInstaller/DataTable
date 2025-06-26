-- chunkname: @IQIGame\\UI\\RestaurantGameCardRankUI.lua

local RestaurantGameCardRankUI = {
	RankCellPool = {}
}

RestaurantGameCardRankUI = Base:Extend("RestaurantGameCardRankUI", "IQIGame.Onigao.UI.RestaurantGameCardRankUI", RestaurantGameCardRankUI)

require("IQIGame.UIExternalApi.RestaurantGameCardRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local CardGameRankCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.CardGame.CardGameRankCell")

function RestaurantGameCardRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = RestaurantGameCardRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(RestaurantGameCardRankUIApi:GetString("NoneRankText"))
end

function RestaurantGameCardRankUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameCardRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameCardRankUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameCardRankUI:GetBGM(userData)
	return nil
end

function RestaurantGameCardRankUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameCardRankUI:OnClose(userData)
	return
end

function RestaurantGameCardRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameCardRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameCardRankUI:OnPause()
	return
end

function RestaurantGameCardRankUI:OnResume()
	return
end

function RestaurantGameCardRankUI:OnCover()
	return
end

function RestaurantGameCardRankUI:OnReveal()
	return
end

function RestaurantGameCardRankUI:OnRefocus(userData)
	return
end

function RestaurantGameCardRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameCardRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameCardRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameCardRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameCardRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function RestaurantGameCardRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RestaurantGameCardRankUI:UpdateView()
	self:RefreshRank()
end

function RestaurantGameCardRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationCardGameRank, ROCardGameModule.cardGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function RestaurantGameCardRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function RestaurantGameCardRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = CardGameRankCell.New(cellGo.gameObject)
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

return RestaurantGameCardRankUI
