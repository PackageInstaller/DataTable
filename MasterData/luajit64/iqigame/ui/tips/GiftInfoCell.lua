-- chunkname: @IQIGame\\UI\\Tips\\GiftInfoCell.lua

local GiftInfoCell = {}

function GiftInfoCell.New(go)
	local o = Clone(GiftInfoCell)

	o:Initialize(go)

	return o
end

function GiftInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfNum = self.goNum:GetComponent("Text")
	self.tfType = self.goType:GetComponent("Text")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlotParent.transform:GetChild(0).gameObject, false)
end

function GiftInfoCell:RefreshView(itemData)
	self.itemData = itemData

	self:RefreshDatum()
	self:RefreshMisc()
end

function GiftInfoCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function GiftInfoCell:RefreshDatum()
	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self.cfgItemData = CfgItemTable[self.itemData.cid]
end

function GiftInfoCell:RefreshMisc()
	self.tfName.text = GiftTipUIApi:GetString("goName", self.cfgItemData.Name)
	self.tfNum.text = GiftTipUIApi:GetString("goNum", self.itemData.num)
	self.tfType.text = ItemTipsApi:GetString("goType", self.cfgItemData.Type, self.cfgItemData.SubType)

	self.itemCell:SetItem(self.itemData)
end

return GiftInfoCell
