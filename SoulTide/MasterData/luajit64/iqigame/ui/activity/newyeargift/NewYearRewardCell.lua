-- chunkname: @IQIGame\\UI\\Activity\\NewYearGift\\NewYearRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot, true, true, true)
end

function m:SetData(id, num)
	self.ItemCell:SetItemByCID(id, num)
end

function m:Dispose()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
