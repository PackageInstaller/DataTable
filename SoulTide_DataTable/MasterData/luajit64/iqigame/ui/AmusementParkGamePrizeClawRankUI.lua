-- chunkname: @IQIGame\\UI\\AmusementParkGamePrizeClawRankUI.lua

local AmusementParkGamePrizeClawRankUI = {
	RankCellPool = {}
}

AmusementParkGamePrizeClawRankUI = Base:Extend("AmusementParkGamePrizeClawRankUI", "IQIGame.Onigao.UI.AmusementParkGamePrizeClawRankUI", AmusementParkGamePrizeClawRankUI)

require("IQIGame.UIExternalApi.AmusementParkGamePrizeClawRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local AmusementParkDollMachineRankCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineRankCell")

function AmusementParkGamePrizeClawRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = AmusementParkGamePrizeClawRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(AmusementParkGamePrizeClawRankUIApi:GetString("NoneRankText"))
end

function AmusementParkGamePrizeClawRankUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGamePrizeClawRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGamePrizeClawRankUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGamePrizeClawRankUI:GetBGM(userData)
	return nil
end

function AmusementParkGamePrizeClawRankUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkGamePrizeClawRankUI:OnClose(userData)
	return
end

function AmusementParkGamePrizeClawRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGamePrizeClawRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGamePrizeClawRankUI:OnPause()
	return
end

function AmusementParkGamePrizeClawRankUI:OnResume()
	return
end

function AmusementParkGamePrizeClawRankUI:OnCover()
	return
end

function AmusementParkGamePrizeClawRankUI:OnReveal()
	return
end

function AmusementParkGamePrizeClawRankUI:OnRefocus(userData)
	return
end

function AmusementParkGamePrizeClawRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGamePrizeClawRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGamePrizeClawRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGamePrizeClawRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGamePrizeClawRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function AmusementParkGamePrizeClawRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkGamePrizeClawRankUI:UpdateView()
	self:RefreshRank()
end

function AmusementParkGamePrizeClawRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkDollMachineRank, AmusementParkDollMachineGameModule.dollMachineGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function AmusementParkGamePrizeClawRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function AmusementParkGamePrizeClawRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = AmusementParkDollMachineRankCell.New(cellGo.gameObject)
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

return AmusementParkGamePrizeClawRankUI
