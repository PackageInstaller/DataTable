-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseEquip\\PlaceGameFormationEquipItemCell.lua

local m = {}

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

function m:SetData(itemData, selectFormationEquipCardItemData, formationIndex, prefabID)
	self.itemData = itemData

	self.ItemCell:SetItem(itemData)

	local isLock = false
	local placeGameEquipData = itemData.placeGameEquipData

	if placeGameEquipData and placeGameEquipData.placeGameEquipPOD then
		isLock = placeGameEquipData.placeGameEquipPOD.isLock
	end

	self.ItemCell:SetEquipLock(isLock)
	self.placeGameEquipType:SetActive(itemData:GetCfg().Type == Constant.ItemType.PlaceGameEquip)

	local type = itemData:GetCfg().SubType

	self.TagArms:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Arms)
	self.TagEquipment:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Equipment)
	self.TagJewelry:SetActive(type == Constant.PlaceGameEquipType.PlaceGame_Field_Jewelry)

	local isFocusMark = false

	if selectFormationEquipCardItemData and selectFormationEquipCardItemData.id == itemData.id then
		isFocusMark = true
	end

	self.FocusMark:SetActive(isFocusMark)

	local showWearTag, placeGameSoulCid = itemData.placeGameEquipData:CheckEquipIsInPrefab(prefabID)
	local tagStr = PlaceGameFormationChooseEquipUIApi:GetString("TextWear", true)
	local showTag1 = showWearTag and not isFocusMark

	self.ItemCell:ShowWearTag1(tagStr, showTag1)

	local showOtherWearTag = false
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(formationIndex)

	if formationPOD then
		for k, v in pairs(formationPOD.formation) do
			if k ~= prefabID then
				showOtherWearTag, placeGameSoulCid = itemData.placeGameEquipData:CheckEquipIsInPrefab(k)

				if showOtherWearTag then
					break
				end
			end
		end
	end

	local showTag2 = showOtherWearTag and not isFocusMark
	local soulCid = 0

	if placeGameSoulCid > 0 then
		soulCid = CfgPlaceGameSoulTable[placeGameSoulCid].SoulID
	end

	self.ItemCell:ShowWearTag2(soulCid, showTag2)
	self.ItemCell:ShowLV(itemData.placeGameEquipData.placeGameEquipPOD.level, true)
end

function m:SetSelected(value)
	self.IsSelected = value

	self.CheckMark:SetActive(value)
end

function m:Dispose()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
