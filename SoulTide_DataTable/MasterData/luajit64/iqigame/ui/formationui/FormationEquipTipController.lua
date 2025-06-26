-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipTipController.lua

local m = {
	WearingEquipIndex = 0,
	IsShow = false,
	PrefabId = 0
}
local EquipDetailView = require("IQIGame.UI.EquipChangeUI.EquipDetailView")

function m.New(view, onClose, onClickInfoBtn, onClickEnhanceBtn)
	local obj = Clone(m)

	obj:Init(view, onClose, onClickInfoBtn, onClickEnhanceBtn)

	return obj
end

function m:Init(view, onClose, onClickInfoBtn, onClickEnhanceBtn)
	self.View = view
	self.OnCloseCallback = onClose
	self.OnClickInfoBtnCallback = onClickInfoBtn
	self.OnClickEnhanceBtnCallback = onClickEnhanceBtn

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickInfoBtn()
		self:OnClickInfoBtn()
	end

	function self.DelegateOnClickEnhanceBtn()
		self:OnClickEnhanceBtn()
	end

	function self.DelegateOnClickSelectedEquipBtn()
		self:OnClickSelectedEquipBtn()
	end

	self.SelectedEquipController = EquipDetailView.New(self.SelectedEquipTipCell)
	self.WearingCompareController = EquipDetailView.New(self.WearingCompareTipCell)
	self.LinkTipCellLeft = LinkTipCell.New(self.LinkTipCellGOLeft)
	self.LinkTipCellRight = LinkTipCell.New(self.LinkTipCellGORight)
	self.EquipCardTipPoints = {}
	self.EquipCardTipPoints[0] = self.PositionPoints.transform:Find("Point_0").gameObject

	for i = 1, 3 do
		self.EquipCardTipPoints[i] = self.PositionPoints.transform:Find("Point_" .. i).gameObject
	end

	UGUIUtil.SetText(self.WearingEquipText, FormationChooseEquipUIApi:GetString("TipWearingEquipText"))
	UGUIUtil.SetTextInChildren(self.InfoBtn, FormationChooseEquipUIApi:GetString("TipInfoBtnText"))
	UGUIUtil.SetTextInChildren(self.EnhanceBtn, FormationChooseEquipUIApi:GetString("TipEnhanceBtnText"))
	self:AddListeners()
end

function m:Show(prefabId, formationIndex, itemData, wearingEquipIndex, tipPointIndex, isLinkCellOnLeft)
	self.PrefabId = prefabId
	self.IsShow = true
	self.ItemData = itemData

	local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

	self.WearingEquipItemData = soulPrefabData.equipItemDatum[wearingEquipIndex]
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
		self.WearingCompareController:Refresh(self.WearingEquipItemData, nil, self:GetEquipOwnerSoulCid(self.WearingEquipItemData, formationIndex), self:GetWearingEquipCids())
	end

	self.SelectedEquipController:Refresh(itemData, self.WearingEquipItemData, self:GetEquipOwnerSoulCid(itemData, formationIndex), self:GetWearingEquipCids())

	local allDescText
	local cfgItemData = itemData:GetCfg()

	if #cfgItemData.PabilityID[3] > 0 then
		local pabilityCid = cfgItemData.PabilityID[3][itemData.equipData.star]
		local cfgPabilityData = CfgPabilityTable[pabilityCid]

		allDescText = cfgPabilityData.Describe
	end

	if #cfgItemData.PabilityID[4] > 0 then
		local pabilityCid = cfgItemData.PabilityID[4][itemData.equipData.star]
		local cfgPabilityData = CfgPabilityTable[pabilityCid]

		allDescText = allDescText .. cfgPabilityData.Describe
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

function m:GetWearingEquipCids()
	local equipCids = {}
	local soulPrefabData = SoulPrefabModule.GetPrefab(self.PrefabId)

	for i, itemData in pairs(soulPrefabData.equipItemDatum) do
		table.insert(equipCids, itemData.cid)
	end

	return equipCids
end

function m:GetEquipOwnerSoulCid(itemData, formationIndex)
	if itemData == nil then
		logError("itemData is nil")

		return
	end

	if itemData.equipData == nil then
		logError("itemData is not equip")

		return
	end

	local soulCid = 0

	if itemData.equipData.isWore then
		local formation = FormationModule.GetFormationByIndex(formationIndex).formation

		for prefabId, prefabIndex in pairs(formation) do
			for i, itemDataOwnerPrefabId in pairs(itemData.equipData.soulPrefabIds) do
				if itemDataOwnerPrefabId == prefabId then
					local prefab = SoulPrefabModule.GetPrefab(prefabId)

					if prefab == nil then
						logError("找不到灵魂预设。prefabId: " .. prefabId)

						break
					end

					soulCid = prefab.soulCid

					break
				end
			end
		end
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

function m:AddListeners()
	self.InfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickInfoBtn)
	self.EnhanceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnhanceBtn)
	self.SelectedEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:RemoveListeners()
	self.InfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickInfoBtn)
	self.EnhanceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnhanceBtn)
	self.SelectedEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:OnClickInfoBtn()
	self.OnClickInfoBtnCallback(self.ItemData)
	self:Hide()
end

function m:OnClickEnhanceBtn()
	self.OnClickEnhanceBtnCallback(self.ItemData)
	self:Hide()
end

function m:OnClickSelectedEquipBtn()
	local needConfirm = FormationModule.ChangeEquip(self.PrefabId, self.WearingEquipIndex, self.ItemData, function()
		self:Hide()
	end)

	if not needConfirm then
		self:Hide()
	end
end

function m:Dispose()
	self:RemoveListeners()
	self.SelectedEquipController:OnDestroy()
	self.WearingCompareController:OnDestroy()
	self.LinkTipCellLeft:OnDestroy()
	self.LinkTipCellRight:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
