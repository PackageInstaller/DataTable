-- chunkname: @IQIGame\\UI\\PlaceGameRankUI.lua

local PlaceGameRankUI = {
	RankCellPool = {}
}

PlaceGameRankUI = Base:Extend("PlaceGameRankUI", "IQIGame.Onigao.UI.PlaceGameRankUI", PlaceGameRankUI)

require("IQIGame.UIExternalApi.PlaceGameRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local PlaceGameRankCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameRank.PlaceGameRankCell")

function PlaceGameRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = PlaceGameRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(PlaceGameRankUIApi:GetString("NoneRankText"))
end

function PlaceGameRankUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameRankUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameRankUI:GetBGM(userData)
	return nil
end

function PlaceGameRankUI:OnOpen(userData)
	self:UpdateView()
end

function PlaceGameRankUI:OnClose(userData)
	return
end

function PlaceGameRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function PlaceGameRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function PlaceGameRankUI:OnPause()
	return
end

function PlaceGameRankUI:OnResume()
	return
end

function PlaceGameRankUI:OnCover()
	return
end

function PlaceGameRankUI:OnReveal()
	return
end

function PlaceGameRankUI:OnRefocus(userData)
	return
end

function PlaceGameRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function PlaceGameRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function PlaceGameRankUI:UpdateView()
	if not PlaceGameModule.IsShow() then
		return
	end

	self:RefreshRank()
end

function PlaceGameRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.PlaceGameRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function PlaceGameRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function PlaceGameRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = PlaceGameRankCell.New(cellGo.gameObject)
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

function PlaceGameRankUI:RefreshRankGoalie(myRanking, rankType)
	local placeGameTowerRankList = PlaceGameModule.placeGameRankList
	local cfgMyRank

	for i, v in pairs(placeGameTowerRankList) do
		if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
			cfgMyRank = v
		end
	end

	if cfgMyRank == nil then
		logError("myRanking " .. myRanking)

		return
	end

	local cfgRankGoalie

	for i = 1, #placeGameTowerRankList do
		local cfg = placeGameTowerRankList[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = placeGameTowerRankList[i - 1]

			break
		end
	end

	CenterRankModule.GetRankGoalie(Constant.RankingType.PlaceGameRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

return PlaceGameRankUI
