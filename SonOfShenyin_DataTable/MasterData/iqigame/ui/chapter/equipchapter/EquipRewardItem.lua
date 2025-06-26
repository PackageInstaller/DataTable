-- chunkname: @IQIGame\\UI\\Chapter\\EquipChapter\\EquipRewardItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.Common_Slot, true, true)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemID)
	local itemData = ItemData.CreateByCIDAndNumber(itemID, 0)

	self.ItemCell:SetItem(itemData)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
