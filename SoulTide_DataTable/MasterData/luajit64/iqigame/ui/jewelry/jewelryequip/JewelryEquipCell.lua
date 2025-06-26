-- chunkname: @IQIGame\\UI\\Jewelry\\JewelryEquip\\JewelryEquipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlot, false)

	self:AddListener()
	self:SetSelectionState(false)
	self:SetWearState(false, nil)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data, formationIndex)
	self.jewelryEquipData = data

	self.itemCell:SetItem(self.jewelryEquipData)

	local isWearing, soulCid = self.jewelryEquipData.jewelryData:GetWearInFormationState(formationIndex)

	self:SetWearState(isWearing, soulCid)
end

function m:SetSelectionState(top)
	self.Check:SetActive(top)
end

function m:SetWearState(top, soulCid)
	self.itemCell:ShowWearJewelryTag(soulCid, top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.itemCell:Dispose()

	self.itemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
