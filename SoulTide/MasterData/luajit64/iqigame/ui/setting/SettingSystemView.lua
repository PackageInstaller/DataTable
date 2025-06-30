-- chunkname: @IQIGame\\UI\\Setting\\SettingSystemView.lua

local m = {
	ignoreEquipLockToggleChange = false,
	childMessageCells = {}
}
local SettingChildMessageRender = require("IQIGame.UI.Setting.SettingChildMessageRender")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextSystemTitle, SettingUIApi:GetString("TextSystemTitle"))
	UGUIUtil.SetText(self.TextPerformance, SettingUIApi:GetString("TextPerformance"))
	UGUIUtil.SetText(self.TextPerformanceDes, SettingUIApi:GetString("TextPerformanceDes"))
	UGUIUtil.SetText(self.TextDark, SettingUIApi:GetString("TextDark"))
	UGUIUtil.SetText(self.TextDarkDes, SettingUIApi:GetString("TextDarkDes"))
	UGUIUtil.SetText(self.TextAnimation, SettingUIApi:GetString("TextAnimation"))
	UGUIUtil.SetText(self.TextMessage, SettingUIApi:GetString("TextMessage"))
	UGUIUtil.SetText(self.TextMessageDes, SettingUIApi:GetString("TextMessageDes"))
	self.TogglePerformance:GetComponent("ToggleHelperComponent"):SetTexts({
		SettingUIApi:GetString("TextToggleOpen"),
		SettingUIApi:GetString("TextToggleClose")
	})
	self.ToggleDark:GetComponent("ToggleHelperComponent"):SetTexts({
		SettingUIApi:GetString("TextToggleOpen"),
		SettingUIApi:GetString("TextToggleClose")
	})
	self.ToggleMessage:GetComponent("ToggleHelperComponent"):SetTexts({
		SettingUIApi:GetString("TextToggleOpen"),
		SettingUIApi:GetString("TextToggleClose")
	})

	self.togglePerformance = self.TogglePerformance:GetComponent("Toggle")
	self.toggleDark = self.ToggleDark:GetComponent("Toggle")
	self.toggleMessageMainSwitch = self.ToggleMessage:GetComponent("Toggle")

	function self.delegateTogglePerformanceChange(isOn)
		self:OnTogglePerformanceChange(isOn)
	end

	function self.delegateToggleDarkChange(isOn)
		self:OnToggleDarkChange(isOn)
	end

	function self.delegateToggleAnimation()
		self:OnToggleAnimation()
	end

	function self.delegateToggleMessageMainSwitch(isOn)
		self:OnToggleMessageMainSwitch(isOn)
	end

	function self.DelegateOnChangeSettingComplete(isSuccess, key, value)
		self:OnChangeSettingComplete(isSuccess, key, value)
	end

	self.EquipLockToggles = {}
	self.EquipLockToggleCallbacks = {}

	for i = 1, 2 do
		self.EquipLockToggles[i] = self["ToggleEquipLock" .. i]:GetComponent(typeof(UnityEngine.UI.Toggle))
		self.EquipLockToggleCallbacks[i] = function(isOn)
			self:OnToggleEquipLockChanged(i, isOn)
		end
	end

	self.ChildMessageMould:SetActive(false)

	for i, v in pairsCfg(CfgPushMessageTable) do
		local obj = UnityEngine.Object.Instantiate(self.ChildMessageMould)

		obj.transform:SetParent(self.ChildMessage.transform, false)
		obj:SetActive(true)

		local cell = SettingChildMessageRender.New(obj)

		cell:SetData(v)
		table.insert(self.childMessageCells, cell)
	end
end

function m:OnMainUIOpen()
	return
end

function m:OnMainUIClose()
	self:Close()
end

function m:AddEventListener()
	self.togglePerformance.onValueChanged:AddListener(self.delegateTogglePerformanceChange)
	self.toggleDark.onValueChanged:AddListener(self.delegateToggleDarkChange)
	self.toggleMessageMainSwitch.onValueChanged:AddListener(self.delegateToggleMessageMainSwitch)

	for i = 1, 3 do
		self["ToggleAnimation" .. i]:GetComponent("Toggle").onValueChanged:AddListener(self.delegateToggleAnimation)
	end

	for i = 1, #self.EquipLockToggles do
		self.EquipLockToggles[i].onValueChanged:AddListener(self.EquipLockToggleCallbacks[i])
	end

	EventDispatcher.AddEventListener(EventID.OnChangeSettingComplete, self.DelegateOnChangeSettingComplete)
end

function m:RemoveEventListener()
	self.togglePerformance.onValueChanged:RemoveListener(self.delegateTogglePerformanceChange)
	self.toggleDark.onValueChanged:RemoveListener(self.delegateToggleDarkChange)
	self.toggleMessageMainSwitch.onValueChanged:RemoveListener(self.delegateToggleMessageMainSwitch)

	for i = 1, 3 do
		self["ToggleAnimation" .. i]:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateToggleAnimation)
	end

	for i = 1, #self.EquipLockToggles do
		self.EquipLockToggles[i].onValueChanged:RemoveListener(self.EquipLockToggleCallbacks[i])
	end

	EventDispatcher.RemoveEventListener(EventID.OnChangeSettingComplete, self.DelegateOnChangeSettingComplete)
end

function m:OnTogglePerformanceChange(isOn)
	if isOn then
		SettingModule.SaveTargetFrameRate(60)
	else
		SettingModule.SaveTargetFrameRate(30)
	end
end

function m:OnToggleDarkChange(isOn)
	if isOn then
		SettingModule.SaveDark(1)
	else
		SettingModule.SaveDark(0)
	end
end

function m:OnToggleAnimation()
	local selectIndex

	for i = 1, 3 do
		local toggle = self["ToggleAnimation" .. i]:GetComponent("Toggle")

		if toggle.isOn == true then
			selectIndex = i

			break
		end
	end

	SettingModule.SaveUltimateAnimationState(selectIndex)
end

function m:OnToggleMessageMainSwitch(isOn)
	if isOn then
		SettingModule.SaveMessageMainSwitch(1)
	else
		SettingModule.SaveMessageMainSwitch(0)
	end
end

function m:OnToggleEquipLockChanged(index, isOn)
	if self.ignoreEquipLockToggleChange then
		return
	end

	if not isOn then
		return
	end

	local lockState = 1

	if index == 2 and isOn then
		lockState = 0
	end

	SettingModule.SendChangeSetting(Constant.ServerSettingKey.AutoLockEquip, lockState)
end

function m:OnChangeSettingComplete(isSuccess, key, value)
	if not isSuccess and key == Constant.ServerSettingKey.AutoLockEquip then
		local index = value == 1 and 1 or 2

		self:SelectEquipLockToggle(index)
	end
end

function m:SelectEquipLockToggle(index)
	self.ignoreEquipLockToggleChange = true

	local toggle = self["ToggleEquipLock" .. index]:GetComponent(typeof(UnityEngine.UI.Toggle))

	toggle.isOn = true
	self.ignoreEquipLockToggleChange = false
end

function m:UpdateView()
	local ToggleAnimationTitle = SettingUIApi:GetString("ToggleAnimationTitle")

	for i = 1, 3 do
		self["ToggleAnimation" .. i]:GetComponent("ToggleHelperComponent").text = ToggleAnimationTitle[i]
	end

	if SettingModule.targetFrameRate == 60 then
		self.togglePerformance.isOn = true
	else
		self.togglePerformance.isOn = false
	end

	if SettingModule.closeDark == 1 then
		self.toggleDark.isOn = true
	else
		self.toggleDark.isOn = false
	end

	self["ToggleAnimation" .. SettingModule.ultimateAnimationState]:GetComponent("Toggle").isOn = true

	if SettingModule.messageMainSwitch == 1 then
		self.toggleMessageMainSwitch.isOn = true
	else
		self.toggleMessageMainSwitch.isOn = false
	end

	for i, v in pairs(self.childMessageCells) do
		v:UpdateToggleState()
	end

	local isAutoLockEquip = true

	if PlayerModule.PlayerInfo.playerSetting ~= nil then
		local isAutoLockEquipValue = PlayerModule.PlayerInfo.playerSetting[Constant.ServerSettingKey.AutoLockEquip]

		if isAutoLockEquipValue ~= nil and isAutoLockEquipValue == 0 then
			isAutoLockEquip = false
		end
	end

	self:SelectEquipLockToggle(isAutoLockEquip and 1 or 2)
end

function m:Open()
	self.View:SetActive(true)
	self:UpdateView()
	self:AddEventListener()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveEventListener()
end

function m:Dispose()
	for i, v in pairs(self.childMessageCells) do
		v:Dispose()
	end

	self.EquipLockToggles = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
