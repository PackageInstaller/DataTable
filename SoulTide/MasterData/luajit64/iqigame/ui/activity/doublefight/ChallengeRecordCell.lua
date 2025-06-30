-- chunkname: @IQIGame\\UI\\Activity\\DoubleFight\\ChallengeRecordCell.lua

local m = {
	FormationTabIndex = 0,
	MonsterHeadCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationSoulHeadCell = require("IQIGame.UI.FormationUI.FormationSoulHeadCell")
local FormationPanelPositionCell = require("IQIGame.UI.FormationUI.FormationPanelPositionCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")

function m.New(view, index, root)
	local obj = Clone(m)

	obj:Init(view, index, root)

	return obj
end

function m:Init(view, index, root)
	self.View = view
	self.index = index
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnScore()
		self:OnBtnScore()
	end

	function self.delegateBtnChangePanel()
		self:OnBtnChangePanel()
	end

	UGUIUtil.SetText(self.TextFormation, ActivityUIApi:GetString("InvasionTextFormation"))
	UGUIUtil.SetText(self.TextSoulGrid, ActivityUIApi:GetString("InvasionTextSoulGrid"))

	self.SoulCells = {}

	for i = 1, 5 do
		local soulCell = FormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.root.SoulHeadPrefab), true)

		soulCell.View.transform:SetParent(self.SoulGrid.transform, false)
		table.insert(self.SoulCells, soulCell)
	end

	self.PositionCells = {}

	for i = 1, 10 do
		local cellGo = UnityEngine.Object.Instantiate(self.root.PosCellPrefab)

		cellGo.transform:SetParent(self.PositionGrid.transform, false)

		local cell = FormationPanelPositionCell.New(cellGo, i)

		self.PositionCells[i] = cell
	end

	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.root.MonsterHeadPrefab))
	end, function(cell)
		cell:Dispose()
	end)

	self.SoulGrid:SetActive(false)
	self.PositionGrid:SetActive(false)
	UGUIUtil.SetText(self.TextScore, "")
	UGUIUtil.SetText(self.TextFightNum, "")
	self:AddListener()
end

function m:AddListener()
	self.BtnScore:GetComponent("Button").onClick:AddListener(self.delegateBtnScore)
	self.BtnChangePanel:GetComponent("Button").onClick:AddListener(self.delegateBtnChangePanel)
end

function m:RemoveListener()
	self.BtnScore:GetComponent("Button").onClick:RemoveListener(self.delegateBtnScore)
	self.BtnChangePanel:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChangePanel)
end

function m:UpdateView(data, operateEventID, fightListCfgId)
	self.doubleFightRecordPOD = data
	self.operateEventID = operateEventID
	self.fightListCfgId = fightListCfgId

	self.TextSoulGrid:SetActive(true)
	self.SoulGrid:SetActive(false)
	self.PositionGrid:SetActive(false)
	UGUIUtil.SetText(self.TextFightNum, "")

	local cfgFightList = CfgDoubleFightListTable[self.fightListCfgId]

	self.BtnScore:SetActive(false)

	if self.doubleFightRecordPOD then
		local currentScore = self.doubleFightRecordPOD.hurtScore + self.doubleFightRecordPOD.roundScore
		local maxScore = cfgFightList.RoundScore[self.index][1] + cfgFightList.HPScore[self.index][1]

		UGUIUtil.SetText(self.TextScore, ActivityUIApi:GetString("InvasionTextScore", currentScore, maxScore))

		if self.doubleFightRecordPOD.formationInfoPOD then
			self.TextSoulGrid:SetActive(false)
			self.SoulGrid:SetActive(true)
			self.PositionGrid:SetActive(true)

			local prefabMap = {}

			for k, formationSoulPrefabPOD in pairs(self.doubleFightRecordPOD.formationInfoPOD.soulPrefabs) do
				prefabMap[tonumber(k)] = formationSoulPrefabPOD
			end

			self:SetPrefabData(prefabMap)
		end

		self.BtnScore:SetActive(currentScore > 0)
	end

	self:UpdateMonsterCells(cfgFightList.MonsterTeam[self.index])
end

function m:UpdateMonsterCells(MonsterTeam)
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

function m:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function m:SetPrefabData(prefabMap)
	local power = 0

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local prefab = prefabMap[i]
		local soulData

		if prefab ~= nil and prefab.soulCid ~= nil then
			soulData = SoulModule.CreateCustomSoulData(prefab.soulCid, {
				cid = prefab.soulCid,
				lv = prefab.lv,
				dress2DCid = prefab.dress2DCid,
				dress3DCid = prefab.dress3DCid
			})
			power = power + (prefab.power or 0)
		end

		soulCell:SetData(soulData)
	end

	UGUIUtil.SetText(self.TextFightNum, tostring(power))

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]
		local formationSoulPrefabPOD = prefabMap[(i - 1) % 5 + 1]
		local position = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.position or 0
		local hasSoul = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.soulCid ~= nil

		cell:SetData(position, hasSoul)
	end
end

function m:OnBtnScore()
	UIModule.Open(Constant.UIControllerName.InvasionScoreTipsUI, Constant.UILayer.UI, {
		self.doubleFightRecordPOD,
		self.fightListCfgId,
		self.index
	})
end

function m:OnBtnChangePanel()
	UIModule.Open(Constant.UIControllerName.InvasionBossDetailUI, Constant.UILayer.UI, {
		self.operateEventID,
		self.index,
		self.fightListCfgId,
		self.index
	})
end

function m:Dispose()
	self:RemoveListener()

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]

		soulCell:Dispose()
	end

	self.SoulCells = nil

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]

		cell:Dispose()
	end

	self.PositionCells = nil

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
