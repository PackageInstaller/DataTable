-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\SkillUpgradeItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot, true, true)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemData)
	self.ItemCell:SetItem(ItemData.CreateByCIDAndNumber(itemData.cid, 0))
	self.ItemCell:SetCustomNum(itemData.Num)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
