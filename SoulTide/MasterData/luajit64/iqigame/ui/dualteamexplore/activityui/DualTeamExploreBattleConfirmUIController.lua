-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreBattleConfirmUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreBattleConfirmUIApi")

local DualTeamExploreLevelUIDollCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelUIDollCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DualTeamExploreMonsterCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreMonsterCell")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local DualTeamExploreBattleConfirmUIController = {
	MonsterCells = {},
	WeakCells = {},
	TeamToggleList = {},
	TeamDollCells = {}
}

function DualTeamExploreBattleConfirmUIController.New(uiController)
	local obj = Clone(DualTeamExploreBattleConfirmUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreBattleConfirmUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreBattleConfirmUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreBattleConfirmUIController:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	for i = 1, 2 do
		self.TeamToggleList[i] = self["TeamToggle" .. i]
	end

	for teamIndex = 1, 2 do
		local parentNode = self["TeamDollCellGrid" .. teamIndex]

		self.TeamDollCells[teamIndex] = {}

		for cellIndex = 1, 5 do
			local cell = DualTeamExploreLevelUIDollCell.New(UnityEngine.Object.Instantiate(self.DollCellPrefab), teamIndex, cellIndex)

			cell.View.transform:SetParent(parentNode.transform, false)

			self.TeamDollCells[teamIndex][cellIndex] = cell
		end
	end

	self.MonsterHeadCellPool = UIObjectPool.New(5, function()
		return DualTeamExploreMonsterCell.New(UnityEngine.Object.Instantiate(self.MonsterHeadPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.WeakCellPool = UIObjectPool.New(5, function()
		return MonsterElementCell.New(UnityEngine.Object.Instantiate(self.WeakPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.TitleText, DualTeamExploreBattleConfirmUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TeamToggle1Label1, DualTeamExploreBattleConfirmUIApi:GetString("TeamToggleLabel", 1, 1))
	UGUIUtil.SetText(self.TeamToggle1Label2, DualTeamExploreBattleConfirmUIApi:GetString("TeamToggleLabel", 1, 2))
	UGUIUtil.SetText(self.TeamToggle2Label1, DualTeamExploreBattleConfirmUIApi:GetString("TeamToggleLabel", 2, 1))
	UGUIUtil.SetText(self.TeamToggle2Label2, DualTeamExploreBattleConfirmUIApi:GetString("TeamToggleLabel", 2, 2))
	UGUIUtil.SetText(self.SelectTipText, DualTeamExploreBattleConfirmUIApi:GetString("SelectTipText"))
end

function DualTeamExploreBattleConfirmUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreBattleConfirmUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreBattleConfirmUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreBattleConfirmUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreBattleConfirmUIController:OnOpen(userData)
	self:UpdateView(userData.monsterTeamCid)
end

function DualTeamExploreBattleConfirmUIController:OnClose(userData)
	return
end

function DualTeamExploreBattleConfirmUIController:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreBattleConfirmUIController:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreBattleConfirmUIController:OnPause()
	return
end

function DualTeamExploreBattleConfirmUIController:OnResume()
	return
end

function DualTeamExploreBattleConfirmUIController:OnCover()
	return
end

function DualTeamExploreBattleConfirmUIController:OnReveal()
	return
end

function DualTeamExploreBattleConfirmUIController:OnRefocus(userData)
	return
end

function DualTeamExploreBattleConfirmUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreBattleConfirmUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreBattleConfirmUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreBattleConfirmUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreBattleConfirmUIController:OnDestroy()
	for i = 1, #self.TeamToggleList do
		self.TeamToggleList[i] = nil
	end

	for teamIndex = 1, #self.TeamDollCells do
		local cells = self.TeamDollCells[teamIndex]

		for cellIndex = 1, #cells do
			local cell = cells[cellIndex]

			cell:Dispose()
		end
	end

	self:ClearMonsters()
	self.MonsterHeadCellPool:Dispose()
	self.WeakCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreBattleConfirmUIController:UpdateView(monsterTeamCid)
	local cfgMonsterTeamData = CfgMonsterTeamTable[monsterTeamCid]

	self:ClearMonsters()

	local monsterCids = {}
	local weakNumMap = {}

	for i = 1, #cfgMonsterTeamData.TeamUnit do
		local monsterCid = cfgMonsterTeamData.TeamUnit[i]

		if monsterCid ~= 0 then
			local cfgMonsterData = CfgMonsterTable[monsterCid]

			if not cfgMonsterData.NotShowInUI then
				table.insert(monsterCids, {
					cid = monsterCid,
					pos = i <= 5 and 1 or 2
				})
			end

			for j = 1, #cfgMonsterData.WeakType do
				local weakType = cfgMonsterData.WeakType[j]
				local weakTypeCount = weakNumMap[weakType]

				weakTypeCount = weakTypeCount ~= nil and weakTypeCount + 1 or 1
				weakNumMap[weakType] = weakTypeCount
			end
		end
	end

	local weakTypes = {}

	for type, count in pairs(weakNumMap) do
		table.insert(weakTypes, type)
	end

	table.sort(weakTypes, function(type1, type2)
		local num1 = weakNumMap[type1]
		local num2 = weakNumMap[type2]

		if num1 == num2 then
			return type1 < type2
		end

		return num2 < num1
	end)

	for i = 1, #monsterCids do
		local data = monsterCids[i]
		local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

		monsterHeadCell.View:SetActive(true)
		monsterHeadCell.View.transform:SetParent(self.MonsterGrid.transform, false)
		monsterHeadCell:SetData(data.cid, data.pos)

		self.MonsterCells[i] = monsterHeadCell
	end

	for i = 1, #weakTypes do
		local weakType = weakTypes[i]
		local weakCell = self.WeakCellPool:Obtain()

		weakCell.View:SetActive(true)
		weakCell.View.transform:SetParent(self.WeakGrid.transform, false)
		weakCell:SetData(weakType)

		self.WeakCells[i] = weakCell
	end

	local activeAliveTeamIndexes = DualTeamExploreModule.GetActiveAliveTeamIndexes()
	local currentTeamIndex = DualTeamExploreModule.GetCurrentTeamIndex()
	local currentTeam = DualTeamExploreModule.GetTeam(currentTeamIndex)

	if currentTeam.dead then
		currentTeamIndex = currentTeamIndex % 2 + 1
	end

	for i = 1, #self.TeamToggleList do
		local toggleGo = self.TeamToggleList[i]
		local toggleCom = toggleGo:GetComponent("Toggle")

		toggleCom.isOn = i == currentTeamIndex

		local team = DualTeamExploreModule.GetTeam(i)
		local isActive = table.indexOf(activeAliveTeamIndexes, i) ~= -1 and not team.dead

		self["TeamInactiveFlag" .. i]:SetActive(not isActive)

		toggleCom.interactable = isActive

		UGUIUtil.SetTextInChildren(self["TeamInactiveFlag" .. i], DualTeamExploreBattleConfirmUIApi:GetString("TeamInactiveFlag", team.dead))

		local teamPOD = DualTeamExploreModule.GetTeam(i)
		local cells = self.TeamDollCells[i]

		for cellIndex = 1, #cells do
			local cell = cells[cellIndex]

			cell:SetData(teamPOD.formationInfo.soulPrefabs[cellIndex])
		end
	end
end

function DualTeamExploreBattleConfirmUIController:ClearMonsters()
	for i = 1, #self.MonsterCells do
		local cell = self.MonsterCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.UIController.transform, false)
		self.MonsterHeadCellPool:Release(cell)
	end

	self.MonsterCells = {}

	for i = 1, #self.WeakCells do
		local cell = self.WeakCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.UIController.transform, false)
		self.WeakCellPool:Release(cell)
	end

	self.WeakCells = {}
end

function DualTeamExploreBattleConfirmUIController:OnClickConfirmBtn()
	local selectTeamIndex = 1

	for i = 1, #self.TeamToggleList do
		local toggleGo = self.TeamToggleList[i]
		local toggle = toggleGo:GetComponent("Toggle")

		if toggle.isOn then
			selectTeamIndex = i

			break
		end
	end

	UIModule.CloseSelf(self)
	DualTeamExploreModule.SendStartBattle(selectTeamIndex)
end

return DualTeamExploreBattleConfirmUIController
