-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipPrefabItem.lua

local m = {
	IsSelect = false
}
local FormationSimpleEquipCell = require("IQIGame.UI.FormationUI.FormationSimpleEquipCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnToggleChanged(isOn)
		self:OnToggleChanged(isOn)
	end

	function self.DelegateOnClickUnloadAllBtn()
		self:OnClickUnloadAllBtn()
	end

	function self.DelegateOnClickEditNameBtn()
		self:OnClickEditNameBtn()
	end

	self.ItemCells = {}

	for i = 1, 3 do
		local cell = FormationSimpleEquipCell.New(UnityEngine.Object.Instantiate(self.EquipCellPrefab))

		cell.View.transform:SetParent(self.EquipGrid.transform, false)

		self.ItemCells[i] = cell
	end

	UGUIUtil.SetText(self.UnloadAllBtn, FormationChooseEquipUIApi:GetString("PrefabItemUnloadAllBtnText"))
	self.UnloadAllBtn:SetActive(self.View:GetComponent("Toggle").isOn)
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleChanged)
	self.UnloadAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllBtn)
	self.EditNameBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEditNameBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleChanged)
	self.UnloadAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllBtn)
	self.EditNameBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEditNameBtn)
end

function m:SetData(equipmentPrefabPOD, index, soulPrefabData)
	self.EquipmentPrefabPOD = equipmentPrefabPOD
	self.SoulPrefabData = soulPrefabData

	local prefabName = equipmentPrefabPOD.name

	if prefabName == "" then
		prefabName = FormationChooseEquipUIApi:GetString("EquipPrefabNameText", index)
	end

	UGUIUtil.SetText(self.NameText1, prefabName)
	UGUIUtil.SetText(self.NameText2, prefabName)

	local orderText = FormationChooseEquipUIApi:GetString("EquipPrefabOrderText", index)

	UGUIUtil.SetText(self.OrderText1, orderText)
	UGUIUtil.SetText(self.OrderText2, orderText)
	self:UpdateEquips()
end

function m:UpdateEquips()
	for i = 1, #self.ItemCells do
		local cell = self.ItemCells[i]

		cell:SetData(WarehouseModule.GetItemDataById(self.EquipmentPrefabPOD.equipmentMap[i]), self.SoulPrefabData)
	end

	self:RefreshUnloadBtn()
end

function m:OnEquipPrefabUpdate(pod)
	if self.EquipmentPrefabPOD.id == pod.id then
		self.EquipmentPrefabPOD = pod

		self:UpdateEquips()
	end
end

function m:OnSoulPrefabUpdate()
	for i = 1, #self.ItemCells do
		local item = self.ItemCells[i]

		item:UpdateEquipStatus(self.SoulPrefabData)
	end
end

function m:OnToggleChanged(isOn)
	self.IsSelect = isOn

	self:RefreshUnloadBtn()
end

function m:RefreshUnloadBtn()
	local hasEquip = false

	for i, v in pairs(self.EquipmentPrefabPOD.equipmentMap) do
		hasEquip = true

		break
	end

	self.UnloadAllBtn:SetActive(self.IsSelect and hasEquip)
end

function m:OnClickUnloadAllBtn()
	local hasEquip = false

	for i, v in pairs(self.EquipmentPrefabPOD.equipmentMap) do
		hasEquip = true

		break
	end

	if not hasEquip then
		return
	end

	NoticeModule.ShowNotice(21046006, function()
		EquipModule.ReqSaveEquipmentPrefab({}, self.EquipmentPrefabPOD.id)
	end)
end

function m:OnClickEditNameBtn()
	UIModule.Open(Constant.UIControllerName.InputTextUI, Constant.UILayer.UI, {
		yes = function(text)
			if text == "" or string.getUTF8Length(text) > 8 then
				NoticeModule.ShowNotice(21046008)

				return
			end

			SoulPrefabModule.ChangeEquipPrefabName(self.EquipmentPrefabPOD.id, text)
			UGUIUtil.SetText(self.NameText1, text)
			UGUIUtil.SetText(self.NameText2, text)
		end,
		defaultTxt = FormationChooseEquipUIApi:GetString("InputPrefabNameNoticeText")
	})
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.ItemCells do
		local item = self.ItemCells[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.EquipmentPrefabPOD = nil
	self.SoulPrefabData = nil
end

return m
