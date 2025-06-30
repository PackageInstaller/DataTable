-- chunkname: @IQIGame\\UI\\FormationUI\\MultiFunctionFormationPanel.lua

local m = {
	TeamPower = 0,
	FormationTabIndex = 0
}
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
		table.insert(self.SoulCells, soulCell)
	end

	self.PositionCells = {}

	for i = 1, 10 do
		local cellGo = UnityEngine.Object.Instantiate(self.PosCellPrefab)

		cellGo.transform:SetParent(self.PositionGrid.transform, false)

		local cell = FormationPanelPositionCell.New(cellGo, i)

		self.PositionCells[i] = cell
	end
end

function m:SetData(prefabMap)
	local power = 0

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local soulData

		if prefabMap then
			local prefab = prefabMap[i]

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

	self.TeamPower = power

	for i = 1, #self.PositionCells do
		local cell = self.PositionCells[i]

		if prefabMap then
			local formationSoulPrefabPOD = prefabMap[(i - 1) % 5 + 1]
			local position = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.position or 0
			local hasSoul = formationSoulPrefabPOD ~= nil and formationSoulPrefabPOD.soulCid ~= nil

			cell:SetData(position, hasSoul)
		else
			cell:SetData(i, false)
		end
	end
end

function m:GetPower()
	return self.TeamPower
end

function m:Dispose()
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
