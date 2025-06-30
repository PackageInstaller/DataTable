-- chunkname: @IQIGame\\UI\\Equip\\MainView\\EquipDetailsView.lua

local EquipDetailsView = {
	noWearEquip = true,
	isShowDetailsPanel = true,
	mainAttibuteCell = {},
	mainAttrbuteConfigList = {},
	equipCellTable = {}
}
local EquipAttributeView = require("IQIGame.UI.Equip.AttributePanel.EquipAttributeView")
local EquipHoleView = require("IQIGame.UI.Equip.EquipHoleView")
local awakenEffectPanel = require("IQIGame/UI/Equip/EquipAwakenEffectPanel")

function EquipDetailsView.New(go)
	local o = Clone(EquipDetailsView)

	o:Initialize(go)

	return o
end

function EquipDetailsView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)
	self:OnInitDelegation()

	self.gameObject = go
	self.EquipAttributeView = EquipAttributeView.New(self.EquipAttributeParent)

	local equipPartToggleFunc = self:EquipPartToggleFuncTable()

	self.EquipHoleView = EquipHoleView.New(self.EquipHoleContent, equipPartToggleFunc, self)
	self.awakenEffectPanel = awakenEffectPanel.New(self.awakenEffectPanel, self)

	self.awakenEffectPanel:Hide()
	self:OnAddListeners()
end

function EquipDetailsView:Dispose()
	self.EquipAttributeView:OnDestroy()
	self.EquipHoleView:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

function EquipDetailsView:EquipPartToggleFuncTable()
	local toggleFuncTable = {}
	local partSortTable = CfgDiscreteDataTable[54].Data

	for i = 1, #partSortTable do
		local partIndex = partSortTable[i]

		toggleFuncTable[partIndex] = function(isOn)
			if isOn then
				UIModule.Open(Constant.UIControllerName.EquipWarehouseUI, Constant.UILayer.UI, partIndex)
			end
		end
	end

	return toggleFuncTable
end

function EquipDetailsView:OnInitDelegation()
	function self.OnClickAdvancedAttributeButton()
		self:ShowAdvancedAttributePanel()
	end

	function self.showAwakenEquipEvent(isShow, SuitIds)
		self:ShowAwakenEquipEvent(isShow, SuitIds)
	end
end

function EquipDetailsView:OnAddListeners()
	self.AdvancedAttributeButton:GetComponent("Button").onClick:AddListener(self.OnClickAdvancedAttributeButton)
	EventDispatcher.AddEventListener(EventID.ShowAwakenEquipEvent, self.showAwakenEquipEvent)
end

function EquipDetailsView:OnRemoveListeners()
	self.AdvancedAttributeButton:GetComponent("Button").onClick:RemoveListener(self.OnClickAdvancedAttributeButton)
	EventDispatcher.RemoveEventListener(EventID.ShowAwakenEquipEvent, self.showAwakenEquipEvent)
end

function EquipDetailsView:Hide()
	self.gameObject:SetActive(false)
end

function EquipDetailsView:Show()
	self.EquipAttributeView:Show()
	self.EquipHoleView:Show()
	self.gameObject:SetActive(true)
end

function EquipDetailsView:ShowAdvancedAttributePanel()
	UIModule.Open(Constant.UIControllerName.AttributeDetailsUI, Constant.UILayer.UI, {
		heroCid = EquipModule.currentHeroCid,
		type = Constant.AttributeUIType.EquipAttribute
	})
end

function EquipDetailsView:ShowAwakenEquipEvent(isShow, SuitIds)
	if isShow then
		self.awakenEffectPanel:Show()
		self.awakenEffectPanel:Refresh(SuitIds)
	else
		self.awakenEffectPanel:Hide()
	end
end

return EquipDetailsView
