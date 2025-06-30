-- chunkname: @IQIGame\\UI\\FlightGameBossDetailUI.lua

local FlightGameBossDetailUI = {
	MonsterElementCells = {},
	FlightGameBossAffixPool = {},
	FlightGameBossAffixCells = {},
	RankCellPool = {}
}

FlightGameBossDetailUI = Base:Extend("FlightGameBossDetailUI", "IQIGame.Onigao.UI.FlightGameBossDetailUI", FlightGameBossDetailUI)

require("IQIGame.UIExternalApi.FlightGameBossDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local FlightChallengeBossRankCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameBossDetail.FlightChallengeBossRankCell")
local FlightGameBossAffixCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameBossDetail.FlightGameBossAffixCell")

function FlightGameBossDetailUI:OnInit()
	UGUIUtil.SetText(self.TitleName, FlightGameBossDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextChallengeBtn, FlightGameBossDetailUIApi:GetString("TextChallengeBtn"))

	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickBtnRankReward()
		self:OnClickBtnRankReward()
	end

	function self.DelegateOnClickBtnTip()
		self:OnClickBtnTip()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = FlightGameBossDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(FlightGameBossDetailUIApi:GetString("NoneRankText"))
	self.Mould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self.RuneModule:SetActive(false)

	self.FlightGameBossAffixPool = UIObjectPool.New(5, function()
		local cell = FlightGameBossAffixCell.New(UnityEngine.Object.Instantiate(self.RuneModule))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
	end)
end

function FlightGameBossDetailUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameBossDetailUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameBossDetailUI:GetBGM(userData)
	return nil
end

function FlightGameBossDetailUI:OnOpen(userData)
	self.cfgFlightChallengeControlData = CfgFlightChallengeControlTable[FlightChallengeModule.GlobalCid]

	self:UpdateView()
end

function FlightGameBossDetailUI:OnClose(userData)
	return
end

function FlightGameBossDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FlightGameBossDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function FlightGameBossDetailUI:OnPause()
	return
end

function FlightGameBossDetailUI:OnResume()
	return
end

function FlightGameBossDetailUI:OnCover()
	return
end

function FlightGameBossDetailUI:OnReveal()
	return
end

function FlightGameBossDetailUI:OnRefocus(userData)
	return
end

function FlightGameBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameBossDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.FlightGameBossAffixCells) do
		self.FlightGameBossAffixPool:Release(v)
	end

	self.FlightGameBossAffixCells = {}

	self.FlightGameBossAffixPool:Dispose()
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function FlightGameBossDetailUI:UpdateView()
	if not FlightChallengeModule.IsShow() then
		return
	end

	self:RefreshRank()
	self.FormationPanelController:UpdateView()
	UGUIUtil.SetText(self.TextBossName, self.cfgFlightChallengeControlData.BossName)

	local path = UIGlobalApi.GetImagePath(self.cfgFlightChallengeControlData.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	UGUIUtil.SetText(self.RuneTitle, FlightGameBossDetailUIApi:GetString("RuneTitle", FlightChallengeModule.dailyDupPOD.flightChallengePOD.record))

	local value = math.floor(FlightChallengeModule.dailyDupPOD.flightChallengePOD.record / self.cfgFlightChallengeControlData.BossAddRatio[1]) * self.cfgFlightChallengeControlData.BossAddRatio[2]

	value = value > self.cfgFlightChallengeControlData.BossAddLimit and self.cfgFlightChallengeControlData.BossAddLimit or value

	UGUIUtil.SetText(self.TextMaxRunes, FlightGameBossDetailUIApi:GetString("TextMaxRunes", value))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgFlightChallengeControlData.WeakType do
		local weakType = self.cfgFlightChallengeControlData.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:RefreshAffixBuff()
end

function FlightGameBossDetailUI:RefreshAffixBuff()
	for i, v in pairs(self.FlightGameBossAffixCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.FlightGameBossAffixPool:Release(v)
	end

	self.FlightGameBossAffixCells = {}

	for i = 1, #self.cfgFlightChallengeControlData.AffixBuff do
		local id = self.cfgFlightChallengeControlData.AffixBuff[i]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local runeSuitItem = self.FlightGameBossAffixPool:Obtain()

		runeSuitItem.View.transform:SetParent(self.RuneSort.transform, false)
		runeSuitItem.View:SetActive(true)
		runeSuitItem:SetData(cfgData)
		table.insert(self.FlightGameBossAffixCells, runeSuitItem)
	end
end

function FlightGameBossDetailUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.FlightChallengeBoss, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function FlightGameBossDetailUI:RefreshRankGoalie(myRanking, rankType)
	local flightBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(FlightChallengeModule.flightChallengeBossRankData) do
		table.insert(flightBossRankReward, v)

		if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
			cfgMyRank = v
		end
	end

	if cfgMyRank == nil then
		logError("myRanking " .. myRanking)

		return
	end

	table.sort(flightBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local cfgRankGoalie

	for i = 1, #flightBossRankReward do
		local cfg = flightBossRankReward[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = flightBossRankReward[i - 1]

			break
		end
	end

	CenterRankModule.GetRankGoalie(Constant.RankingType.FlightChallengeBoss, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function FlightGameBossDetailUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function FlightGameBossDetailUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = FlightChallengeBossRankCell.New(cellGo.gameObject)
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

function FlightGameBossDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 10000)
end

function FlightGameBossDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, FlightGameBossDetailUIApi:GetString("TextPowerNum", power2))
	UGUIUtil.SetText(self.TextCurrentNum, FlightGameBossDetailUIApi:GetString("TextCurrentNum", power1, power2))
end

function FlightGameBossDetailUI:OnClickChallengeBtn()
	if #PlayerModule.PlayerInfo.formations == 0 then
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

	FlightChallengeModule.FlightChallengeBoss(self.formationID)
end

function FlightGameBossDetailUI:OnClickBtnRankReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.FlightGameBossRankRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function FlightGameBossDetailUI:OnClickBtnTip()
	return
end

function FlightGameBossDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return FlightGameBossDetailUI
