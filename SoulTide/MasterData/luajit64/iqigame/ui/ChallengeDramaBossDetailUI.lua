-- chunkname: @IQIGame\\UI\\ChallengeDramaBossDetailUI.lua

local ChallengeDramaBossDetailUI = {
	MonsterElementCells = {},
	RankCellPool = {}
}

ChallengeDramaBossDetailUI = Base:Extend("ChallengeDramaBossDetailUI", "IQIGame.Onigao.UI.ChallengeDramaBossDetailUI", ChallengeDramaBossDetailUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local PlotActivityBossRankCell = require("IQIGame.UI.ExploreHall.PlotChallenge.PlotActivityBossRankCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")

function ChallengeDramaBossDetailUI:OnInit()
	UGUIUtil.SetText(self.TitleName, ChallengeDramaBossDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextReward, ChallengeDramaBossDetailUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextChallengeBtn, ChallengeDramaBossDetailUIApi:GetString("TextChallengeBtn"))
	UGUIUtil.SetText(self.BtnShopLabel, ChallengeDramaBossDetailUIApi:GetString("BtnShopLabel"))

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = ChallengeDramaBossDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(ChallengeDramaBossDetailUIApi:GetString("NoneRankText"))

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateRefreshRankEvent()
		self:RefreshRank()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateBtnReward()
		self:OnBtnReward()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end

	function self.DelegateBtnShowRank()
		self:OnShowRank()
	end

	function self.DelegateBtnHideRank()
		self:OnHideRank()
	end

	self.myRankRender = PlotActivityBossRankCell.New(self.MyRankRender)
	self.myRankRender.showFormationUI = false
end

function ChallengeDramaBossDetailUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeDramaBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeDramaBossDetailUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeDramaBossDetailUI:GetBGM(userData)
	return nil
end

function ChallengeDramaBossDetailUI:OnOpen(userData)
	self.cfgPlotGlobalData = userData

	self:UpdateView()
	self:RefreshRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)
end

function ChallengeDramaBossDetailUI:OnClose(userData)
	return
end

function ChallengeDramaBossDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnShowRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnHideRank)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function ChallengeDramaBossDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnShowRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHideRank)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function ChallengeDramaBossDetailUI:OnPause()
	return
end

function ChallengeDramaBossDetailUI:OnResume()
	return
end

function ChallengeDramaBossDetailUI:OnCover()
	return
end

function ChallengeDramaBossDetailUI:OnReveal()
	return
end

function ChallengeDramaBossDetailUI:OnRefocus(userData)
	return
end

function ChallengeDramaBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeDramaBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeDramaBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeDramaBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeDramaBossDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()
	self.myRankRender:Dispose()
end

function ChallengeDramaBossDetailUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeDramaBossDetailUI)
end

function ChallengeDramaBossDetailUI:UpdateView()
	UGUIUtil.SetText(self.TextBossName, self.cfgPlotGlobalData.BossName)

	local path = UIGlobalApi.GetImagePath(self.cfgPlotGlobalData.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))

	local bgPath = UIGlobalApi.GetImagePath(self.cfgPlotGlobalData.BossImage)

	AssetUtil.LoadImage(self, bgPath, self.ImgBG:GetComponent("Image"))

	local costID = self.cfgPlotGlobalData.ChallengeBossNeed[1]
	local costValue = self.cfgPlotGlobalData.ChallengeBossNeed[2]
	local path = UIGlobalApi.GetIconPath(CfgItemTable[costID].Icon)

	AssetUtil.LoadImage(self, path, self.CostIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.CostNum, ChallengeDramaBossDetailUIApi:GetString("CostValue", costValue))
	self.FormationPanelController:UpdateView()

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local sortTab = PlotChallengeModule.GetMonsterWeakTypes(self.cfgPlotGlobalData.BossTeam)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end
end

function ChallengeDramaBossDetailUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function ChallengeDramaBossDetailUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = PlotActivityBossRankCell.New(cellGo.gameObject)
		self.RankCellPool[instanceID] = rankingItem
	end

	if index == 0 then
		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, myScore, customData, rankType)
		self.myRankRender:SetMyData(myRanking, myScore, customData, rankType)
	elseif index == -1 then
		rankingItem.showFormationUI = false

		rankingItem:SetGoalieData(myScore, myRanking, rankType)
		self.RankingUIController.RankingGoalieGo:SetActive(true)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

function ChallengeDramaBossDetailUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.PlotChallengeBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function ChallengeDramaBossDetailUI:RefreshRankGoalie(myRanking, rankType)
	local exBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgPlotChallengeActivityBossRankTable) do
		if v.Group == PlotChallengeModule.GlobalCid then
			table.insert(exBossRankReward, v)

			if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
				cfgMyRank = v
			end
		end
	end

	table.sort(exBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local cfgRankGoalie

	for i = 1, #exBossRankReward do
		local cfg = exBossRankReward[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = exBossRankReward[i - 1]

			break
		end
	end

	CenterRankModule.GetRankGoalie(Constant.RankingType.PlotChallengeBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function ChallengeDramaBossDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 10000)
end

function ChallengeDramaBossDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, ChallengeDramaBossDetailUIApi:GetString("RecommendPowerText", power2))
	self.TextPowerNum:SetActive(false)
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeDramaBossDetailUIApi:GetString("TextPower", power1, power2))
end

function ChallengeDramaBossDetailUI:OnBtnReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.PlotChallengeBossRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function ChallengeDramaBossDetailUI:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MazeBossChallengeDetailUIApi:GetString("TextNotice3"))

		return
	end

	local costID = self.cfgPlotGlobalData.ChallengeBossNeed[1]
	local costValue = self.cfgPlotGlobalData.ChallengeBossNeed[2]
	local haveNum = WarehouseModule.GetItemNumByCfgID(costID)

	if haveNum < costValue then
		NoticeModule.ShowNotice(21040078)

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	PlotChallengeModule.TriggerChallengeBoss(self.formationID)
end

function ChallengeDramaBossDetailUI:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.PlotChallenge)
end

function ChallengeDramaBossDetailUI:OnBtnTip()
	return
end

function ChallengeDramaBossDetailUI:OnShowRank()
	self.RankView:SetActive(true)
	self.BtnHideRank:SetActive(true)
end

function ChallengeDramaBossDetailUI:OnHideRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)
end

return ChallengeDramaBossDetailUI
