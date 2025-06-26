-- chunkname: @IQIGame\\UI\\EndlessPlusMaze\\EndlessPlusMazeRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, true, true, true)
end

function m:SetData(cid, num)
	self.ItemCell:SetItemByCID(cid, 1)
	UGUIUtil.SetText(self.NumText, EndlessPlusMazeSettlementUIApi:GetString("RewardCell_NumText", num))
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
