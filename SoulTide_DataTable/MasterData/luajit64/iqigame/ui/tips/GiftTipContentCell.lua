-- chunkname: @IQIGame\\UI\\Tips\\GiftTipContentCell.lua

local GiftTipContentCell = {}

function GiftTipContentCell.New(go, goItemSlot)
	local o = Clone(GiftTipContentCell)

	o:Initialize(go, goItemSlot)

	return o
end

function GiftTipContentCell:Initialize(go, goItemSlot)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")

	goItemSlot.transform:SetParent(self.goSlotParent.transform, fale)

	self.itemCell = ItemCell.PackageOrReuseView(self, goItemSlot, false)
end

function GiftTipContentCell:RefreshView(cfgItemData, itemCount)
	self.cfgItemData = cfgItemData
	self.itemCount = itemCount

	self:RefreshMisc()
end

function GiftTipContentCell:RefreshMisc()
	self.tfName.text = GiftTipUIApi:GetString("goNameCell", self.cfgItemData.Name, self.cfgItemData.Quality)
	self.tfDesc.text = GiftTipUIApi:GetString("goDescCell", self.cfgItemData.Describe)

	self.itemCell:SetItemByCID(self.cfgItemData.Id, self.itemCount)
end

function GiftTipContentCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return GiftTipContentCell
