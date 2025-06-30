-- chunkname: @IQIGame\\UI\\ShopRecovery\\ShopRecoveryCell.lua

local ShopRecoveryCell = {}

function ShopRecoveryCell.New(view)
	local obj = Clone(ShopRecoveryCell)

	obj:Init(view)

	return obj
end

function ShopRecoveryCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItem, false)
	self.tfNum = self.goNum:GetComponent("Text")
end

function ShopRecoveryCell:Refresh(itemCid, ownNum)
	self.tfNum.text = ShopRecoveryUIApi:GetString("cellItemNum", ownNum)

	self.itemCell:SetItemByCID(itemCid, ownNum)
end

function ShopRecoveryCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return ShopRecoveryCell
