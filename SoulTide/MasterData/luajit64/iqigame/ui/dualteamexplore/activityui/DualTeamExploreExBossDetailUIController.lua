-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreExBossDetailUIController.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local DualTeamExploreExBossDetailUIController = {
	failureCD = 0,
	isShowTap = false,
	MonsterElementCells = {},
	MonsterHeadCells = {}
}

function DualTeamExploreExBossDetailUIController.New(uiController)
	local obj = Clone(DualTeamExploreExBossDetailUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreExBossDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreExBossDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreExBossDetailUIController:OnInit()
	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickBtnTip()
		self:OnClickBtnTip()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateUpdateTime()
		self:OnUpdateTime()
	end

	function self.DelegateUpdateDailyDup()
		self:OnUpdateDailyDup()
	end

	UGUIUtil.SetText(self.TitleName, DualTeamExploreExBossDetailUIApi:GetString("TitleName", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TextWeakness, DualTeamExploreExBossDetailUIApi:GetString("TextWeakness"))
	UGUIUtil.SetText(self.TextChallengeBtn, DualTeamExploreExBossDetailUIApi:GetString("TextChallengeBtn"))

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	self.Mould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetMonsterHeadCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
	self.timer = Timer.New(self.DelegateUpdateTime, 1, -1)
end

function DualTeamExploreExBossDetailUIController:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function DualTeamExploreExBossDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreExBossDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreExBossDetailUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreExBossDetailUIController:OnOpen(userData)
	self.cfgBoss = userData.CfgBoss
	self.index = userData.BossIndex

	self:UpdateView()
end

function DualTeamExploreExBossDetailUIController:OnClose(userData)
	return
end

function DualTeamExploreExBossDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreExBossDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreExBossDetailUIController:OnPause()
	return
end

function DualTeamExploreExBossDetailUIController:OnResume()
	return
end

function DualTeamExploreExBossDetailUIController:OnCover()
	return
end

function DualTeamExploreExBossDetailUIController:OnReveal()
	return
end

function DualTeamExploreExBossDetailUIController:OnRefocus(userData)
	return
end

function DualTeamExploreExBossDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreExBossDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreExBossDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreExBossDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreExBossDetailUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreExBossDetailUIController:OnUpdateDailyDup()
	self:UpdateView()
end

function DualTeamExploreExBossDetailUIController:UpdateView()
	self.FormationPanelController:UpdateView()

	local cfgMonster = CfgMonsterTable[self.cfgBoss.Monster]

	UGUIUtil.SetText(self.TextBossName, cfgMonster.Name)

	local path = UIGlobalApi.GetImagePath(self.cfgBoss.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgBoss.WeakType do
		local weakType = self.cfgBoss.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:UpdateMonsterCells(self.cfgBoss.MonsterTeam)
	self:ShowCD()
end

function DualTeamExploreExBossDetailUIController:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(monsterID)
				self:OnClickMonsterCell(monsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function DualTeamExploreExBossDetailUIController:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function DualTeamExploreExBossDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgBoss.RecommendPower)

	local otherBossFormationInfo

	if self.index == 1 then
		otherBossFormationInfo = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossFormationInfo2
	elseif self.index == 2 then
		otherBossFormationInfo = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.exBossFormationInfo1
	end

	self.isShowTap = self.FormationPanelController:SetFormationShowTag(otherBossFormationInfo, DualTeamExploreExBossDetailUIApi:GetString("TagText"))
end

function DualTeamExploreExBossDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, DualTeamExploreExBossDetailUIApi:GetString("TextPowerNum", power2))
	UGUIUtil.SetText(self.TextCurrentNum, DualTeamExploreExBossDetailUIApi:GetString("TextCurrentNum", power1, power2))
end

function DualTeamExploreExBossDetailUIController:ShowCD()
	self.timer:Stop()

	local lastAttackExBossTime = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime1

	if self.index == 2 then
		lastAttackExBossTime = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime2
	end

	self.failureCD = self.cfgBoss.ChallengeCD - (PlayerModule.GetServerTime() - lastAttackExBossTime)

	if self.failureCD > 0 then
		self.timer:Start()
	end

	self:OnUpdateTime()
end

function DualTeamExploreExBossDetailUIController:OnUpdateTime()
	local lastAttackExBossTime = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime1

	if self.index == 2 then
		lastAttackExBossTime = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.lastAttackExBossTime2
	end

	self.failureCD = self.cfgBoss.ChallengeCD - (PlayerModule.GetServerTime() - lastAttackExBossTime)

	if self.failureCD >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, DualTeamExploreExBossDetailUIApi:GetString("TextTimeCD", GetFormatTime(self.failureCD)))
		self.TimeView:SetActive(true)
	else
		self.TimeView:SetActive(false)
		self.timer:Stop()
	end
end

function DualTeamExploreExBossDetailUIController:OnClickChallengeBtn()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, DualTeamExploreExBossDetailUIApi:GetString("NoFormations"))

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
		return
	end

	if self.isShowTap then
		NoticeModule.ShowNotice(21045034, function()
			DualTeamExploreModule.ChallengeExBoss(self.formationID, self.index)
		end)
	else
		DualTeamExploreModule.ChallengeExBoss(self.formationID, self.index)
	end
end

function DualTeamExploreExBossDetailUIController:OnClickBtnTip()
	return
end

function DualTeamExploreExBossDetailUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DualTeamExploreExBossDetailUIController
