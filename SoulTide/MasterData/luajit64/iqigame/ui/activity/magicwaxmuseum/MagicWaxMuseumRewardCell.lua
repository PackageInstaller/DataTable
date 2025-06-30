-- chunkname: @IQIGame\\UI\\Activity\\MagicWaxMuseum\\MagicWaxMuseumRewardCell.lua

local m = {}

function m.New(view, itemCellGo)
	local obj = Clone(m)

	obj:Init(view, itemCellGo)

	return obj
end

function m:Init(view, itemCellGo)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	itemCellGo.transform:SetParent(self.ItemCellNode.transform, false)

	self.ItemCell = ItemCell.New(itemCellGo)
end

function m:SetData(itemCid, itemNum)
	self.View:SetActive(itemCid ~= 0)
	self.ItemCell:SetItemByCID(itemCid, itemNum)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
