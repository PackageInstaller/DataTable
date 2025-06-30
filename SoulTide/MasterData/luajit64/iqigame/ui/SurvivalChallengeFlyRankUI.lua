-- chunkname: @IQIGame\\UI\\SurvivalChallengeFlyRankUI.lua

local SurvivalChallengeFlyRankUI = {
	RankCellPool = {}
}

SurvivalChallengeFlyRankUI = Base:Extend("SurvivalChallengeFlyRankUI", "IQIGame.Onigao.UI.SurvivalChallengeFlyRankUI", SurvivalChallengeFlyRankUI)

require("IQIGame.UIExternalApi.SurvivalChallengeFlyRankUIApi")

local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local SurvivalChallengeFlyRankCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeFlyRankCell")

function SurvivalChallengeFlyRankUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = SurvivalChallengeFlyRankUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(SurvivalChallengeFlyRankUIApi:GetString("NoneRankText"))
end

function SurvivalChallengeFlyRankUI:GetPreloadAssetPaths()
	return nil
end

function SurvivalChallengeFlyRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SurvivalChallengeFlyRankUI:IsManualShowOnOpen(userData)
	return false
end

function SurvivalChallengeFlyRankUI:GetBGM(userData)
	return nil
end

function SurvivalChallengeFlyRankUI:OnOpen(userData)
	self:UpdateView()
end

function SurvivalChallengeFlyRankUI:OnClose(userData)
	return
end

function SurvivalChallengeFlyRankUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function SurvivalChallengeFlyRankUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function SurvivalChallengeFlyRankUI:OnPause()
	return
end

function SurvivalChallengeFlyRankUI:OnResume()
	return
end

function SurvivalChallengeFlyRankUI:OnCover()
	return
end

function SurvivalChallengeFlyRankUI:OnReveal()
	return
end

function SurvivalChallengeFlyRankUI:OnRefocus(userData)
	return
end

function SurvivalChallengeFlyRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalChallengeFlyRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalChallengeFlyRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SurvivalChallengeFlyRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalChallengeFlyRankUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function SurvivalChallengeFlyRankUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function SurvivalChallengeFlyRankUI:UpdateView()
	if not SurvivalModule.IsShow() then
		return
	end

	self:RefreshRank()
end

function SurvivalChallengeFlyRankUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.SurvivalChallenge, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function SurvivalChallengeFlyRankUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function SurvivalChallengeFlyRankUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = SurvivalChallengeFlyRankCell.New(cellGo.gameObject)
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

return SurvivalChallengeFlyRankUI
