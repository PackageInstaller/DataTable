-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipCell.lua

local m = {
	FocusEquipIndex = 0,
	IsNotPrefab = false,
	IsSelected = false
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

	function self.DelegateOnLongClickSelf()
		self:OnLongClickSelf()
	end

	function self.DelegateOnChooseEquipCard(equipIndex)
		self:OnChooseEquipCard(equipIndex)
	end

	function self.DelegateOnUpdateItem(itemDataList)
		self:OnUpdateItem(itemDataList)
	end

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	self.ItemCell:SetMouseEnabled(false)
	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.FormationChooseEquipCard, self.DelegateOnChooseEquipCard)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.FormationChooseEquipCard, self.DelegateOnChooseEquipCard)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:SetData(itemData, soulPrefabOrDollPOD, isNotPrefab)
	self.SoulPrefabOrDollPOD = soulPrefabOrDollPOD
	self.IsNotPrefab = isNotPrefab or false

	self.ItemCell:SetItem(itemData, nil, soulPrefabOrDollPOD, isNotPrefab)
	self:__UpdateIsFocusEquip()
	self:RefreshInQuickMode()
end

function m:SetSelected(value)
	self.IsSelected = value

	self.CheckMark:SetActive(value)
end

function m:OnChooseEquipCard(equipIndex)
	self.FocusEquipIndex = equipIndex

	self:__UpdateIsFocusEquip()
end

function m:__UpdateIsFocusEquip()
	local equipMap = self:GetEquipMap()
	local itemData = equipMap[self.FocusEquipIndex]
	local isFocusEquip = self.ItemCell.ItemCfgOrData ~= nil and itemData ~= nil and self.ItemCell.ItemCfgOrData.id == itemData.id
	local showIndexOnPrefabInQuickMode = self:NeedShowIndexOnPrefabInQuickMode()

	self.FocusMark:SetActive(isFocusEquip and not showIndexOnPrefabInQuickMode)
	self.ItemCell.View.TagView:SetActive(not isFocusEquip and not showIndexOnPrefabInQuickMode)
	self:__UpdateIsFree()
end

function m:__UpdateIsFree()
	local equipIndexOnOtherSlot = -1
	local existedSameIdEquipId
	local equipMap = self:GetEquipMap()

	for i, itemData in pairs(equipMap) do
		if itemData.id == self.ItemCell.ItemCfgOrData.id then
			equipIndexOnOtherSlot = i
		end

		if itemData.cid == self.ItemCell.ItemCfgOrData.cid then
			existedSameIdEquipId = itemData.id
		end
	end

	local isConflict = equipIndexOnOtherSlot == -1 and existedSameIdEquipId ~= nil
	local showIndexOnPrefabInQuickMode = self:NeedShowIndexOnPrefabInQuickMode()

	self.EquipUniqueMark:SetActive(isConflict and not showIndexOnPrefabInQuickMode)
end

function m:RefreshInQuickMode()
	local showIndexOnPrefabInQuickMode, prefabEquipListIndex = self:NeedShowIndexOnPrefabInQuickMode()

	self.QuickChooseView:SetActive(showIndexOnPrefabInQuickMode)

	if showIndexOnPrefabInQuickMode then
		UGUIUtil.SetTextInChildren(self.QuickChooseView, prefabEquipListIndex)
	end
end

function m:NeedShowIndexOnPrefabInQuickMode()
	local prefabEquipListIndex = -1
	local equipMap = self:GetEquipMap()

	for index, itemData in pairs(equipMap) do
		if itemData.id == self.ItemCell.ItemCfgOrData.id then
			prefabEquipListIndex = index

			break
		end
	end

	return self.Host.QuickMode and prefabEquipListIndex ~= -1, prefabEquipListIndex
end

function m:OnUpdateItem(itemDataList)
	for i = 1, #itemDataList do
		local itemData = itemDataList[i]

		if itemData.id == self.ItemCell.ItemCfgOrData.id then
			self:SetData(itemData, self.SoulPrefabOrDollPOD)

			break
		end
	end
end

function m:GetEquipMap()
	if self.IsNotPrefab then
		return MazeDataModule.GetWearingEquipMap(self.SoulPrefabOrDollPOD.soulCid)
	end

	return self.SoulPrefabOrDollPOD.equipItemDatum
end

function m:Dispose()
	self:RemoveListeners()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
