-- chunkname: @IQIGame\\UI\\Setting\\SettingChildMessageRender.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.Toggle:GetComponent("ToggleHelperComponent"):SetTexts({
		SettingUIApi:GetString("TextToggleOpen"),
		SettingUIApi:GetString("TextToggleClose")
	})

	self.toggle = self.Toggle:GetComponent("Toggle")

	function self.delegateToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	self:AddListener()
end

function m:AddListener()
	self.toggle.onValueChanged:AddListener(self.delegateToggleChange)
end

function m:RemoveListener()
	self.toggle.onValueChanged:RemoveListener(self.delegateToggleChange)
end

function m:SetData(cfgData)
	self.cfgData = cfgData

	UGUIUtil.SetText(self.TextTitle, self.cfgData.Title)
end

function m:UpdateToggleState()
	local value = SettingModule.GetMessageChildSwitch(self.cfgData.Id)

	if value == 1 then
		self.toggle.isOn = true
	else
		self.toggle.isOn = false
	end
end

function m:OnToggleChange(isOn)
	if isOn then
		SettingModule.SaveMessageChildSwitch(self.cfgData.Id, 1)
	else
		SettingModule.SaveMessageChildSwitch(self.cfgData.Id, 0)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
