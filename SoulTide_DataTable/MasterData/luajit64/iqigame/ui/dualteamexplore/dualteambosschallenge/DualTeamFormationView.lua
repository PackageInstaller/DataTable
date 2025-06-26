-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamBossChallenge\\DualTeamFormationView.lua

local m = {}
local FormationSoulHeadCell = require("IQIGame.UI.FormationUI.FormationSoulHeadCell")
local FormationPanelPositionCell = require("IQIGame.UI.FormationUI.FormationPanelPositionCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulCells = {}

	for i = 1, 5 do
		local soulCell = FormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.SoulHeadPrefab), true)

		soulCell.View.transform:SetParent(self.SoulGrid.transform, false)
		soulCell:SetData(nil)
		table.insert(self.SoulCells, soulCell)
	end

	self.PositionCells = {}

	for i = 1, 10 do
		local cellGo = UnityEngine.Object.Instantiate(self.PosCellPrefab)

		cellGo.transform:SetParent(self.PositionGrid.transform, false)

		local cell = FormationPanelPositionCell.New(cellGo, i)

		cell:SetData(i, false)

		self.PositionCells[i] = cell
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetPrefabData(soulPrefabs)
	local power = 0

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local soulData

		if soulPrefabs then
			local prefab = soulPrefabs[i]

			if prefab ~= nil and prefab.soulCid ~= nil then
				soulData = SoulModule.CreateCustomSoulData(prefab.soulCid, {
					cid = prefab.soulCid,
					lv = prefab.lv,
					dress2DCid = prefab.dress2DCid,
					dress3DCid = prefab.dress3DCid
				})
				power = power + (prefab.power or 0)
			end
		end

		soulCell:SetData(soulData)
	end

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]

		if soulPrefabs then
			local formationSoulPrefabPOD = soulPrefabs[(i - 1) % 5 + 1]
			local position = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.position or 0
			local hasSoul = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.soulCid ~= nil

			cell:SetData(position, hasSoul)
		else
			cell:SetData(i, false)
		end
	end
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

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
