-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipTipController.lua

local m = {
	SelectedEquipIndex = 0,
	IsShow = false
}
local EquipDetailView = require("IQIGame.UI.EquipChangeUI.EquipDetailView")

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

	self.SelectedEquipController = EquipDetailView.New(self.SelectedEquipTipCell)
	self.WearingCompareController = EquipDetailView.New(self.WearingCompareTipCell)
	self.LinkTipCell = LinkTipCell.New(self.LinkTipCellGO)

	UGUIUtil.SetText(self.WearingEquipText, FormationChooseEquipUIApi:GetString("TipWearingEquipText"))
	self:AddListeners()
end

function m:Show(soulPrefabPOD, toEquipItemData, selectedEquipIndex)
	self.SoulPrefabPOD = soulPrefabPOD
	self.IsShow = true
	self.ItemData = toEquipItemData

	local equipId = soulPrefabPOD == nil and 0 or soulPrefabPOD.equipments[selectedEquipIndex]

	self.EquipItemDataToBeReplace = WarehouseModule.GetItemDataById(equipId)
	self.SelectedEquipIndex = selectedEquipIndex

	self.View:SetActive(true)

	local isTheSameEquip = self.EquipItemDataToBeReplace ~= nil and toEquipItemData.id == self.EquipItemDataToBeReplace.id

	self.WearingCompareTipView:SetActive(not isTheSameEquip and self.EquipItemDataToBeReplace ~= nil)
	self.SelectedEquipBtn:SetActive(self.SoulPrefabPOD ~= nil)

	if self.SoulPrefabPOD ~= nil then
		UGUIUtil.SetTextInChildren(self.SelectedEquipBtn, FormationChooseEquipUIApi:GetString("TipSelectedEquipBtnText", isTheSameEquip))
	end

	local isShowCompareTip = not isTheSameEquip and self.EquipItemDataToBeReplace ~= nil

	if isShowCompareTip then
		self.WearingCompareController:Refresh(self.EquipItemDataToBeReplace, nil, soulPrefabPOD.soulCid, self:GetWearingEquipCids())
	end

	self.SelectedEquipController:Refresh(toEquipItemData, self.EquipItemDataToBeReplace, self:GetEquipOwnerSoulCid(toEquipItemData), self:GetWearingEquipCids())

	local allDescText
	local cfgItemData = self.ItemData:GetCfg()

	if #cfgItemData.PabilityID[3] > 0 then
		local pabilityCid = cfgItemData.PabilityID[3][self.ItemData.equipData.star]
		local cfgPabilityData = CfgPabilityTable[pabilityCid]

		allDescText = cfgPabilityData.Describe
	end

	if #cfgItemData.PabilityID[4] > 0 then
		local pabilityCid = cfgItemData.PabilityID[4][self.ItemData.equipData.star]
		local cfgPabilityData = CfgPabilityTable[pabilityCid]

		allDescText = allDescText .. cfgPabilityData.Describe
	end

	self.LinkTipCell.View:SetActive(not isShowCompareTip)

	if not isShowCompareTip then
		self.LinkTipCell:Open(allDescText)
	end
end

function m:GetWearingEquipCids()
	if self.SoulPrefabPOD == nil then
		return nil
	end

	local equipCids = {}

	for index, equipId in pairs(self.SoulPrefabPOD.equipments) do
		local itemData = WarehouseModule.GetItemDataById(equipId)

		table.insert(equipCids, itemData.cid)
	end

	return equipCids
end

function m:GetEquipOwnerSoulCid(itemData)
	if itemData == nil then
		logError("itemData is nil")

		return
	end

	if itemData.equipData == nil then
		logError("itemData is not equip")

		return
	end

	for i = 1, #EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs do
		local soulPrefabPOD = EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs[i]

		for index, equipId in pairs(soulPrefabPOD.equipments) do
			if equipId == itemData.id then
				return soulPrefabPOD.soulCid
			end
		end
	end

	return 0
end

function m:Hide(isByChangeEquip)
	self.IsShow = false

	self.View:SetActive(false)

	self.ItemData = nil
	self.EquipItemDataToBeReplace = nil
	self.SelectedEquipIndex = 0

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback(isByChangeEquip)
	end
end

function m:AddListeners()
	self.SelectedEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:RemoveListeners()
	self.SelectedEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:OnClickSelectedEquipBtn()
	local needConfirm = EvilErosionModule.ChangeEquip(self.SoulPrefabPOD, self.SelectedEquipIndex, self.ItemData, function()
		self:Hide(true)
	end)

	if not needConfirm then
		self:Hide(true)
	end
end

function m:Dispose()
	self:RemoveListeners()
	self.SelectedEquipController:OnDestroy()
	self.WearingCompareController:OnDestroy()
	self.LinkTipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
