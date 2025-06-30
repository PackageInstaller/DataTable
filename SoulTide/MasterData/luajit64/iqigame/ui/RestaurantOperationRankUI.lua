-- chunkname: @IQIGame\\UI\\RestaurantOperationRankUI.lua

local RestaurantOperationRankUI = {
	RankCellPool = {}
}

RestaurantOperationRankUI = Base:Extend("RestaurantOperationRankUI", "IQIGame.Onigao.UI.RestaurantOperationRankUI", RestaurantOperationRankUI)

require("IQIGame.UIExternalApi.RestaurantOperationRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local RORankCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationRank.RORankCell")

function RestaurantOperationRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = RestaurantOperationRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(RestaurantOperationRankUIApi:GetString("NoneRankText"))
end

function RestaurantOperationRankUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationRankUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationRankUI:GetBGM(userData)
	return nil
end

function RestaurantOperationRankUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantOperationRankUI:OnClose(userData)
	return
end

function RestaurantOperationRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantOperationRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantOperationRankUI:OnPause()
	return
end

function RestaurantOperationRankUI:OnResume()
	return
end

function RestaurantOperationRankUI:OnCover()
	return
end

function RestaurantOperationRankUI:OnReveal()
	return
end

function RestaurantOperationRankUI:OnRefocus(userData)
	return
end

function RestaurantOperationRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function RestaurantOperationRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RestaurantOperationRankUI:UpdateView()
	self:RefreshRank()
end

function RestaurantOperationRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function RestaurantOperationRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function RestaurantOperationRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = RORankCell.New(cellGo.gameObject)
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

return RestaurantOperationRankUI
