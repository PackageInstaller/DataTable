-- chunkname: @IQIGame\\UI\\FlightGameBossRankUI.lua

local FlightGameBossRankUI = {
	RankCellPool = {}
}

FlightGameBossRankUI = Base:Extend("FlightGameBossRankUI", "IQIGame.Onigao.UI.FlightGameBossRankUI", FlightGameBossRankUI)

require("IQIGame.UIExternalApi.FlightGameBossRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local FlightGameRankCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameRankCell")

function FlightGameBossRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = FlightGameBossRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(FlightGameBossRankUIApi:GetString("NoneRankText"))
end

function FlightGameBossRankUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameBossRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameBossRankUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameBossRankUI:GetBGM(userData)
	return nil
end

function FlightGameBossRankUI:OnOpen(userData)
	self:UpdateView()
end

function FlightGameBossRankUI:OnClose(userData)
	return
end

function FlightGameBossRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function FlightGameBossRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function FlightGameBossRankUI:OnPause()
	return
end

function FlightGameBossRankUI:OnResume()
	return
end

function FlightGameBossRankUI:OnCover()
	return
end

function FlightGameBossRankUI:OnReveal()
	return
end

function FlightGameBossRankUI:OnRefocus(userData)
	return
end

function FlightGameBossRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameBossRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameBossRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameBossRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameBossRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function FlightGameBossRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function FlightGameBossRankUI:UpdateView()
	if not FlightChallengeModule.IsShow() then
		return
	end

	self:RefreshRank()
end

function FlightGameBossRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.FlightGameRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function FlightGameBossRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function FlightGameBossRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = FlightGameRankCell.New(cellGo.gameObject)
		self.RankCellPool[instanceID] = rankingItem
	end

	if index == 0 then
		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, myScore, customData, rankType)
	elseif index == -1 then
		rankingItem.showFormationUI = false

		self.RankingUIController.RankingGoalieGo:SetActive(false)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

return FlightGameBossRankUI
