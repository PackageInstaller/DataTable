-- chunkname: @IQIGame\\UI\\EndlessPlusMaze\\EndlessPlusMazeRuneCell.lua

local m = {}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, onEquip)
	local obj = Clone(m)

	obj:Init(view, onEquip)

	return obj
end

function m:Init(view, onEquip)
	self.View = view
	self.OnEquipCallback = onEquip

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnEquipToggleValueChanged(isOn)
		self:OnEquipToggleValueChanged(isOn)
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, false)

	self:AddListeners()

	local toggleHelper = self.EquipToggle:GetComponent("ToggleHelperComponent")
	local texts = EndlessPlusSelectRuneUIApi:GetString("RuneCell_EquipToggle_Texts")

	toggleHelper:SetTexts(texts)
end

function m:AddListeners()
	self.EquipToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnEquipToggleValueChanged)
end

function m:RemoveListeners()
	self.EquipToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnEquipToggleValueChanged)
end

function m:SetData(cfgRuneData, isViewMode, isEquipped)
	self.CfgRuneData = cfgRuneData

	self.View:SetActive(cfgRuneData ~= nil)
	self.RuneCell:SetDataByCID(cfgRuneData.Id)
	self.EquipToggle:SetActive(not isViewMode)

	if cfgRuneData == nil then
		return
	end

	if not isViewMode then
		self:SetToggleNoCallback(isEquipped)
	end

	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
end

function m:OnEquipToggleValueChanged(isOn)
	self.OnEquipCallback(self.CfgRuneData, isOn, self)
end

function m:SetToggleNoCallback(isOn)
	local equipToggle = self.EquipToggle:GetComponent("Toggle")

	if equipToggle.isOn ~= isOn then
		equipToggle.onValueChanged:RemoveListener(self.DelegateOnEquipToggleValueChanged)

		equipToggle.isOn = isOn

		equipToggle.onValueChanged:AddListener(self.DelegateOnEquipToggleValueChanged)
	end
end

function m:Dispose()
	self.RuneCell:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
