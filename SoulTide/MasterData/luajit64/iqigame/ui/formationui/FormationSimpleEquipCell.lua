-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSimpleEquipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false, false)
end

function m:SetData(itemData, soulPrefabData)
	self.ItemCell:SetItem(itemData, nil, soulPrefabData)
end

function m:UpdateEquipStatus(soulPrefabData)
	self.ItemCell:UpdateEquipStatus(soulPrefabData)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
