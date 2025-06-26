-- chunkname: @IQIGame\\UI\\RPGActivityUI\\MazeBossChallengeDetailUIController.lua

local MazeBossChallengeDetailUIController = {
	failureCD = 0,
	MonsterElementCells = {},
	RankCellPool = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local MazeEXBossRankCell = require("IQIGame.UI.RpgMaze.MazeEXBossRankCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")

function MazeBossChallengeDetailUIController.New(uiController)
	local obj = Clone(MazeBossChallengeDetailUIController)

	obj:__Init(uiController)

	return obj
end

function MazeBossChallengeDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function MazeBossChallengeDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function MazeBossChallengeDetailUIController:OnInit()
	UGUIUtil.SetText(self.TitleName, MazeBossChallengeDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextReward, MazeBossChallengeDetailUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextChallengeBtn, MazeBossChallengeDetailUIApi:GetString("TextChallengeBtn"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateTime()
		self:OnUpdateTime()
	end

	function self.delegateUpdateChallengeBoss()
		self:OnUpdateChallengeBoss()
	end

	function self.delegateUpdateExBossCD()
		self:OnUpdateExBossCD()
	end

	function self.delegateBtnReward()
		self:OnBtnReward()
	end

	function self.delegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = MazeBossChallengeDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(MazeBossChallengeDetailUIApi:GetString("NoneRankText"))

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.timer = Timer.New(self.delegateUpdateTime, 1, -1)
end

function MazeBossChallengeDetailUIController:GetPreloadAssetPaths()
	return nil
end

function MazeBossChallengeDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBossChallengeDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function MazeBossChallengeDetailUIController:GetBGM(userData)
	return nil
end

function MazeBossChallengeDetailUIController:OnOpen(userData)
	self:UpdateView()
	self:RefreshRank()
end

function MazeBossChallengeDetailUIController:OnClose(userData)
	return
end

function MazeBossChallengeDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
	EventDispatcher.AddEventListener(EventID.RpgMazeUpdateExBossCD, self.delegateUpdateExBossCD)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function MazeBossChallengeDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
	EventDispatcher.RemoveEventListener(EventID.RpgMazeUpdateExBossCD, self.delegateUpdateExBossCD)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function MazeBossChallengeDetailUIController:OnPause()
	return
end

function MazeBossChallengeDetailUIController:OnResume()
	return
end

function MazeBossChallengeDetailUIController:OnCover()
	return
end

function MazeBossChallengeDetailUIController:OnReveal()
	return
end

function MazeBossChallengeDetailUIController:OnRefocus(userData)
	return
end

function MazeBossChallengeDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBossChallengeDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBossChallengeDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBossChallengeDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBossChallengeDetailUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

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
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function MazeBossChallengeDetailUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MazeBossChallengeDetailUI)
end

function MazeBossChallengeDetailUIController:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.MazeEXBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function MazeBossChallengeDetailUIController:RefreshRankGoalie(myRanking, rankType)
	local exBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgRPGMazeExBossRewardTable) do
		if v.Group == RpgMazeModule.DailyDupPOD.common.openCount then
			table.insert(exBossRankReward, v)

			if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
				cfgMyRank = v
			end
		end
	end

	if cfgMyRank == nil then
		logError("myRanking " .. myRanking)

		return
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

	CenterRankModule.GetRankGoalie(Constant.RankingType.MazeEXBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function MazeBossChallengeDetailUIController:OnUpdateChallengeBoss()
	self:UpdateView()
end

function MazeBossChallengeDetailUIController:OnUpdateExBossCD()
	self:UpdateView()
end

function MazeBossChallengeDetailUIController:UpdateView()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	self.cfgWorldBoss = CfgRPGMazeExBossTable[cfgRPGMazeControlData.ExBoss]

	self.FormationPanelController:UpdateView()

	local cfgMonster = CfgMonsterTable[self.cfgWorldBoss.Monster]

	UGUIUtil.SetText(self.TextBossName, cfgMonster.Name)

	local path = UIGlobalApi.GetImagePath(self.cfgWorldBoss.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgWorldBoss.WeakType do
		local weakType = self.cfgWorldBoss.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:ShowCD()
end

function MazeBossChallengeDetailUIController:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function MazeBossChallengeDetailUIController:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = MazeEXBossRankCell.New(cellGo.gameObject)
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

function MazeBossChallengeDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgWorldBoss.RecommendPower)
end

function MazeBossChallengeDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, MazeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeUIApi:GetString("TextPower", power1, power2))
end

function MazeBossChallengeDetailUIController:OnBtnChallenge()
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

	if self.failureCD > 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MazeBossChallengeDetailUIApi:GetString("TimeCD"))

		return
	end

	self:ChallengeDupFun()
end

function MazeBossChallengeDetailUIController:ChallengeDupFun()
	RpgMazeModule.ChallengeExBoss(self.formationID)
end

function MazeBossChallengeDetailUIController:ShowCD()
	self.timer:Stop()

	self.failureCD = self.cfgWorldBoss.ChallengeCD - (PlayerModule.GetServerTime() - RpgMazeModule.DailyDupPOD.rpgMazePOD.lastAttackExBossTime)

	if self.failureCD > 0 then
		self.timer:Start()
	end

	self:OnUpdateTime()
end

function MazeBossChallengeDetailUIController:OnUpdateTime()
	self.failureCD = self.cfgWorldBoss.ChallengeCD - (PlayerModule.GetServerTime() - RpgMazeModule.DailyDupPOD.rpgMazePOD.lastAttackExBossTime)

	if self.failureCD >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, MazeBossChallengeDetailUIApi:GetString("TextTimeCD", GetFormatTime(self.failureCD)))
		self.TimeView:SetActive(true)
	else
		self.TimeView:SetActive(false)
		self.timer:Stop()
	end
end

function MazeBossChallengeDetailUIController:OnBtnReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.MazeExBossRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function MazeBossChallengeDetailUIController:OnBtnTip()
	return
end

return MazeBossChallengeDetailUIController
