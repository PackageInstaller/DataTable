-- chunkname: @IQIGame\\UI\\AmusementParkRankUI.lua

local AmusementParkRankUI = {
	RankCellPool = {}
}

AmusementParkRankUI = Base:Extend("AmusementParkRankUI", "IQIGame.Onigao.UI.AmusementParkRankUI", AmusementParkRankUI)

require("IQIGame.UIExternalApi.AmusementParkRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local AmusementParkRankCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkRank.AmusementParkRankCell")

function AmusementParkRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = AmusementParkRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(AmusementParkRankUIApi:GetString("NoneRankText"))
end

function AmusementParkRankUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkRankUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkRankUI:GetBGM(userData)
	return nil
end

function AmusementParkRankUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkRankUI:OnClose(userData)
	return
end

function AmusementParkRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkRankUI:OnPause()
	return
end

function AmusementParkRankUI:OnResume()
	return
end

function AmusementParkRankUI:OnCover()
	return
end

function AmusementParkRankUI:OnReveal()
	return
end

function AmusementParkRankUI:OnRefocus(userData)
	return
end

function AmusementParkRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function AmusementParkRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkRankUI:UpdateView()
	self:RefreshRank()
end

function AmusementParkRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function AmusementParkRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function AmusementParkRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = AmusementParkRankCell.New(cellGo.gameObject)
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

return AmusementParkRankUI
