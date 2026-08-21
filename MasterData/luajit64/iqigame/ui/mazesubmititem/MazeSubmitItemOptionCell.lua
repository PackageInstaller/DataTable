-- chunkname: @IQIGame\\UI\\MazeSubmitItem\\MazeSubmitItemOptionCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)
end

function m:SetData(itemData)
	self.View:SetActive(itemData ~= nil)
	self.ItemCell:SetItem(itemData)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
