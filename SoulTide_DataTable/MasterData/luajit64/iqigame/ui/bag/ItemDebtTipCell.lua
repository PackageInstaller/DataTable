-- chunkname: @IQIGame\\UI\\Bag\\ItemDebtTipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(cid, num)
	local cfgItemData = CfgItemTable[cid]

	UGUIUtil.SetText(self.ItemNameText, cfgItemData.Name)
	UGUIUtil.SetText(self.DebtNumText, ItemDebtTipsUIApi:GetString("CellDebtNumText", num))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
