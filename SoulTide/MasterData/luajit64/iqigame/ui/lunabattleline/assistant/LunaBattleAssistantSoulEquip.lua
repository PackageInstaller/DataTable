-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantSoulEquip.lua

local LunaBattleAssistantEquipCell = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantEquipCell")
local m = {
	EquipCells = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 3 do
		local cell = LunaBattleAssistantEquipCell.New(UnityEngine.Object.Instantiate(self.EquipCellPrefab), function(owner, itemCell)
			self:OnClickEquipCell(itemCell)
		end)

		cell.View.transform:SetParent(self.EquipGrid.transform, false)
		table.insert(self.EquipCells, cell)
	end

	UGUIUtil.SetText(self.EquipLabel, LunaBattleLineAssistantUIApi:GetString("EquipLabel"))
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(soulPrefab)
	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]
		local formationEquipPOD = soulPrefab.equipments[i]
		local itemData

		if formationEquipPOD ~= nil then
			itemData = LunaBattleLineModule.CreateEquipData(formationEquipPOD, i, false)
		end

		cell:SetData(itemData)
	end
end

function m:OnClickEquipCell(itemCell)
	local itemData = itemCell.ItemCfgOrData

	if itemData ~= nil then
		local allEquipDataList = {}

		for i = 1, #self.EquipCells do
			local cell = self.EquipCells[i]

			if cell.ItemCell.ItemCfgOrData ~= nil then
				table.insert(allEquipDataList, cell.ItemCell.ItemCfgOrData)
			end
		end

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = allEquipDataList,
			defaultItemData = itemData
		})
	end
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.EquipCells do
		local cell = self.EquipCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
