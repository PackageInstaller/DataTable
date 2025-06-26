-- chunkname: @IQIGame\\UI\\AmusementParkGameFlappyBirdRankUI.lua

local AmusementParkGameFlappyBirdRankUI = {
	RankCellPool = {}
}

AmusementParkGameFlappyBirdRankUI = Base:Extend("AmusementParkGameFlappyBirdRankUI", "IQIGame.Onigao.UI.AmusementParkGameFlappyBirdRankUI", AmusementParkGameFlappyBirdRankUI)

require("IQIGame.UIExternalApi.AmusementParkGameFlappyBirdRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local AmusementParkBirdRankCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkBirdGame.AmusementParkBirdRankCell")

function AmusementParkGameFlappyBirdRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = AmusementParkGameFlappyBirdRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(AmusementParkGameFlappyBirdRankUIApi:GetString("NoneRankText"))
end

function AmusementParkGameFlappyBirdRankUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGameFlappyBirdRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGameFlappyBirdRankUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGameFlappyBirdRankUI:GetBGM(userData)
	return nil
end

function AmusementParkGameFlappyBirdRankUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkGameFlappyBirdRankUI:OnClose(userData)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGameFlappyBirdRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function AmusementParkGameFlappyBirdRankUI:OnPause()
	return
end

function AmusementParkGameFlappyBirdRankUI:OnResume()
	return
end

function AmusementParkGameFlappyBirdRankUI:OnCover()
	return
end

function AmusementParkGameFlappyBirdRankUI:OnReveal()
	return
end

function AmusementParkGameFlappyBirdRankUI:OnRefocus(userData)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGameFlappyBirdRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function AmusementParkGameFlappyBirdRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkGameFlappyBirdRankUI:UpdateView()
	self:RefreshRank()
end

function AmusementParkGameFlappyBirdRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkFlyBirdRank, AmusementParkBirdGameModule.birdRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function AmusementParkGameFlappyBirdRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function AmusementParkGameFlappyBirdRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = AmusementParkBirdRankCell.New(cellGo.gameObject)
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

return AmusementParkGameFlappyBirdRankUI
