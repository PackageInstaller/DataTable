-- chunkname: @IQIGame\\UI\\Activity\\LimitedTurn\\LimitedTurnTableCell.lua

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

function m:SetData(cfg, getNum)
	self.cfgData = cfg

	if self.cfgData then
		self.ItemCell:SetItemByCID(self.cfgData.Reward[1], self.cfgData.Reward[2])
	end

	self.Tag:SetActive(self.cfgData.TotalLimit > 0)

	local showNum = self.cfgData.TotalLimit - getNum

	showNum = showNum < 0 and 0 or showNum

	UGUIUtil.SetTextInChildren(self.Tag, ActivityUIApi:GetString("LimitedCellTagNum", showNum))
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
