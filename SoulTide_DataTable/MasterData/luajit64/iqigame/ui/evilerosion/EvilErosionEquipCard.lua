-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipCard.lua

local m = {
	IsSelected = false,
	FocusEquipIndex = 0
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	self.EquipCell = EquipCell.New(self.EquipCardGO)
	self.EquipCell.enableClick = false

	UGUIUtil.SetTextInChildren(self.CanEnhanceTag, EvilErosionEquipListUIApi:GetString("EquipCard_CanEnhanceTagText"))
	UGUIUtil.SetTextInChildren(self.CurIndexEquipTag, EvilErosionEquipListUIApi:GetString("EquipCard_CurIndexEquipTagText"))
	UGUIUtil.SetTextInChildren(self.BeWearingTag, EvilErosionEquipListUIApi:GetString("EquipCard_BeWearingTagText"))
	UGUIUtil.SetTextInChildren(self.EquipUniqueMark, EvilErosionEquipListUIApi:GetString("EquipCard_EquipUniqueMarkText"))
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(itemData, soulPrefabPOD)
	self.ItemData = itemData
	self.SoulPrefabPOD = soulPrefabPOD

	local itemShowData = table.clone(itemData)

	itemShowData.equipData.lock = false

	self.EquipCell:Refresh(itemShowData, nil, true)
	self:__UpdateIsCurIndexEquip()
	self:__UpdateIsWearing()
	self:RefreshInQuickMode()
	self:RefreshInEnhanceMode()
end

function m:__UpdateIsCurIndexEquip()
	local equipId

	if self.SoulPrefabPOD ~= nil then
		equipId = self.SoulPrefabPOD.equipments[self.FocusEquipIndex]
	end

	local itemData = WarehouseModule.GetItemDataById(equipId)
	local isCurIndexEquip = self.ItemData ~= nil and itemData ~= nil and self.ItemData.id == itemData.id
	local showIndexOnPrefabInQuickMode = self:NeedShowIndexOnPrefabInQuickMode()

	self.CurIndexEquipTag:SetActive(isCurIndexEquip and not showIndexOnPrefabInQuickMode)
	self:__UpdateIsFree()
end

function m:NeedShowIndexOnPrefabInQuickMode()
	local prefabEquipListIndex = -1

	if self.SoulPrefabPOD ~= nil then
		for index, equipId in pairs(self.SoulPrefabPOD.equipments) do
			if equipId == self.ItemData.id then
				prefabEquipListIndex = index

				break
			end
		end
	end

	return self.Host.QuickMode and prefabEquipListIndex ~= -1, prefabEquipListIndex
end

function m:__UpdateIsFree()
	local equipIndexOnOtherSlot = -1
	local existedSameIdEquipId

	if self.SoulPrefabPOD ~= nil then
		for index, equipId in pairs(self.SoulPrefabPOD.equipments) do
			if equipId == self.ItemData.id then
				equipIndexOnOtherSlot = index
			end

			local itemData = WarehouseModule.GetItemDataById(equipId)

			if itemData.cid == self.ItemData.cid then
				existedSameIdEquipId = itemData.id
			end
		end
	end

	local isConflict = equipIndexOnOtherSlot == -1 and existedSameIdEquipId ~= nil
	local showIndexOnPrefabInQuickMode = self:NeedShowIndexOnPrefabInQuickMode()

	self.EquipUniqueMark:SetActive(isConflict and not showIndexOnPrefabInQuickMode)
end

function m:__UpdateIsWearing()
	local ownerSoulPrefabPOD = EvilErosionModule.GetEquipOwner(self.ItemData.id)

	self.BeWearingTag:SetActive(ownerSoulPrefabPOD ~= nil)

	if ownerSoulPrefabPOD ~= nil then
		local cfgDressData = CfgDressTable[ownerSoulPrefabPOD.dress2DCid]
		local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon), self.WearingSoulHeadImage:GetComponent("Image"))
	end
end

function m:RefreshInQuickMode()
	local showIndexOnPrefabInQuickMode, prefabEquipListIndex = self:NeedShowIndexOnPrefabInQuickMode()

	self.QuickChooseView:SetActive(showIndexOnPrefabInQuickMode)

	if showIndexOnPrefabInQuickMode then
		UGUIUtil.SetTextInChildren(self.QuickChooseView, prefabEquipListIndex)
	end
end

function m:RefreshInEnhanceMode()
	local canEnhance = false

	if self.Host.EnhanceMode then
		local isMaxStar = self.ItemData.equipData.star >= self.ItemData:GetCfg().StarLimit

		if not isMaxStar then
			local costIdNumMap = EvilErosionModule.GetEnhanceCost(self.ItemData)

			canEnhance = true

			for itemCid, needNum in pairs(costIdNumMap) do
				if needNum > WarehouseModule.GetItemNumByCfgID(itemCid) then
					canEnhance = false

					break
				end
			end
		end
	end

	self.CanEnhanceTag:SetActive(canEnhance)
end

function m:SetSelected(value)
	self.IsSelected = value

	self.CheckMark:SetActive(value)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.EquipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
