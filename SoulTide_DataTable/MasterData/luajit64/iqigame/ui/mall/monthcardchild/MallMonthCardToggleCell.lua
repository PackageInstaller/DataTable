-- chunkname: @IQIGame\\UI\\Mall\\MonthCardChild\\MallMonthCardToggleCell.lua

local m = {
	MonthCardCid = 0,
	ItemSubType = 0
}

function m.New(view, onValueChanged)
	local obj = Clone(m)

	obj:Init(view, onValueChanged)

	return obj
end

function m:Init(view, onValueChanged)
	self.View = view
	self.OnValueChangedCallback = onValueChanged

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnToggleValueChanged(isOn)
		self:OnToggleValueChanged(isOn)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleValueChanged)
end

function m:RemoveListeners()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleValueChanged)
end

function m:SetData(itemSubType, monthCardCid)
	self.ItemSubType = itemSubType
	self.MonthCardCid = monthCardCid
	self.View:GetComponent("ToggleHelperComponent").text = MallUIApi:GetString("MonthCardToggleText", itemSubType)

	UGUIUtil.SetTextInChildren(self.BoughtFlag, MallUIApi:GetString("monthViewSignBoughtTxt"))
end

function m:OnToggleValueChanged(isOn)
	self.OnValueChangedCallback(self.ItemSubType, isOn)
end

function m:SetToggleValue(value, ignoreEvent)
	if ignoreEvent then
		self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleValueChanged)
	end

	self.View:GetComponent("Toggle").isOn = value

	if ignoreEvent then
		self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleValueChanged)
	end
end

function m:SetInteractable(interactable)
	local toggle = self.View:GetComponent("Toggle")

	toggle.interactable = interactable
end

function m:SetBoughtFlagActive(value)
	self.BoughtFlag:SetActive(value)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnValueChangedCallback = nil
end

return m
