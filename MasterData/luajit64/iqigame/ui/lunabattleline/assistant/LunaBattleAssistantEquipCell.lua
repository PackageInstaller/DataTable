-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantEquipCell.lua

local m = {}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.goSlot, true, true)

	self.ItemCell:SetClickHandler(onClick)
end

function m:SetData(itemData)
	self.ItemCell:SetItem(itemData)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
