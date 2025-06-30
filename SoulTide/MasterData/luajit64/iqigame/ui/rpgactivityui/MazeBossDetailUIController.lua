-- chunkname: @IQIGame\\UI\\RPGActivityUI\\MazeBossDetailUIController.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local TowerRewardCell = require("IQIGame.UI.ChallengeTower.TowerRewardCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MazeBossDetailUIController = {
	isFree = false,
	MonsterElementCells = {},
	MonsterHeadCells = {},
	ItemCells = {}
}

function MazeBossDetailUIController.New(uiController)
	local obj = Clone(MazeBossDetailUIController)

	obj:__Init(uiController)

	return obj
end

function MazeBossDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function MazeBossDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function MazeBossDetailUIController:OnInit()
	UGUIUtil.SetText(self.TitleName, MazeBossDetailUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.TextMonsterList, MazeBossDetailUIApi:GetString("TextMonsterList"))

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

function MazeBossDetailUIController:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())
	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function MazeBossDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBossDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function MazeBossDetailUIController:GetBGM(userData)
	return nil
end

function MazeBossDetailUIController:OnOpen(userData)
	self.cfgRPGMazeBoss = userData[1]
	self.isFree = userData[2]

	self:UpdateView()
end

function MazeBossDetailUIController:OnClose(userData)
	return
end

function MazeBossDetailUIController:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
end

function MazeBossDetailUIController:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
end

function MazeBossDetailUIController:OnPause()
	return
end

function MazeBossDetailUIController:OnResume()
	return
end

function MazeBossDetailUIController:OnCover()
	return
end

function MazeBossDetailUIController:OnReveal()
	return
end

function MazeBossDetailUIController:OnRefocus(userData)
	return
end

function MazeBossDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBossDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBossDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBossDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBossDetailUIController:OnDestroy()
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

function MazeBossDetailUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MazeBossDetailUI)
end

function MazeBossDetailUIController:UpdateView()
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

	local firstKill = table.indexOf(RpgMazeModule.DailyDupPOD.rpgMazePOD.killedBoss, self.cfgRPGMazeBoss.Id) == -1

	if firstKill and #self.cfgRPGMazeBoss.FirstKilledAward > 0 then
		self:UpdateReWards(self.cfgRPGMazeBoss.FirstKilledAward)
		UGUIUtil.SetText(self.TextReward, MazeBossDetailUIApi:GetString("TextReward", 1))
	else
		self:UpdateReWards(self.cfgRPGMazeBoss.ChallengeAward)
		UGUIUtil.SetText(self.TextReward, MazeBossDetailUIApi:GetString("TextReward", 2))
	end
end

function MazeBossDetailUIController:UpdateReWards(reward)
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

function MazeBossDetailUIController:UpdateMonsterCells(MonsterTeam)
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

function MazeBossDetailUIController:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function MazeBossDetailUIController:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgRPGMazeBoss.RecommendPower)
end

function MazeBossDetailUIController:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, MazeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeUIApi:GetString("TextPower", power1, power2))
end

function MazeBossDetailUIController:OnBtnChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MazeBossDetailUIApi:GetString("NoFormations"))

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

function MazeBossDetailUIController:ChallengeDupFun()
	RpgMazeModule.ChallengeBoss(self.formationID, self.cfgRPGMazeBoss.Id, self.isFree)
	self:OnBtnClose()
end

function MazeBossDetailUIController:OnBtnTip()
	return
end

return MazeBossDetailUIController
