-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameBag\\PlaceGameBagItemCell.lua

local m = {
	isSelect = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	self.ItemCell:SetMouseEnabled(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(itemData, isLockMode)
	self.itemData = itemData

	self.ItemCell:SetItem(itemData)

	local isLock = false
	local placeGameEquipData = itemData.placeGameEquipData

	if placeGameEquipData and placeGameEquipData.placeGameEquipPOD then
		isLock = placeGameEquipData.placeGameEquipPOD.lock
	end

	self.ItemCell:SetEquipLock(isLock)
	self.EquipUniqueMark:SetActive(isLock and isLockMode)
	self.placeGameEquipType:SetActive(itemData:GetCfg().Type == Constant.ItemType.PlaceGameEquip)

	local type = itemData:GetCfg().SubType

	self.TagArms:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Arms)
	self.TagEquipment:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Equipment)
	self.TagJewelry:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Jewelry)

	local showOtherWearTag, placeGameSoulCid = itemData.placeGameEquipData:IsWearingState()
	local soulCid = 0

	if placeGameSoulCid > 0 then
		soulCid = CfgPlaceGameSoulTable[placeGameSoulCid].SoulID
	end

	self.ItemCell:ShowWearTag1("", false)
	self.ItemCell:ShowWearTag2(soulCid, showOtherWearTag)
	self.FocusMark:SetActive(itemData.placeGameEquipData.selectRecovery)
	self.ItemCell:ShowLV(itemData.placeGameEquipData.placeGameEquipPOD.level, true)
end

function m:SetSelect(top)
	self.isSelect = top

	self.CheckMark:SetActive(self.isSelect)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
