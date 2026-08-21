-- chunkname: @IQIGame\\UI\\Activity\\LimitedTurn\\LimitedTurnRewardListCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot)
end

function m:SetData(cfg, probability)
	self.cfgData = cfg

	if self.cfgData then
		local itemID = self.cfgData.Reward[1]
		local itemNum = self.cfgData.Reward[2]

		self.ItemCell:SetItemByCID(itemID, itemNum)
		UGUIUtil.SetText(self.TextName, CfgItemTable[itemID].Name)
		UGUIUtil.SetText(self.TextPerCent, LimitedTurnRewardListUIApi:GetString("TextPerCent", probability))
	end
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
