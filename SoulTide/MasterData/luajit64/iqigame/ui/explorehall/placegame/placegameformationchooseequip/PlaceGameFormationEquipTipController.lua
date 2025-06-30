-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseEquip\\PlaceGameFormationEquipTipController.lua

local m = {
	WearingEquipIndex = 0,
	IsShow = false,
	PrefabId = 0
}
local PlaceGameEquipDetailView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameEquipDetailView")

function m.New(view, onClose)
	local obj = Clone(m)

	obj:Init(view, onClose)

	return obj
end

function m:Init(view, onClose)
	self.View = view
	self.OnCloseCallback = onClose

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectedEquipBtn()
		self:OnClickSelectedEquipBtn()
	end

	self.SelectedEquipController = PlaceGameEquipDetailView.New(self.SelectedEquipTipCell)
	self.WearingCompareController = PlaceGameEquipDetailView.New(self.WearingCompareTipCell)
	self.LinkTipCellLeft = LinkTipCell.New(self.LinkTipCellGOLeft)
	self.LinkTipCellRight = LinkTipCell.New(self.LinkTipCellGORight)
	self.EquipCardTipPoints = {}
	self.EquipCardTipPoints[0] = self.PositionPoints.transform:Find("Point_0").gameObject

	for i = 1, 3 do
		self.EquipCardTipPoints[i] = self.PositionPoints.transform:Find("Point_" .. i).gameObject
	end

	UGUIUtil.SetText(self.WearingEquipText, FormationChooseEquipUIApi:GetString("TipWearingEquipText"))
	self:AddListener()
end

function m:AddListener()
	self.SelectedEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:RemoveListener()
	self.SelectedEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:OnClickSelectedEquipBtn()
	local isRemove = self.WearingEquipItemData ~= nil and self.ItemData and self.ItemData.id == self.WearingEquipItemData.id

	if isRemove then
		PlaceGameModule.ModifyWeapon(self.PrefabId, self.WearingEquipItemData.id, false)
	elseif self.ItemData then
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(self.PrefabId)
		local soulData = PlaceGameModule.GetPlaceGameSoulDataByCid(soulPrefabData.placeGameSoulPrefabPOD.soulCid)

		if soulData.placeGameSoulPOD.level < self.ItemData.placeGameEquipData.placeGameEquipPOD.level then
			NoticeModule.ShowNotice(21045104)

			return
		end

		PlaceGameModule.ModifyWeapon(self.PrefabId, self.ItemData.id, true)
	end
end

function m:Show(prefabId, formationIndex, itemData, wearingEquipIndex, tipPointIndex, isLinkCellOnLeft)
	self.PrefabId = prefabId
	self.IsShow = true
	self.ItemData = itemData

	local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

	self.WearingEquipItemData = WarehouseModule.GetItemDataById(soulPrefabData.placeGameSoulPrefabPOD.equipments[wearingEquipIndex])
	self.WearingEquipIndex = wearingEquipIndex
	self.SelectedEquipTipView.transform.localPosition = Vector3.zero

	local tipPoint = self.EquipCardTipPoints[tipPointIndex]

	self.SelectedEquipTipView.transform:SetParent(tipPoint.transform, false)
	self.View:SetActive(true)

	local isSelected = self.WearingEquipItemData ~= nil and itemData.id == self.WearingEquipItemData.id

	self.WearingCompareTipView:SetActive(not isSelected and self.WearingEquipItemData ~= nil)
	UGUIUtil.SetTextInChildren(self.SelectedEquipBtn, FormationChooseEquipUIApi:GetString("TipSelectedEquipBtnText", isSelected))

	local isShowCompareTip = not isSelected and self.WearingEquipItemData ~= nil

	if isShowCompareTip then
		self.WearingCompareController:Refresh(self.WearingEquipItemData, nil, self:GetEquipOwnerSoulCid(self.WearingEquipItemData, formationIndex))
	end

	self.SelectedEquipController:Refresh(itemData, self.WearingEquipItemData, self:GetEquipOwnerSoulCid(itemData, formationIndex))

	local allDescText = ""
	local ids = itemData.placeGameEquipData.placeGameEquipPOD.pAbilityIDEffect1 or {}

	if #ids > 0 then
		for i = 1, #ids do
			local pabilityCid = ids[i]
			local cfgPabilityData = CfgPabilityTable[pabilityCid]

			allDescText = allDescText .. cfgPabilityData.Describe
		end
	end

	local ids = itemData.placeGameEquipData.placeGameEquipPOD.pAbilityIDEffect2 or {}

	if #ids > 0 then
		for i = 1, #ids do
			local pabilityCid = ids[i]
			local cfgPabilityData = CfgPabilityTable[pabilityCid]

			allDescText = allDescText .. cfgPabilityData.Describe
		end
	end

	local hasLinkKeyWordAndNotShowCompare = allDescText ~= nil and not isShowCompareTip

	self.LinkTipCellLeft.View:SetActive(isLinkCellOnLeft and hasLinkKeyWordAndNotShowCompare)
	self.LinkTipCellRight.View:SetActive(not isLinkCellOnLeft and hasLinkKeyWordAndNotShowCompare)

	if isLinkCellOnLeft and hasLinkKeyWordAndNotShowCompare then
		self.LinkTipCellLeft:Open(allDescText)
	end

	if not isLinkCellOnLeft and hasLinkKeyWordAndNotShowCompare then
		self.LinkTipCellRight:Open(allDescText)
	end
end

function m:GetEquipOwnerSoulCid(itemData, formationIndex)
	if itemData == nil then
		logError("itemData is nil")

		return
	end

	if itemData.placeGameEquipData == nil then
		logError("itemData is not placeGameEquipData")

		return
	end

	local isInPrefab = false
	local placeGameSoulCid = 0
	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		isInPrefab, placeGameSoulCid = itemData.placeGameEquipData:CheckEquipIsInPrefab(prefabId)

		if placeGameSoulCid and placeGameSoulCid > 0 then
			break
		end
	end

	local soulCid = 0

	if placeGameSoulCid > 0 then
		soulCid = CfgPlaceGameSoulTable[placeGameSoulCid].SoulID
	end

	return soulCid
end

function m:Hide()
	self.IsShow = false

	self.View:SetActive(false)

	self.ItemData = nil
	self.WearingEquipItemData = nil
	self.WearingEquipIndex = 0

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.SelectedEquipController:Dispose()
	self.WearingCompareController:Dispose()
	self.LinkTipCellLeft:OnDestroy()
	self.LinkTipCellRight:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
