-- chunkname: @IQIGame\\UI\\Tips\\ItemInfoCell.lua

local ItemInfoCell = {}

function ItemInfoCell.New(go)
	local o = Clone(ItemInfoCell)

	o:Initialize(go)

	return o
end

function ItemInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlotParent.transform:GetChild(0).gameObject, false)
end

function ItemInfoCell:RefreshView(itemData)
	self.itemData = itemData

	self:RefreshDatum()
	self:RefreshMisc()
end

function ItemInfoCell:OnDestroy()
	self.itemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ItemInfoCell:RefreshDatum()
	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self.cfgItemData = self.itemData:GetCfg()
end

function ItemInfoCell:RefreshMisc()
	self.tfName.text = ItemTipsApi:GetName(self.cfgItemData.Name, self.cfgItemData.Quality)
	self.goHasCount:GetComponent("Text").text = ItemTipsApi:GetHasCount(WarehouseModule.GetItemNumByCfgID(self.cfgItemData.Id))

	self.Type_NormalImg:SetActive(self.cfgItemData.ItemTypes ~= Constant.ItemType.Skill and self.cfgItemData.ItemTypes ~= Constant.ItemType.Equip)
	self.Type_EquipImg:SetActive(self.cfgItemData.ItemTypes == Constant.ItemType.Equip)
	self.Type_SkillImg:SetActive(self.cfgItemData.ItemTypes == Constant.ItemType.Skill)

	local path = ItemTipsApi:GetQualityBottomImg(self.cfgItemData.Quality)

	AssetUtil.LoadImage(self, path, self.QualityImg:GetComponent("Image"), nil, nil, nil, true)
	self.goSlotParent:SetActive(false)

	path = UIGlobalApi.GetIconPath(self.cfgItemData.Icon)

	AssetUtil.LoadImage(self, path, self.goImg:GetComponent("Image"), nil, nil, nil, true)
	self.itemCell:SetItem(self.itemData, 1)

	local starComp = self.goStar:GetComponent("SimpleStarComponent")

	starComp:UpdateView(self.cfgItemData.Quality, 0)
	self:SetItemLV()

	if LuaUtility.StrIsNullOrEmpty(self.cfgItemData.SmallIcon) then
		self.smallimg:SetActive(false)
	else
		self.smallimg:SetActive(true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgItemData.SmallIcon), self.smallimg:GetComponent("Image"), nil, nil, nil, true)
	end
end

function ItemInfoCell:SetItemLV()
	self.lvTitle:SetActive(self.cfgItemData.ItemTypes == Constant.ItemType.Skill or self.cfgItemData.ItemTypes == Constant.ItemType.Equip)
	self.lvText:SetActive(self.cfgItemData.ItemTypes == Constant.ItemType.Skill or self.cfgItemData.ItemTypes == Constant.ItemType.Equip)

	if self.cfgItemData.ItemTypes == Constant.ItemType.Skill then
		self.lvText:SetActive(self.itemData.skillData.lv ~= nil)
		self.lvTitle:SetActive(self.itemData.skillData.lv ~= nil)
		UGUIUtil.SetText(self.lvText, self.itemData.skillData.lv)
	elseif self.cfgItemData.ItemTypes == Constant.ItemType.Equip then
		self.lvText:SetActive(self.itemData.equipData.lv ~= nil)
		self.lvTitle:SetActive(self.itemData.equipData.lv ~= nil)
		UGUIUtil.SetText(self.lvText, self.itemData.equipData.lv)
	else
		return
	end
end

return ItemInfoCell
