-- chunkname: @IQIGame\\UI\\PlaceGameChallengeDetailUI.lua

local PlaceGameChallengeDetailUI = {
	EntityId = 0,
	ItemCells = {},
	MonsterHeadCells = {},
	MonsterElementCells = {}
}

PlaceGameChallengeDetailUI = Base:Extend("PlaceGameChallengeDetailUI", "IQIGame.Onigao.UI.PlaceGameChallengeDetailUI", PlaceGameChallengeDetailUI)

require("IQIGame.UIExternalApi.PlaceGameChallengeDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local PlaceGameFormationPanelController = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationPanelController")

function PlaceGameChallengeDetailUI:OnInit()
	function self.DelegateOnClickBtnForward()
		self:OnClickBtnForward()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateBtnAutoChallenge()
		self:OnBtnAutoChallenge()
	end

	function self.DelegateRefreshRankEvent()
		self:OnRefreshRank()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.FormationPanelController = PlaceGameFormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	self.Mould1:SetActive(false)

	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.Mould1))
	end, function(cell)
		cell:Dispose()
	end)

	self.MouldMonster:SetActive(false)

	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.MouldMonster))
	end, function(cell)
		cell:Dispose()
	end)

	self.MonsterElementPrefab:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementPrefab))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
end

function PlaceGameChallengeDetailUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameChallengeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameChallengeDetailUI:GetBGM(userData)
	return nil
end

function PlaceGameChallengeDetailUI:OnOpen(userData)
	self:UpdateView()
end

function PlaceGameChallengeDetailUI:OnClose(userData)
	self:HideEntity()
end

function PlaceGameChallengeDetailUI:OnAddListeners()
	self.BtnForward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnForward)
	self.BtnAutoChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnAutoChallenge)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FormationPanelController:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function PlaceGameChallengeDetailUI:OnRemoveListeners()
	self.BtnForward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnForward)
	self.BtnAutoChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAutoChallenge)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FormationPanelController:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
end

function PlaceGameChallengeDetailUI:OnPause()
	return
end

function PlaceGameChallengeDetailUI:OnResume()
	return
end

function PlaceGameChallengeDetailUI:OnCover()
	self.MonsterSpine:SetActive(false)
end

function PlaceGameChallengeDetailUI:OnReveal()
	self.MonsterSpine:SetActive(true)
end

function PlaceGameChallengeDetailUI:OnRefocus(userData)
	return
end

function PlaceGameChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameChallengeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()
	self.FormationPanelController:Dispose()
end

function PlaceGameChallengeDetailUI:OnClickBtnForward()
	self:StartFight(false)
end

function PlaceGameChallengeDetailUI:OnBtnAutoChallenge()
	self:StartFight(true)
end

function PlaceGameChallengeDetailUI:StartFight(isAutoFight)
	if not PlaceGameModule.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if #PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs == 0 then
		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	PlaceGameModule.ClimbingTower(formationPOD.id, isAutoFight)
end

function PlaceGameChallengeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function PlaceGameChallengeDetailUI:OnRefreshRank()
	self:UpdateView()

	if PlaceGameModule.isAutoFight then
		self:StartFight(true)
	end
end

function PlaceGameChallengeDetailUI:UpdateView()
	self.FormationPanelController:UpdateView()

	self.placeGameTowerData = PlaceGameModule.GetCurrentTowerData()

	if self.placeGameTowerData then
		local cfgMonsterTeam = CfgMonsterTeamTable[self.placeGameTowerData.MonsterTeam]

		UGUIUtil.SetText(self.TextFloor, self.placeGameTowerData.Name)
		UGUIUtil.SetText(self.TextBossName, self.placeGameTowerData.MonsterName)
		self:ShowMonster(self.placeGameTowerData.EntityID)

		for i, v in pairs(self.MonsterElementCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.MonsterElementPool:Release(v)
		end

		self.MonsterElementCells = {}

		local tab = {}

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
			local data = sortTab[i]
			local cell = self.MonsterElementPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
			cell:SetData(data.weakType)
			table.insert(self.MonsterElementCells, cell)
		end

		for i, v in pairs(self.ItemCells) do
			self.ItemCellPool:Release(v)
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
		end

		self.ItemCells = {}

		for i = 1, #self.placeGameTowerData.ClearReward, 2 do
			local itemID = self.placeGameTowerData.ClearReward[i]
			local itemNum = self.placeGameTowerData.ClearReward[i + 1]
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
			itemCell:SetData(itemID, itemNum)
			table.insert(self.ItemCells, itemCell)
		end

		self:UpdateMonsterCells(cfgMonsterTeam)
	end
end

function PlaceGameChallengeDetailUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.MonsterSpine.transform, Vector3.zero)
end

function PlaceGameChallengeDetailUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function PlaceGameChallengeDetailUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.placeGameTowerData.EntityScale[1], self.placeGameTowerData.EntityScale[2], self.placeGameTowerData.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.placeGameTowerData.EntityPosition[1], self.placeGameTowerData.EntityPosition[2], self.placeGameTowerData.EntityPosition[3])

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function PlaceGameChallengeDetailUI:UpdateMonsterCells(cfgMonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
		v.goView:SetActive(false)
		v.goView.transform:SetParent(self.UIController.transform, false)
	end

	self.MonsterHeadCells = {}

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

function PlaceGameChallengeDetailUI:OnUpdateFormation()
	return
end

function PlaceGameChallengeDetailUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

return PlaceGameChallengeDetailUI
