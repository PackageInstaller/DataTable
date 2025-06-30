-- chunkname: @IQIGame\\UI\\Common\\ItemCell2.lua

ItemCell2 = {}

function ItemCell2.New(view)
	local obj = Clone(ItemCell2)

	obj:Init(view)

	return obj
end

function ItemCell2:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfOwnNum = self.goOwnNum:GetComponent("Text")
	self.tfCostNum = self.goCostNum:GetComponent("Text")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlot)
end

function ItemCell2:Refresh(itemCid, costCount)
	self.cfgItemData = CfgItemTable[itemCid]

	local ownNum = WarehouseModule.GetItemNumByCfgID(itemCid)

	self.tfOwnNum.text = CommonSlotUIApi:GetString("ItemCell2OwnCount", ownNum, costCount)
	self.tfCostNum.text = CommonSlotUIApi:GetString("ItemCell2CostCount", ownNum, costCount)

	self.itemCell:SetItem(self.cfgItemData)
end

function ItemCell2:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ItemCell2:SetActive(vs)
	self.View:SetActive(vs)
end
