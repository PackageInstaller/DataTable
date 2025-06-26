-- chunkname: @IQIGame\\UI\\Activity\\LuckyTurnTable\\LuckyTurnTableCell.lua

local m = {}

function m.New(view, pos)
	local obj = Clone(m)

	obj:Init(view, pos)

	return obj
end

function m:Init(view, pos)
	self.View = view
	self.pos = pos

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot)
end

function m:SetData(cfgLuckyTurntableData)
	self.cfgData = cfgLuckyTurntableData

	if self.cfgData then
		self.ItemCell:SetItemByCID(self.cfgData.Reward[1], self.cfgData.Reward[2])
	end
end

function m:SetSelect(top)
	self.NormalBg:SetActive(not top)
	self.HighlightBg:SetActive(top)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
