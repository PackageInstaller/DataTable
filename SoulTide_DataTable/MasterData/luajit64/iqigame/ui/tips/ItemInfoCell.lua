-- chunkname: @IQIGame\\UI\\Tips\\ItemInfoCell.lua

local ItemInfoCell = {
	itemNum = 0
}

function ItemInfoCell.New(go)
	local o = Clone(ItemInfoCell)

	o:Initialize(go)

	return o
end

function ItemInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfType = self.goType:GetComponent("Text")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItemCell, false)
end

function ItemInfoCell:RefreshView(itemData, num)
	self.itemData = itemData
	self.itemNum = num

	self:RefreshDatum()
	self:RefreshMisc()
end

function ItemInfoCell:OnDestroy()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ItemInfoCell:RefreshDatum()
	if self.itemData.classType ~= "ItemData" then
		local hasNum

		if PlayerModule.InMaze then
			hasNum = MazeDataModule.GetItemNumByCfgID(self.itemData.Id)
		else
			hasNum = WarehouseModule.GetItemNumByCfgID(self.itemData.Id)
		end

		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, hasNum)
	end

	self.cfgItemData = self.itemData:GetCfg()
end

function ItemInfoCell:RefreshMisc()
	self.tfName.text = ItemTipsApi:GetString("goName", self.cfgItemData.Name, self.cfgItemData.Quality)
	self.tfType.text = ItemTipsApi:GetString("goType", self.cfgItemData.Type, self.cfgItemData.SubType)

	if self.cfgItemData.IsShowUseNum and self.cfgItemData.UseNum > 0 then
		local haveNum = self.itemData:GetLeftUseCount()

		UGUIUtil.SetText(self.goNumText, ItemTipsApi:GetString("goNumText", haveNum, self.cfgItemData.UseNum))
	else
		UGUIUtil.SetText(self.goNumText, ItemTipsApi:GetString("goNum", self.itemNum))
	end

	self.itemCell:SetItem(self.itemData, 1)
end

return ItemInfoCell
