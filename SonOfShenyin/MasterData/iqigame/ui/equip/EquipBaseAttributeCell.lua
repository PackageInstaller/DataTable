-- chunkname: @IQIGame\\UI\\Equip\\EquipBaseAttributeCell.lua

local EquipBaseAttributeCell = {
	isChoose = false,
	isLock = false
}

function EquipBaseAttributeCell.New(go)
	local o = Clone(EquipBaseAttributeCell)

	o:Initialize(go)

	return o
end

function EquipBaseAttributeCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
end

function EquipBaseAttributeCell:Refresh(data)
	UGUIUtil.SetText(self.NameText, data.Config.Name)

	local imageUrl = UIGlobalApi.IconPath .. data.Config.ImageUrl

	AssetUtil.LoadImage(self, imageUrl, self.IconImage:GetComponent("Image"))
	UGUIUtil.SetText(self.NumText, data.Value)
end

function EquipBaseAttributeCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return EquipBaseAttributeCell
