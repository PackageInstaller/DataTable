-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGMazeBossDetail\\HorizontalRPGMazeBossDetailUIController.lua

local HorizontalRPGMazeBossDetailUIController = {
	isFree = false,
	MonsterElementCells = {},
	MonsterHeadCells = {},
	ItemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local TowerRewardCell = require("IQIGame.UI.ChallengeTower.TowerRewardCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")

function HorizontalRPGMazeBossDetailUIController.New(uiController)
	local obj = Clone(HorizontalRPGMazeBossDetailUIController)

	obj:__Init(uiController)

	return obj
end

function HorizontalRPGMazeBossDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function HorizontalRPGMazeBossDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HorizontalRPGMazeBossDetailUIController:OnInit()
	UGUIUtil.SetText(self.TitleName, HorizontalRPGMazeBossDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextMonsterList, HorizontalRPGMazeBossDetailUIApi:GetString("TextMonsterList"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
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
	self.ItemCellPool = UIObjectPool.New(10, function()
		return TowerRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab), UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
end

function HorizontalRPGMazeBossDetailUIController:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())
	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function HorizontalRPGMazeBossDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeBossDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeBossDetailUIController:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeBossDetailUIController:OnOpen(userData)
	self.cfgRPGMazeBoss = userData[1]
	self.isFree = userData[2]

	self:UpdateView()
end

function HorizontalRPGMazeBossDetailUIController:OnClose(userData)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
end

function HorizontalRPGMazeBossDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
end

function HorizontalRPGMazeBossDetailUIController:OnPause()
	return
end

function HorizontalRPGMazeBossDetailUIController:OnResume()
	return
end

function HorizontalRPGMazeBossDetailUIController:OnCover()
	return
end

function HorizontalRPGMazeBossDetailUIController:OnReveal()
	return
end

function HorizontalRPGMazeBossDetailUIController:OnRefocus(userData)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeBossDetailUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
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

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function HorizontalRPGMazeBossDetailUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HorizontalRPGMazeBossDetailUI)
end

function HorizontalRPGMazeBossDetailUIController:UpdateView()
	self.FormationPanelController:UpdateView()

	local cfgMonster = CfgMonsterTable[self.cfgRPGMazeBoss.Monster]

	UGUIUtil.SetText(self.TextBossName, cfgMonster.Name)

	local path = UIGlobalApi.GetImagePath(self.cfgRPGMazeBoss.BossBg)

	AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	for i = 1, #self.cfgRPGMazeBoss.WeakType do
		local weakType = self.cfgRPGMazeBoss.WeakType[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:UpdateMonsterCells(self.cfgRPGMazeBoss.MonsterTeam)

	local firstKill = table.indexOf(HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.killedBoss or {}, self.cfgRPGMazeBoss.Id) == -1

	if firstKill and #self.cfgRPGMazeBoss.FirstKilledAward > 0 then
		self:UpdateReWards(self.cfgRPGMazeBoss.FirstKilledAward)
		UGUIUtil.SetText(self.TextReward, HorizontalRPGMazeBossDetailUIApi:GetString("TextReward", 1))
	else
		self:UpdateReWards(self.cfgRPGMazeBoss.ChallengeAward)
		UGUIUtil.SetText(self.TextReward, HorizontalRPGMazeBossDetailUIApi:GetString("TextReward", 2))
	end
end

function HorizontalRPGMazeBossDetailUIController:UpdateReWards(reward)
	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.ItemCells = {}

	for i = 1, #reward, 2 do
		local itemID = reward[i]
		local itemNum = reward[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemID, itemNum, false)
		table.insert(self.ItemCells, itemCell)
	end
end

function HorizontalRPGMazeBossDetailUIController:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(mId)
				self:OnClickMonsterCell(mId)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function HorizontalRPGMazeBossDetailUIController:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function HorizontalRPGMazeBossDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgRPGMazeBoss.RecommendPower)
end

function HorizontalRPGMazeBossDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, HorizontalRPGMazeBossDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, HorizontalRPGMazeBossDetailUIApi:GetString("TextPower", power1, power2))
end

function HorizontalRPGMazeBossDetailUIController:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HorizontalRPGMazeBossDetailUIApi:GetString("NoFormations"))

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

function HorizontalRPGMazeBossDetailUIController:ChallengeDupFun()
	HorizontalRPGModule.CombatTraining(self.cfgRPGMazeBoss.Id, self.formationID, self.isFree)
	self:OnBtnClose()
end

function HorizontalRPGMazeBossDetailUIController:OnBtnTip()
	return
end

return HorizontalRPGMazeBossDetailUIController
