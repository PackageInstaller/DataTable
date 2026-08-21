-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGMazeBossChallengeDetail\\HorizontalRPGMazeBossChallengeDetailUIController.lua

local HorizontalRPGMazeBossChallengeDetailUIController = {
	MonsterElementCells = {},
	RankCellPool = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local HorizontalRPGBossRankCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMazeBossChallengeDetail.HorizontalRPGBossRankCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")

function HorizontalRPGMazeBossChallengeDetailUIController.New(uiController)
	local obj = Clone(HorizontalRPGMazeBossChallengeDetailUIController)

	obj:__Init(uiController)

	return obj
end

function HorizontalRPGMazeBossChallengeDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function HorizontalRPGMazeBossChallengeDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnInit()
	UGUIUtil.SetText(self.TitleName, HorizontalRPGMazeBossChallengeDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextChallengeBtn, HorizontalRPGMazeBossChallengeDetailUIApi:GetString("TextChallengeBtn"))

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = HorizontalRPGMazeBossChallengeDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(HorizontalRPGMazeBossChallengeDetailUIApi:GetString("NoneRankText"))

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

	function self.DelegateBtnShowRank()
		self:OnShowRank()
	end

	function self.DelegateBtnHideRank()
		self:OnHideRank()
	end

	function self.DelegateBtnReward()
		self:OnBtnReward()
	end

	self.myRankRender = HorizontalRPGBossRankCell.New(self.MyRankRender)
	self.myRankRender.showFormationUI = false
end

function HorizontalRPGMazeBossChallengeDetailUIController:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMazeBossChallengeDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeBossChallengeDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeBossChallengeDetailUIController:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnOpen(userData)
	self.cfgGlobalData = userData

	self:UpdateView()
	self:RefreshRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnClose(userData)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnShowRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnHideRank)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnReward)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnShowRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHideRank)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnPause()
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnResume()
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnCover()
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnReveal()
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnRefocus(userData)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnDestroy()
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
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HorizontalRPGMazeBossChallengeDetailUI)
end

function HorizontalRPGMazeBossChallengeDetailUIController:UpdateView()
	UGUIUtil.SetText(self.TextBossName, self.cfgGlobalData.EXBossName)

	local path = UIGlobalApi.GetImagePath(self.cfgGlobalData.EXBossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))
	self.FormationPanelController:UpdateView()

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local sortTab = PlotChallengeModule.GetMonsterWeakTypes(self.cfgGlobalData.EXBossTeam)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end
end

function HorizontalRPGMazeBossChallengeDetailUIController:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function HorizontalRPGMazeBossChallengeDetailUIController:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = HorizontalRPGBossRankCell.New(cellGo.gameObject)
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

function HorizontalRPGMazeBossChallengeDetailUIController:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.HorizontalRPGMazeEXBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function HorizontalRPGMazeBossChallengeDetailUIController:RefreshRankGoalie(myRanking, rankType)
	local exBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgHorizontalRPGEXBossRewardTable) do
		if v.Group == HorizontalRPGModule.globalCid then
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

	CenterRankModule.GetRankGoalie(Constant.RankingType.HorizontalRPGMazeEXBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 10000)
end

function HorizontalRPGMazeBossChallengeDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, HorizontalRPGMazeBossChallengeDetailUIApi:GetString("RecommendPowerText", power2))
	self.TextPowerNum:SetActive(false)
	UGUIUtil.SetText(self.TextCurrentNum, HorizontalRPGMazeBossChallengeDetailUIApi:GetString("TextPower", power1, power2))
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MazeBossChallengeDetailUIApi:GetString("TextNotice3"))

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

	HorizontalRPGModule.BossTraining(self.formationID)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnBtnTip()
	return
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnBtnReward()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGBossRewardUI, Constant.UILayer.UI, {
		self.myRanking,
		self.rankType
	})
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnShowRank()
	self.RankView:SetActive(true)
	self.BtnHideRank:SetActive(true)
end

function HorizontalRPGMazeBossChallengeDetailUIController:OnHideRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)
end

return HorizontalRPGMazeBossChallengeDetailUIController
