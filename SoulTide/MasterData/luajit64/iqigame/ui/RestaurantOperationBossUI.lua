-- chunkname: @IQIGame\\UI\\RestaurantOperationBossUI.lua

local RestaurantOperationBossUI = {
	RankCellPool = {},
	MonsterElementCells = {},
	BossAffixPool = {},
	BossAffixCells = {}
}

RestaurantOperationBossUI = Base:Extend("RestaurantOperationBossUI", "IQIGame.Onigao.UI.RestaurantOperationBossUI", RestaurantOperationBossUI)

require("IQIGame.UIExternalApi.RestaurantOperationBossUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local ROBossRankCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationBoss.ROBossRankCell")
local ROBossAffixCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationBoss.ROBossAffixCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")

function RestaurantOperationBossUI:OnInit()
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

	local labels = RestaurantOperationBossUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(RestaurantOperationBossUIApi:GetString("NoneRankText"))
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

	self.BossAffixPool = UIObjectPool.New(5, function()
		local cell = ROBossAffixCell.New(UnityEngine.Object.Instantiate(self.RuneModule))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
	end)
end

function RestaurantOperationBossUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationBossUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationBossUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationBossUI:GetBGM(userData)
	return nil
end

function RestaurantOperationBossUI:OnOpen(userData)
	self.cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]

	self:UpdateView()
end

function RestaurantOperationBossUI:OnClose(userData)
	return
end

function RestaurantOperationBossUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantOperationBossUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function RestaurantOperationBossUI:OnPause()
	return
end

function RestaurantOperationBossUI:OnResume()
	return
end

function RestaurantOperationBossUI:OnCover()
	return
end

function RestaurantOperationBossUI:OnReveal()
	return
end

function RestaurantOperationBossUI:OnRefocus(userData)
	return
end

function RestaurantOperationBossUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationBossUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationBossUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationBossUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationBossUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.BossAffixCells) do
		self.BossAffixPool:Release(v)
	end

	self.BossAffixCells = {}

	self.BossAffixPool:Dispose()
	self.RankingUIController:Dispose()

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end
end

function RestaurantOperationBossUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RestaurantOperationBossUI:UpdateView()
	if not RestaurantOperationModule.IsShow() then
		return
	end

	self:RefreshRank()
	self.FormationPanelController:UpdateView()
	UGUIUtil.SetText(self.TextBossName, self.cfgControlData.BossName)

	local path = UIGlobalApi.GetImagePath(self.cfgControlData.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgControlData.WeakType do
		local weakType = self.cfgControlData.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:RefreshAffixBuff()
end

function RestaurantOperationBossUI:RefreshAffixBuff()
	for i, v in pairs(self.BossAffixCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.BossAffixPool:Release(v)
	end

	self.BossAffixCells = {}

	for i = 1, #self.cfgControlData.AffixBuff do
		local id = self.cfgControlData.AffixBuff[i]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local runeSuitItem = self.BossAffixPool:Obtain()

		runeSuitItem.View.transform:SetParent(self.RuneSort.transform, false)
		runeSuitItem.View:SetActive(true)
		runeSuitItem:SetData(cfgData)
		table.insert(self.BossAffixCells, runeSuitItem)
	end
end

function RestaurantOperationBossUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationExBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function RestaurantOperationBossUI:RefreshRankGoalie(myRanking, rankType)
	local bossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(RestaurantOperationModule.ROBossRankData) do
		table.insert(bossRankReward, v)

		if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
			cfgMyRank = v
		end
	end

	if cfgMyRank == nil then
		logError("ExBoss排行奖励错误,找不到对应配置 我的排名 myRanking = " .. myRanking)

		return
	end

	table.sort(bossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local cfgRankGoalie

	for i = 1, #bossRankReward do
		local cfg = bossRankReward[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = bossRankReward[i - 1]

			break
		end
	end

	CenterRankModule.GetRankGoalie(Constant.RankingType.RestaurantOperationExBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function RestaurantOperationBossUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function RestaurantOperationBossUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = ROBossRankCell.New(cellGo.gameObject)
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

function RestaurantOperationBossUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 10000)
end

function RestaurantOperationBossUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, RestaurantOperationBossUIApi:GetString("TextPowerNum", power2))
	UGUIUtil.SetText(self.TextCurrentNum, RestaurantOperationBossUIApi:GetString("TextCurrentNum", power1, power2))
end

function RestaurantOperationBossUI:OnClickBtnRankReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationBossRankRewardUI, Constant.UILayer.UI, {
			MyRanking = self.myRanking,
			RankType = self.rankType
		})
	end
end

function RestaurantOperationBossUI:OnClickBtnTip()
	return
end

function RestaurantOperationBossUI:OnClickChallengeBtn()
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

	RestaurantOperationModule.BossTraining(self.formationID)
	log("发起EXBoss挑战")
end

return RestaurantOperationBossUI
