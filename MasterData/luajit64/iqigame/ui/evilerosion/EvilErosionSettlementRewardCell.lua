-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionSettlementRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, true, true)
end

function m:SetData(itemCid, itemNum)
	self.ItemCell:SetItemByCID(itemCid, itemNum)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
