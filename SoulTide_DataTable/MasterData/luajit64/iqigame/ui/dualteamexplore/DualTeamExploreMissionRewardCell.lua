-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreMissionRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.ItemCellGO, true, true, true)
end

function m:SetData(itemCid, itemNum)
	self.ItemCell:SetItemByCID(itemCid, 1)
	UGUIUtil.SetText(self.NumText, DualTeamExploreMissionUIApi:GetString("StateView_RewardNumText", itemNum))
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
