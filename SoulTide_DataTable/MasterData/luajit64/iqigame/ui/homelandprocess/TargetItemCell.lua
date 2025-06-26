-- chunkname: @IQIGame\\UI\\HomeLandProcess\\TargetItemCell.lua

local TargetItemCell = {}

function TargetItemCell.New(view)
	local obj = Clone(TargetItemCell)

	obj:Init(view)

	return obj
end

function TargetItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlot)
end

function TargetItemCell:SetData(cid)
	self.itemCid = cid

	self.itemCell:SetItemByCID(self.itemCid)

	local cfgItem = CfgItemTable[self.itemCid]

	UGUIUtil.SetText(self.TextName, HomeLandMakeItemListUIApi:GetString("TextName", cfgItem.Name))
end

function TargetItemCell:SetNum(num)
	UGUIUtil.SetText(self.TextNum, tostring(num))
end

function TargetItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return TargetItemCell
