-- chunkname: @IQIGame\\UI\\ChallengeWorldBossDetailUI.lua

local ChallengeWorldBossDetailUI = Base:Extend("ChallengeWorldBossDetailUI", "IQIGame.Onigao.UI.ChallengeWorldBossDetailUI", {
	currentSelect = 2,
	effectPlayId = 0,
	MonsterElementCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local ChallengeWorldBossRankCell = require("IQIGame.UI.ChallengeWorldBoss.ChallengeWorldBossRankCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")

function ChallengeWorldBossDetailUI:OnInit()
	UGUIUtil.SetText(self.TextShop, ChallengeWorldBossDetailUIApi:GetString("TextShop"))
	UGUIUtil.SetText(self.TextReward, ChallengeWorldBossDetailUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextLevelTitle, ChallengeWorldBossDetailUIApi:GetString("TextLevelTitle"))
	UGUIUtil.SetText(self.TextBtnKillReward, ChallengeWorldBossDetailUIApi:GetString("TextBtnKillReward"))
	UGUIUtil.SetText(self.TextChallengeBtn, ChallengeWorldBossDetailUIApi:GetString("TextChallengeBtn"))
	UGUIUtil.SetText(self.TextBtnBossTip, ChallengeWorldBossDetailUIApi:GetString("TextBtnBossTip"))
	UGUIUtil.SetText(self.Tips, ChallengeWorldBossDetailUIApi:GetString("Tips"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnReward()
		self:OnBtnReward()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end

	function self.delegateBtnKillReward()
		self:OnBtnKillReward()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateWorldBossBattleEnd(cfgInfo)
		self:OnUpDateWorldBoss(cfgInfo)
	end

	function self.delegateUpdateWorldBossDate(cfgInfo)
		self:OnUpDateWorldBoss(cfgInfo)
	end

	function self.delegateBtnBossTip()
		self:OnBtnBossTip()
	end

	function self.delegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	function self.delegateRefreshRankEvent()
		self:RefreshRank()
	end

	function self.delegateBtnExBossAffix()
		self:OnBtnExBossAffix()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.DelegateBtnShowRank()
		self:OnBtnShowRank()
	end

	function self.DelegateBtnHideRank()
		self:OnBtnHideRank()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = ChallengeWorldBossDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(ChallengeWorldBossDetailUIApi:GetString("NoneRankText"))

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.toggles = {}

	for i = 1, 2 do
		self["Toggle" .. i]:GetComponent("ToggleHelperComponent").text = ChallengeWorldBossDetailUIApi:GetString("ToggleStr", i)

		local toggle = self["Toggle" .. i]:GetComponent("Toggle")

		toggle.group = self.ToggleGroup:GetComponent("ToggleGroup")
		toggle.isOn = false
		self.toggles[i] = toggle
	end

	self.myRankRender = ChallengeWorldBossRankCell.__New(self.MyRankRender)
	self.myRankRender.showFormationUI = false
end

function ChallengeWorldBossDetailUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossDetailUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossDetailUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossDetailUI:OnOpen(userData)
	self.cfgDailyDup = userData
	self.cfgWorldBoss = ChallengeWorldBossModule.GetWorldBossData()
	self.currentSelect = 2
	self.toggles[self.currentSelect].isOn = true

	self:UpdateView()
	self:RefreshRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)

	self.effectPlayId = GameEntry.Effect:PlayUIMountPointEffect(self.cfgWorldBoss.BossUiEffect, 50000, 0, self.Effect, self.UIController:GetComponent("Canvas").sortingOrder + 1)

	ChallengeWorldBossModule.SaveOpenWorldBossPrefs()
end

function ChallengeWorldBossDetailUI:OnClose(userData)
	GameEntry.Effect:StopEffect(self.effectPlayId)

	self.effectPlayId = 0
end

function ChallengeWorldBossDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.BtnKillReward:GetComponent("Button").onClick:AddListener(self.delegateBtnKillReward)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnBossTip:GetComponent("Button").onClick:AddListener(self.delegateBtnBossTip)
	self.ExBossAffix:GetComponent("Button").onClick:AddListener(self.delegateBtnExBossAffix)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	self.BtnShowRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnHideRank)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateOnToggleChange)
	end

	EventDispatcher.AddEventListener(EventID.UpdateWorldBossBattleEnd, self.delegateUpdateWorldBossBattleEnd)
	EventDispatcher.AddEventListener(EventID.UpdateWorldBossData, self.delegateUpdateWorldBossDate)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function ChallengeWorldBossDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.BtnKillReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnKillReward)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnBossTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBossTip)
	self.ExBossAffix:GetComponent("Button").onClick:RemoveListener(self.delegateBtnExBossAffix)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	self.BtnShowRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShowRank)
	self.BtnHideRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHideRank)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateOnToggleChange)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateWorldBossBattleEnd, self.delegateUpdateWorldBossBattleEnd)
	EventDispatcher.RemoveEventListener(EventID.UpdateWorldBossData, self.delegateUpdateWorldBossDate)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.delegateRefreshRankEvent)
end

function ChallengeWorldBossDetailUI:OnPause()
	return
end

function ChallengeWorldBossDetailUI:OnResume()
	return
end

function ChallengeWorldBossDetailUI:OnCover()
	return
end

function ChallengeWorldBossDetailUI:OnReveal()
	return
end

function ChallengeWorldBossDetailUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()
	self.RankingUIController:Dispose()
	ChallengeWorldBossRankCell.DisposeIn(self)

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()
	self.myRankRender:Dispose()
end

function ChallengeWorldBossDetailUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeWorldBossDetailUI)
end

function ChallengeWorldBossDetailUI:OnUpDateWorldBoss(cfgInfo)
	self.cfgDailyDup = cfgInfo
	self.cfgWorldBoss = ChallengeWorldBossModule.GetWorldBossData()

	self:UpdateView()
end

function ChallengeWorldBossDetailUI:RefreshRank()
	ChallengeWorldBossModule.GetRanking(50, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		if self.currentSelect == 1 then
			self.RankingUIController.MyRankNode:SetActive(false)
			self:ShowRank(rankId, isOpen, lastRankings, myRanking, myScore, customData, rankType)
		else
			self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

			if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
				self.RankingUIController.RankingGoalieGo:SetActive(false)
			else
				self:RefreshRankGoalie(myRanking, rankType)
			end

			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function ChallengeWorldBossDetailUI:RefreshRankGoalie(myRanking, rankType)
	local worldBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgWorldBossRewardTable) do
		table.insert(worldBossRankReward, v)

		if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
			cfgMyRank = v
		end
	end

	table.sort(worldBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local cfgRankGoalie

	for i = 1, #worldBossRankReward do
		local cfg = worldBossRankReward[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = worldBossRankReward[i - 1]

			break
		end
	end

	ChallengeWorldBossModule.GetRankGoalie(cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function ChallengeWorldBossDetailUI:UpdateView()
	if self.cfgDailyDup then
		UGUIUtil.SetText(self.TitleName, self.cfgDailyDup.Name)
		self.FormationPanelController:UpdateView()
		UGUIUtil.SetText(self.TextLevel, ChallengeWorldBossDetailUIApi:GetString("BossLevel", self.cfgWorldBoss.BossLevel, self.cfgWorldBoss.IsExBoss))

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

		if self.cfgWorldBoss.IsExBoss then
			local buffOrder = ChallengeWorldBossModule.worldBossDupPOD.worldBossPOD.buffOrder + 1

			if buffOrder > #self.cfgWorldBoss.Affix then
				buffOrder = #self.cfgWorldBoss.Affix
			end

			local id = self.cfgWorldBoss.Affix[buffOrder]
			local cfgData = CfgSkillSpecialEffectExplainTable[id]

			UGUIUtil.SetText(self.TextExBossAffix, cfgData.EffectName)
			self.BtnKillReward:SetActive(false)
			self.ExBossAffix:SetActive(true)
			self.ExBossEffect:SetActive(true)
		else
			self.BtnKillReward:SetActive(true)
			self.ExBossAffix:SetActive(false)
			self.ExBossEffect:SetActive(false)
		end

		self:RefreshSelectBtn()
	end
end

function ChallengeWorldBossDetailUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function ChallengeWorldBossDetailUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local rankingItem = ChallengeWorldBossRankCell.PackageOrReuseView(self, cellGo.gameObject)

	rankingItem.lastRanking = self.currentSelect == 1

	if index == 0 then
		local tab = string.split(customData, ",")
		local bossLv = tab[1]
		local hurt = tab[2]

		if bossLv == "" then
			bossLv = "--"
		end

		if hurt == nil then
			hurt = 0
		end

		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, bossLv, hurt, customData, rankType)
		self.myRankRender:SetMyData(myRanking, bossLv, hurt, customData, rankType)
	elseif index == -1 then
		rankingItem.showFormationUI = false

		rankingItem:SetGoalieData(myScore, myRanking, rankType)
		self.RankingUIController.RankingGoalieGo:SetActive(true)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

function ChallengeWorldBossDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgWorldBoss.RecommendPower)
end

function ChallengeWorldBossDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, MazeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeUIApi:GetString("TextPower", power1, power2))
end

function ChallengeWorldBossDetailUI:OnBtnChallenge()
	local isOpenTime = DailyDupModule.IsOpenTime(self.cfgDailyDup.Id)

	if isOpenTime == false then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeWorldBossDetailUIApi:GetString("TextNotice2"))

		return
	end

	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeWorldBossDetailUIApi:GetString("TextNotice3"))

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

	self:ChallengeDupFun()
end

function ChallengeWorldBossDetailUI:ChallengeDupFun()
	ChallengeWorldBossModule.Attack(self.cfgDailyDup.Id, self.formationID, false, self.cfgWorldBoss.Id)
end

function ChallengeWorldBossDetailUI:OnBtnReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.ChallengeWorldBossRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function ChallengeWorldBossDetailUI:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 8000)
end

function ChallengeWorldBossDetailUI:OnToggleChange(isOn)
	if isOn then
		local index

		for i = 1, #self.toggles do
			local toggle = self.toggles[i]

			if toggle.isOn == true then
				index = i

				break
			end
		end

		if self.currentSelect ~= index then
			self.currentSelect = index

			self:RefreshRank()
		end
	end
end

function ChallengeWorldBossDetailUI:OnBtnShop()
	JumpModule.Jump(10202020)
end

function ChallengeWorldBossDetailUI:OnBtnKillReward()
	UIModule.Open(Constant.UIControllerName.KillMonsterTipUI, Constant.UILayer.UI, self.cfgWorldBoss)
end

function ChallengeWorldBossDetailUI:OnBtnBossTip()
	UIModule.Open(Constant.UIControllerName.ChallengeWorldBossTipsUI, Constant.UILayer.UI)
end

function ChallengeWorldBossDetailUI:OnBtnExBossAffix()
	local buffOrder = ChallengeWorldBossModule.worldBossDupPOD.worldBossPOD.buffOrder + 1

	if buffOrder > #self.cfgWorldBoss.Affix then
		buffOrder = #self.cfgWorldBoss.Affix
	end

	local id = self.cfgWorldBoss.Affix[buffOrder]
	local cfgData = CfgSkillSpecialEffectExplainTable[id]
	local describeStr = LinkTipUIApi:GetString("goDesc", cfgData.Describe)

	UIModule.Open(Constant.UIControllerName.MagicWaxMuseumTipUI, Constant.UILayer.UI, {
		name = cfgData.EffectName,
		describe = describeStr,
		refTrans = self.ExBossAffix.transform
	})
end

function ChallengeWorldBossDetailUI:GetMaxLevel()
	local cfgWordBoss = ChallengeWorldBossModule.GetWorldBossData()
	local bossLevel = ChallengeWorldBossModule.worldBossDupPOD.worldBossPOD.typeLevel[cfgWordBoss.BossType] or 1

	return bossLevel
end

function ChallengeWorldBossDetailUI:GetPreLevelBoss()
	local selectLv = self.cfgWorldBoss.BossLevel
	local preLv = selectLv - 1

	if preLv <= 0 then
		preLv = 1
	end

	for i, v in pairsCfg(CfgWorldBossTable) do
		if v.BossOrder == self.cfgWorldBoss.BossOrder and preLv == v.BossLevel then
			return v
		end
	end

	return nil
end

function ChallengeWorldBossDetailUI:GetNextLevelBoss()
	local selectLv = self.cfgWorldBoss.BossLevel
	local nextLv = selectLv + 1
	local maxLv = self:GetMaxLevel()

	if maxLv < nextLv then
		nextLv = maxLv
	end

	for i, v in pairsCfg(CfgWorldBossTable) do
		if v.BossOrder == self.cfgWorldBoss.BossOrder and nextLv == v.BossLevel then
			return v
		end
	end

	return nil
end

function ChallengeWorldBossDetailUI:RefreshSelectBtn()
	self.BtnLeft:SetActive(self.cfgWorldBoss.BossLevel > 1)

	local maxLv = self:GetMaxLevel()

	self.BtnRight:SetActive(maxLv > self.cfgWorldBoss.BossLevel)
	self.Tips:SetActive(maxLv > self.cfgWorldBoss.BossLevel)
end

function ChallengeWorldBossDetailUI:OnBtnLeft()
	self.cfgWorldBoss = self:GetPreLevelBoss()

	self:UpdateView()
end

function ChallengeWorldBossDetailUI:OnBtnRight()
	self.cfgWorldBoss = self:GetNextLevelBoss()

	self:UpdateView()
end

function ChallengeWorldBossDetailUI:OnBtnShowRank()
	self.RankView:SetActive(true)
	self.BtnHideRank:SetActive(true)
end

function ChallengeWorldBossDetailUI:OnBtnHideRank()
	self.RankView:SetActive(false)
	self.BtnHideRank:SetActive(false)
end

return ChallengeWorldBossDetailUI
