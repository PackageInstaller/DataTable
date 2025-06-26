-- chunkname: @IQIGame\\UI\\RestaurantGameConnectRankUI.lua

local RestaurantGameConnectRankUI = {
	RankCellPool = {}
}

RestaurantGameConnectRankUI = Base:Extend("RestaurantGameConnectRankUI", "IQIGame.Onigao.UI.RestaurantGameConnectRankUI", RestaurantGameConnectRankUI)

require("IQIGame.UIExternalApi.RestaurantGameConnectRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local FruitGameRankCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.FruitCleanGame.FruitGameRankCell")

function RestaurantGameConnectRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = RestaurantGameConnectRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(RestaurantGameConnectRankUIApi:GetString("NoneRankText"))
end

function RestaurantGameConnectRankUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameConnectRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameConnectRankUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameConnectRankUI:GetBGM(userData)
	return nil
end

function RestaurantGameConnectRankUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameConnectRankUI:OnClose(userData)
	return
end

function RestaurantGameConnectRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameConnectRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantGameConnectRankUI:OnPause()
	return
end

function RestaurantGameConnectRankUI:OnResume()
	return
end

function RestaurantGameConnectRankUI:OnCover()
	return
end

function RestaurantGameConnectRankUI:OnReveal()
	return
end

function RestaurantGameConnectRankUI:OnRefocus(userData)
	return
end

function RestaurantGameConnectRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameConnectRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameConnectRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameConnectRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameConnectRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function RestaurantGameConnectRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RestaurantGameConnectRankUI:UpdateView()
	self:RefreshRank()
end

function RestaurantGameConnectRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationFruitCleanGameRank, ROFruitCleanGameModule.fruitCleanGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function RestaurantGameConnectRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function RestaurantGameConnectRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = FruitGameRankCell.New(cellGo.gameObject)
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

return RestaurantGameConnectRankUI
