-- chunkname: @IQIGame\\UI\\Equip\\BreakView\\BreakItemCell.lua

local BreakItemCell = {}

function BreakItemCell.New(go)
	local o = Clone(BreakItemCell)

	o:Initialize(go)

	return o
end

function BreakItemCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlot, true)
	self.itemCell.ViewGo:GetComponent("Button").enabled = false
end

function BreakItemCell:Refresh(itemData)
	self.itemData = itemData
	self.cfgItemData = self.itemData:GetCfg()

	self:RefreshCell()
	self:SetCheckVisible(false)
end

function BreakItemCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BreakItemCell:RefreshCell()
	self.itemCell:SetItem(self.itemData)
end

function BreakItemCell:SetCheckVisible(vs)
	self.itemCell:SetTopCheckVisible(vs)
end

return BreakItemCell
