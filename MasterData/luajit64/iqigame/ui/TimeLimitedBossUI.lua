-- chunkname: @IQIGame\\UI\\TimeLimitedBossUI.lua

local TimeLimitedBossUI = {
	timeLimitedBossCellPool = {},
	MonsterElementCells = {},
	ItemCells = {}
}

TimeLimitedBossUI = Base:Extend("TimeLimitedBossUI", "IQIGame.Onigao.UI.TimeLimitedBossUI", TimeLimitedBossUI)

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local TimeLimitedBossCell = require("IQIGame.UI.Activity.MagicWaxMuseum.TimeLimitedBossCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MagicWaxMuseumRewardCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumRewardCell")

function TimeLimitedBossUI:OnInit()
	UGUIUtil.SetText(self.TextMonsterList, ActivityUIApi:GetString("TextMonsterList"))
	UGUIUtil.SetText(self.TextReward, ActivityUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextChallengeBtn, ActivityUIApi:GetString("TextChallengeBtn"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateOperations()
		self:UpdateOperations()
	end

	self.scrollListPage = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollListPage.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollListPage.onPageReachedMainPos(page)
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

function TimeLimitedBossUI:GetPreloadAssetPaths()
	return nil
end

function TimeLimitedBossUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())

	return paths
end

function TimeLimitedBossUI:IsManualShowOnOpen(userData)
	return false
end

function TimeLimitedBossUI:GetBGM(userData)
	return nil
end

function TimeLimitedBossUI:OnOpen(userData)
	self.magicWaxMuseumGroupList = userData[1]
	self.currentTabIndex = userData[2]
	self.operateEventID = userData[3]
	self.cfgMagicWaxMuseum = self.magicWaxMuseumGroupList[self.currentTabIndex]

	self:UpdateView()
end

function TimeLimitedBossUI:OnClose(userData)
	return
end

function TimeLimitedBossUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function TimeLimitedBossUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function TimeLimitedBossUI:OnPause()
	return
end

function TimeLimitedBossUI:OnResume()
	return
end

function TimeLimitedBossUI:OnCover()
	return
end

function TimeLimitedBossUI:OnReveal()
	return
end

function TimeLimitedBossUI:OnRefocus(userData)
	return
end

function TimeLimitedBossUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TimeLimitedBossUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TimeLimitedBossUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TimeLimitedBossUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TimeLimitedBossUI:OnDestroy()
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.timeLimitedBossCellPool) do
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

function TimeLimitedBossUI:UpdateOperations()
	if self.operateEventID and self.magicWaxMuseumGroupList then
		self:UpdateView()
	end
end

function TimeLimitedBossUI:UpdateView()
	local cfgOperateEvent = CfgOperateEventsControlTable[self.operateEventID]

	UGUIUtil.SetText(self.TitleName, cfgOperateEvent.Name)

	if self.currentTabIndex == nil then
		self.currentTabIndex = 1
	end

	self.scrollListPage.startIndex = self.currentTabIndex - 1

	self.scrollListPage:Refresh(#self.magicWaxMuseumGroupList)
	self.FormationPanelController:UpdateView()
end

function TimeLimitedBossUI:OnRenderCell(cell)
	local cfgData = self.magicWaxMuseumGroupList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.timeLimitedBossCellPool[instanceID]

	if bossCell == nil then
		bossCell = TimeLimitedBossCell.New(cell.gameObject, self)
		self.timeLimitedBossCellPool[instanceID] = bossCell
	end

	bossCell:SetData(cfgData, self.operateEventID)
end

function TimeLimitedBossUI:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1

	self:ShowSelect()
end

function TimeLimitedBossUI:ShowSelect()
	self.BtnRight:SetActive(self.currentTabIndex < #self.magicWaxMuseumGroupList)
	self.BtnLeft:SetActive(self.currentTabIndex > 1)

	self.cfgMagicWaxMuseum = self.magicWaxMuseumGroupList[self.currentTabIndex]

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[self.cfgMagicWaxMuseum.MonsterTeam]

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

	for i = 1, #self.cfgMagicWaxMuseum.Reward, 2 do
		local itemID = self.cfgMagicWaxMuseum.Reward[i]
		local itemNum = self.cfgMagicWaxMuseum.Reward[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemID, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	self:OnUpdateFormation()
end

function TimeLimitedBossUI:OnBtnLeft()
	if self.currentTabIndex > 1 then
		self.scrollListPage:TurnToBackward()
	end
end

function TimeLimitedBossUI:OnBtnRight()
	if self.currentTabIndex < #self.magicWaxMuseumGroupList then
		self.scrollListPage:TurnToForward()
	end
end

function TimeLimitedBossUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), self.cfgMagicWaxMuseum.RecommendPower)
end

function TimeLimitedBossUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, TimeLimitedBossUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, TimeLimitedBossUIApi:GetString("TextPower", power1, power2))
end

function TimeLimitedBossUI:OnBtnChallenge()
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

	ActiveMagicWaxMuseumModule.Attack(self.operateEventID, self.cfgMagicWaxMuseum.Id, self.formationID)
end

function TimeLimitedBossUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.TimeLimitedBossUI)
end

return TimeLimitedBossUI
