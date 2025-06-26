-- chunkname: @IQIGame\\UI\\AmusementParkChallengeDetailUI.lua

local AmusementParkChallengeDetailUI = {
	AmusementParkEventBossCellPool = {},
	MonsterElementCells = {},
	ItemCells = {}
}

AmusementParkChallengeDetailUI = Base:Extend("AmusementParkChallengeDetailUI", "IQIGame.Onigao.UI.AmusementParkChallengeDetailUI", AmusementParkChallengeDetailUI)

require("IQIGame.UIExternalApi.AmusementParkChallengeDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local AmusementParkEventBossCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkChallenge.AmusementParkEventBossCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MagicWaxMuseumRewardCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumRewardCell")

function AmusementParkChallengeDetailUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnLeft()
		self:OnBtnLeft()
	end

	function self.DelegateOnClickBtnRight()
		self:OnBtnRight()
	end

	function self.DelegateOnClickChallengeBtn()
		self:OnBtnChallenge()
	end

	function self.DelegateChallengeEvent()
		self:OnChallengeEvent()
	end

	self.ScrollArea:GetComponent("ScrollAreaListPage").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaListPage").onPageReachedMainPos = function(page)
		self:OnPageReachedMain(page)
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
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MagicWaxMuseumRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab), UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
end

function AmusementParkChallengeDetailUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())

	return paths
end

function AmusementParkChallengeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkChallengeDetailUI:GetBGM(userData)
	return nil
end

function AmusementParkChallengeDetailUI:OnOpen(userData)
	self.amusementParkEventData = userData.AmusementParkEventData
	self.currentTabIndex = userData.Index

	self:UpdateView()
end

function AmusementParkChallengeDetailUI:OnClose(userData)
	for i, v in pairs(self.AmusementParkEventBossCellPool) do
		v:HideEntity()
	end
end

function AmusementParkChallengeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnLeft)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.APUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function AmusementParkChallengeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnLeft)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.APUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function AmusementParkChallengeDetailUI:OnPause()
	return
end

function AmusementParkChallengeDetailUI:OnResume()
	return
end

function AmusementParkChallengeDetailUI:OnCover()
	return
end

function AmusementParkChallengeDetailUI:OnReveal()
	return
end

function AmusementParkChallengeDetailUI:OnRefocus(userData)
	return
end

function AmusementParkChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkChallengeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.AmusementParkEventBossCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
end

function AmusementParkChallengeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function AmusementParkChallengeDetailUI:OnChallengeEvent()
	if self.amusementParkEventData then
		self.amusementParkEventData = AmusementParkModule.GetMonsterEventData(self.amusementParkEventData.cid)

		self:UpdateView()
	end
end

function AmusementParkChallengeDetailUI:UpdateView()
	if self.amusementParkEventData then
		UGUIUtil.SetText(self.TitleName, self.amusementParkEventData:GetCfgData().Name)

		if self.currentTabIndex == nil then
			self.currentTabIndex = 1
		end

		self.ScrollArea:GetComponent("ScrollAreaListPage").startIndex = self.currentTabIndex - 1

		self.ScrollArea:GetComponent("ScrollAreaListPage"):Refresh(#self.amusementParkEventData.monsters)
		self.FormationPanelController:UpdateView()
	end
end

function AmusementParkChallengeDetailUI:OnRenderCell(cell)
	local monsterData = self.amusementParkEventData.monsters[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.AmusementParkEventBossCellPool[instanceID]

	if bossCell == nil then
		bossCell = AmusementParkEventBossCell.New(cell.gameObject)
		self.AmusementParkEventBossCellPool[instanceID] = bossCell
	end

	bossCell:SetData(monsterData)
end

function AmusementParkChallengeDetailUI:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1

	self:ShowSelect()
end

function AmusementParkChallengeDetailUI:ShowSelect()
	self.BtnRight:SetActive(self.currentTabIndex < #self.amusementParkEventData.monsters)
	self.BtnLeft:SetActive(self.currentTabIndex > 1)

	self.selectMonsterData = self.amusementParkEventData.monsters[self.currentTabIndex]

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[self.selectMonsterData:GetCfgData().MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]

		if monsterID > 0 then
			local cfgMonster = CfgMonsterTable[monsterID]

			if #cfgMonster.WeakType > 0 then
				for i = 1, #cfgMonster.WeakType do
					local id = cfgMonster.WeakType[i]

					if tab[id] == nil then
						local t = {}

						t.weakType = id
						t.num = 1
						tab[id] = t
					else
						tab[id].num = tab[id].num + 1
					end
				end
			end
		end
	end

	local sortTab = {}

	for i, v in pairs(tab) do
		table.insert(sortTab, v)
	end

	table.sort(sortTab, function(a, b)
		local res = false

		if a.num == b.num then
			res = a.weakType < b.weakType
		else
			res = a.num > b.num
		end

		return res
	end)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.ItemCells = {}

	for i = 1, #self.selectMonsterData:GetCfgData().Reward, 2 do
		local itemID = self.selectMonsterData:GetCfgData().Reward[i]
		local itemNum = self.selectMonsterData:GetCfgData().Reward[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemID, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	self:OnUpdateFormation()
end

function AmusementParkChallengeDetailUI:OnBtnLeft()
	if self.currentTabIndex > 1 then
		self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToBackward()
	end
end

function AmusementParkChallengeDetailUI:OnBtnRight()
	if self.currentTabIndex < #self.amusementParkEventData.monsters then
		self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToForward()
	end
end

function AmusementParkChallengeDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.selectMonsterData:GetCfgData().RecommendPower)
end

function AmusementParkChallengeDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, AmusementParkChallengeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, AmusementParkChallengeDetailUIApi:GetString("TextPower", power1, power2))
end

function AmusementParkChallengeDetailUI:OnBtnChallenge()
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

	AmusementParkModule.CombatTraining(self.selectMonsterData.cid, self.formationID)
end

return AmusementParkChallengeDetailUI
