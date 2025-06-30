-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreExBossChallengeUIController.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local DualTeamFormationView = require("IQIGame.UI.DualTeamExplore.DualTeamBossChallenge.DualTeamFormationView")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local DualTeamBossRankCell = require("IQIGame.UI.DualTeamExplore.DualTeamBossChallenge.DualTeamBossRankCell")
local DualTeamExploreExBossChallengeUIController = {
	failureCD = 0,
	selectIndex = 1,
	RankCellPool = {},
	MonsterElementCells = {}
}

function DualTeamExploreExBossChallengeUIController.New(uiController)
	local obj = Clone(DualTeamExploreExBossChallengeUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreExBossChallengeUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreExBossChallengeUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreExBossChallengeUIController:OnInit()
	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickBtnTip()
		self:OnClickBtnTip()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnChangeToggle(isOn)
		self:OnValueChanged(isOn)
	end

	function self.DelegateOnClickBtnRankReward()
		self:OnClickBtnRankReward()
	end

	function self.DelegateUpdateDailyDup()
		self:OnUpdateDailyDup()
	end

	function self.DelegateUpdateTime()
		self:OnUpdateTime()
	end

	UGUIUtil.SetText(self.TitleName, DualTeamExploreExBossChallengeUIApi:GetString("TitleName", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TextChallengeBtn, DualTeamExploreExBossChallengeUIApi:GetString("TextChallengeBtn"))
	UGUIUtil.SetText(self.TextFormation, DualTeamExploreExBossChallengeUIApi:GetString("TextFormation"))

	self.Toggle1:GetComponent("ToggleHelperComponent").text = DualTeamExploreExBossChallengeUIApi:GetString("ToggleTeam", 1)
	self.Toggle2:GetComponent("ToggleHelperComponent").text = DualTeamExploreExBossChallengeUIApi:GetString("ToggleTeam", 2)
	self.dualTeamFormationView = DualTeamFormationView.New(self.DualTeamFormation)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = DualTeamExploreExBossChallengeUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(DualTeamExploreExBossChallengeUIApi:GetString("NoneRankText"))

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.timer = Timer.New(self.DelegateUpdateTime, 1, -1)
end

function DualTeamExploreExBossChallengeUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreExBossChallengeUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreExBossChallengeUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreExBossChallengeUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreExBossChallengeUIController:OnOpen(userData)
	self:UpDateView()
end

function DualTeamExploreExBossChallengeUIController:OnClose(userData)
	return
end

function DualTeamExploreExBossChallengeUIController:OnAddListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRankReward)

	for i = 1, 2 do
		self["Toggle" .. i]:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnChangeToggle)
	end

	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreExBossChallengeUIController:OnRemoveListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRankReward)

	for i = 1, 2 do
		self["Toggle" .. i]:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnChangeToggle)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreExBossChallengeUIController:OnPause()
	return
end

function DualTeamExploreExBossChallengeUIController:OnResume()
	return
end

function DualTeamExploreExBossChallengeUIController:OnCover()
	return
end

function DualTeamExploreExBossChallengeUIController:OnReveal()
	return
end

function DualTeamExploreExBossChallengeUIController:OnRefocus(userData)
	return
end

function DualTeamExploreExBossChallengeUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreExBossChallengeUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreExBossChallengeUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreExBossChallengeUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreExBossChallengeUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreExBossChallengeUIController:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.DualTeamExploreExBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function DualTeamExploreExBossChallengeUIController:RefreshRankGoalie(myRanking, rankType)
	local exBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgDualTeamExploreEXBossRewardTable) do
		if v.Group == DualTeamExploreModule.DailyDupPOD.common.openCount then
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

	CenterRankModule.GetRankGoalie(Constant.RankingType.DualTeamExploreExBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function DualTeamExploreExBossChallengeUIController:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function DualTeamExploreExBossChallengeUIController:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = DualTeamBossRankCell.New(cellGo.gameObject)
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

function DualTeamExploreExBossChallengeUIController:OnUpdateDailyDup()
	self:UpDateView()
end

function DualTeamExploreExBossChallengeUIController:UpDateView()
	if not DualTeamExploreModule.IsShow() then
		return
	end

	self:RefreshRank()

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self.cfgBoss1 = CfgDualTeamExploreEXBossTable[cfgDualTeamExploreControlData.ExBoss1]
	self.cfgBoss2 = CfgDualTeamExploreEXBossTable[cfgDualTeamExploreControlData.ExBoss2]

	local path1 = UIGlobalApi.GetImagePath(self.cfgBoss1.BossBg)

	AssetUtil.LoadImage(self, path1, self.ImgBoss1:GetComponent("Image"))

	local path2 = UIGlobalApi.GetImagePath(self.cfgBoss2.BossBg)

	AssetUtil.LoadImage(self, path2, self.ImgBoss2:GetComponent("Image"))

	self["Toggle" .. self.selectIndex]:GetComponent("Toggle").isOn = true

	self:ShowSelectTeam()
end

function DualTeamExploreExBossChallengeUIController:OnValueChanged(isOn)
	for i = 1, 2 do
		local toggle = self["Toggle" .. i]:GetComponent("Toggle")

		if toggle.isOn == true then
			self.selectIndex = i

			break
		end
	end

	self:ShowSelectTeam()
end

function DualTeamExploreExBossChallengeUIController:ShowSelectTeam()
	self.ImgBoss1:SetActive(self.selectIndex == 1)
	self.ImgBoss2:SetActive(self.selectIndex == 2)

	local cfgBoss = self.cfgBoss1
	local exBossFormationInfo = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossFormationInfo1
	local exBossScore = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossScore1

	if self.selectIndex == 2 then
		cfgBoss = self.cfgBoss2
		exBossFormationInfo = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossFormationInfo2
		exBossScore = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossScore2
	end

	local cfgMonster = CfgMonsterTable[cfgBoss.Monster]

	UGUIUtil.SetText(self.TextBossName, cfgMonster.Name)
	UGUIUtil.SetText(self.TextPowerNum, DualTeamExploreExBossChallengeUIApi:GetString("RecommendPowerText", cfgBoss.RecommendPower))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #cfgBoss.WeakType do
		local weakType = cfgBoss.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	if exBossFormationInfo then
		self.dualTeamFormationView:SetPrefabData(exBossFormationInfo.soulPrefabs)
	else
		self.dualTeamFormationView:SetPrefabData(nil)
	end

	exBossScore = exBossScore == nil and 0 or exBossScore

	UGUIUtil.SetText(self.TextMaxScore, DualTeamExploreExBossChallengeUIApi:GetString("TextMaxScore", exBossScore))
	self:ShowCD()
end

function DualTeamExploreExBossChallengeUIController:ShowCD()
	self.timer:Stop()

	if self.selectIndex == 1 then
		self.failureCD = self.cfgBoss1.ChallengeCD - (PlayerModule.GetServerTime() - DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime1)
	else
		self.failureCD = self.cfgBoss2.ChallengeCD - (PlayerModule.GetServerTime() - DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime2)
	end

	if self.failureCD > 0 then
		self.timer:Start()
	end

	self:OnUpdateTime()
end

function DualTeamExploreExBossChallengeUIController:OnUpdateTime()
	if self.selectIndex == 1 then
		self.failureCD = self.cfgBoss1.ChallengeCD - (PlayerModule.GetServerTime() - DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime1)
	else
		self.failureCD = self.cfgBoss2.ChallengeCD - (PlayerModule.GetServerTime() - DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime2)
	end

	if self.failureCD >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, DualTeamExploreExBossChallengeUIApi:GetString("TextTimeCD", GetFormatTime(self.failureCD)))
		self.TimeView:SetActive(true)
	else
		self.TimeView:SetActive(false)
		self.timer:Stop()
	end
end

function DualTeamExploreExBossChallengeUIController:OnClickChallengeBtn()
	local cfgDailyDupData = CfgDailyDupTable[DualTeamExploreModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = DualTeamExploreModule.DailyDupPOD.common.openDate
	local accessLevelEndTime = openDate + cfgDailyDupData.AccessibleTime
	local isInChallengeLimitTime = openDate <= currentServerTime and currentServerTime <= accessLevelEndTime

	if not isInChallengeLimitTime then
		NoticeModule.ShowNotice(84500004)

		return
	end

	local cfgBossData = self.cfgBoss1

	if self.selectIndex == 2 then
		cfgBossData = self.cfgBoss2
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreExBossDetailUI, Constant.UILayer.UI, {
		CfgBoss = cfgBossData,
		BossIndex = self.selectIndex
	})
end

function DualTeamExploreExBossChallengeUIController:OnClickBtnTip()
	return
end

function DualTeamExploreExBossChallengeUIController:OnClickBtnRankReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.DualTeamExploreExBossRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function DualTeamExploreExBossChallengeUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreExBossChallengeUIController
