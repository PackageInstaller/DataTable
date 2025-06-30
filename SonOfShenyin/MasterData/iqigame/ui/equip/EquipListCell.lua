-- chunkname: @IQIGame\\UI\\Equip\\EquipListCell.lua

local EquipListCell = {
	isLock = false,
	isChoose = false
}

function EquipListCell.New(go)
	local o = Clone(EquipListCell)

	o:Initialize(go)

	return o
end

function EquipListCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.BaseItemCell = ItemCell.New(self.CommonSlotUI, false, false)
end

function EquipListCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipListCell:RefreshChooseState()
	self.BaseItemCell:SetSelectFrame(self:IsChoose())
end

function EquipListCell:IsChoose()
	return self.equipData.ItemCustomCount > 0
end

function EquipListCell:Refresh(equipData, index)
	if equipData == nil then
		return
	end

	self.tableIndex = index
	self.equipData = equipData

	local itemData, _ = WarehouseModule.FindItem(equipData.id)

	self.BaseItemCell:SetItem(itemData)

	if self.equipData.ItemCustomCount == nil then
		self.equipData.ItemCustomCount = 0
	end

	self:RefreshChooseState()
	self.LockState:SetActive(self.equipData.isLock)
	self:RefreshOwnerImage()
	self:RefreshLevel()
	self:RefreshPartIcon()
end

function EquipListCell:RefreshOwnerImage()
	if self.equipData.heroCid ~= 0 then
		local headIconPath = SkinModule.GetHeroCurrentSkinImgPath(self.equipData.heroCid, Constant.SkinImageType.DetailsHeadIcon)

		AssetUtil.LoadImage(self, headIconPath, self.HeroImage:GetComponent("Image"))
		self.HeroImage:SetActive(true)
	else
		self.HeroImage:SetActive(false)
	end
end

function EquipListCell:RefreshLevel()
	self.BaseItemCell:SetItemLv(self.equipData.lv)
end

function EquipListCell:RefreshPartIcon()
	if self.equipData then
		AssetUtil.LoadImage(self, EquipApi:GetEquipPartImg(self.equipData:GetCfg().Part), self.equipPartImg:GetComponent("Image"))
		self.equipPartImg:SetActive(true)
	else
		self.equipPartImg:SetActive(false)
	end
end

function EquipListCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipListCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

return EquipListCell
