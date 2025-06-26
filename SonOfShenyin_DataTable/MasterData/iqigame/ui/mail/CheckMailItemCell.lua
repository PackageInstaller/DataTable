-- chunkname: @IQIGame\\UI\\Mail\\CheckMailItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonslot = ItemCell.New(self.CommonSlotUI, true, false, false)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemData)
	self.commonslot:SetItem(itemData)
	UGUIUtil.SetText(self.CountText, itemData.num)
end

function m:Dispose()
	self:RemoveListeners()
	self.commonslot:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
