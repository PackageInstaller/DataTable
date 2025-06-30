-- chunkname: @IQIGame\\UI\\RestaurantOperationChallengeDetailUI.lua

local RestaurantOperationChallengeDetailUI = {
	roEventBossCellPool = {},
	MonsterElementCells = {},
	ItemCells = {}
}

RestaurantOperationChallengeDetailUI = Base:Extend("RestaurantOperationChallengeDetailUI", "IQIGame.Onigao.UI.RestaurantOperationChallengeDetailUI", RestaurantOperationChallengeDetailUI)

require("IQIGame.UIExternalApi.RestaurantOperationChallengeDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local ROEventBossCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationChallenge.ROEventBossCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MagicWaxMuseumRewardCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumRewardCell")

function RestaurantOperationChallengeDetailUI:OnInit()
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

function RestaurantOperationChallengeDetailUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())

	return paths
end

function RestaurantOperationChallengeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationChallengeDetailUI:GetBGM(userData)
	return nil
end

function RestaurantOperationChallengeDetailUI:OnOpen(userData)
	self.roEventData = userData.ROEventData
	self.currentTabIndex = userData.Index

	self:UpdateView()
end

function RestaurantOperationChallengeDetailUI:OnClose(userData)
	for i, v in pairs(self.roEventBossCellPool) do
		v:HideEntity()
	end
end

function RestaurantOperationChallengeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnLeft)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.ROUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function RestaurantOperationChallengeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnLeft)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateChallengeEvent, self.DelegateChallengeEvent)
end

function RestaurantOperationChallengeDetailUI:OnPause()
	return
end

function RestaurantOperationChallengeDetailUI:OnResume()
	return
end

function RestaurantOperationChallengeDetailUI:OnCover()
	return
end

function RestaurantOperationChallengeDetailUI:OnReveal()
	return
end

function RestaurantOperationChallengeDetailUI:OnRefocus(userData)
	return
end

function RestaurantOperationChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationChallengeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.roEventBossCellPool) do
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

function RestaurantOperationChallengeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RestaurantOperationChallengeDetailUI:OnChallengeEvent()
	if self.roEventData then
		self.roEventData = RestaurantOperationModule.GetMonsterEventData(self.roEventData.cid)

		self:UpdateView()
	end
end

function RestaurantOperationChallengeDetailUI:UpdateView()
	if self.roEventData then
		UGUIUtil.SetText(self.TitleName, self.roEventData:GetCfgData().Name)

		if self.currentTabIndex == nil then
			self.currentTabIndex = 1
		end

		self.ScrollArea:GetComponent("ScrollAreaListPage").startIndex = self.currentTabIndex - 1

		self.ScrollArea:GetComponent("ScrollAreaListPage"):Refresh(#self.roEventData.monsters)
		self.FormationPanelController:UpdateView()
	end
end

function RestaurantOperationChallengeDetailUI:OnRenderCell(cell)
	local monsterData = self.roEventData.monsters[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.roEventBossCellPool[instanceID]

	if bossCell == nil then
		bossCell = ROEventBossCell.New(cell.gameObject)
		self.roEventBossCellPool[instanceID] = bossCell
	end

	bossCell:SetData(monsterData)
end

function RestaurantOperationChallengeDetailUI:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1

	self:ShowSelect()
end

function RestaurantOperationChallengeDetailUI:ShowSelect()
	self.BtnRight:SetActive(self.currentTabIndex < #self.roEventData.monsters)
	self.BtnLeft:SetActive(self.currentTabIndex > 1)

	self.selectMonsterData = self.roEventData.monsters[self.currentTabIndex]

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

function RestaurantOperationChallengeDetailUI:OnBtnLeft()
	if self.currentTabIndex > 1 then
		self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToBackward()
	end
end

function RestaurantOperationChallengeDetailUI:OnBtnRight()
	if self.currentTabIndex < #self.roEventData.monsters then
		self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToForward()
	end
end

function RestaurantOperationChallengeDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.selectMonsterData:GetCfgData().RecommendPower)
end

function RestaurantOperationChallengeDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, RestaurantOperationChallengeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, RestaurantOperationChallengeDetailUIApi:GetString("TextPower", power1, power2))
end

function RestaurantOperationChallengeDetailUI:OnBtnChallenge()
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

	RestaurantOperationModule.CombatTraining(self.selectMonsterData.cid, self.formationID)
	log("发起挑战")
end

return RestaurantOperationChallengeDetailUI
