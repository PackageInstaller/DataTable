-- chunkname: @IQIGame\\UI\\Lottery\\LotteryResultItemCell.lua

local m = {}

function m.New(view, mainCanvas)
	local obj = Clone(m)

	obj:Init(view, mainCanvas)

	return obj
end

function m:Init(view, mainCanvas)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, true, true, true)

	UIUtil.InitSortedComponents(mainCanvas, self.View)
end

function m:SetData(cfgItemData, itemNum, isNew)
	self.ItemCell:SetItem(cfgItemData, 1)
	UGUIUtil.SetText(self.NameText, cfgItemData.Name)
	self.NewIcon:SetActive(isNew)
	self.View:SetActive(true)
	UGUIUtil.SetText(self.ItemNumText, LotteryUIApi:GetString("ItemNumText", itemNum))
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
