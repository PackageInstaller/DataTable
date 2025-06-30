-- chunkname: @IQIGame\\UI\\Bag\\BagItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)
end

function m:SetItem(itemData)
	self.View:SetActive(itemData ~= nil)

	if itemData == nil then
		return
	end

	local cfgItemData = itemData:GetCfg()

	self.ItemCell:SetItem(itemData, 1)

	if self.goName ~= nil then
		self.goName:GetComponent("Text").text = BagItemCellApi:GetString("goName", cfgItemData.Name)
	end

	self.ItemNumText:GetComponent("Text").text = BagItemCellApi:GetString("ItemNumText", itemData.num)

	if self.RedPoint ~= nil then
		local canUse, errorMsg, ignoreRedPoint = ItemModule.CheckCanUse(itemData, 1)

		self.RedPoint:SetActive(cfgItemData.Tabs == Constant.ItemTab.GIFT and canUse and not ignoreRedPoint)
	end

	if itemData:GetCfg().Type == Constant.ItemType.JewelryEquip then
		local isWear = #itemData.jewelryData.newJewelryEquipmentVoPOD.soul > 0

		self.ItemCell:ShowWearTag1(nil, isWear)
	end
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
