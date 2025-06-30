-- chunkname: @IQIGame\\UI\\Common\\DropDownUI.lua

local m = {
	CurDropClickCount = 1
}
local OptionData = UnityEngine.UI.Dropdown.OptionData

function m.New(view, dropCallBack, screenCallBack)
	local obj = Clone(m)

	obj:Init(view, dropCallBack, screenCallBack)

	return obj
end

function m:Init(view, dropCallBack, screenCallBack)
	self.View = view
	self.ClickDropCallBack = dropCallBack
	self.ClickScreenCallBack = screenCallBack

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TypeDropdown = self.View:GetComponent("Dropdown")
	self.ScreenBtnComponent = self.ScreenBtn:GetComponent("Button")

	function self.DelegateDropdownCallback(index)
		self:DropDownCallBack(index)
	end

	function self.DelegateScreenBtnClick()
		self:ScreenBtbClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.TypeDropdown.onValueChanged:AddListener(self.DelegateDropdownCallback)
	self.ScreenBtnComponent.onClick:AddListener(self.DelegateScreenBtnClick)
end

function m:RemoveListeners()
	self.TypeDropdown.onValueChanged:RemoveListener(self.DelegateDropdownCallback)
	self.ScreenBtnComponent.onClick:RemoveListener(self.DelegateScreenBtnClick)
end

function m:SetData(data)
	self:InitDropdownData(data)
end

function m:InitDropdownData(datas)
	self.TypeDropdown.options:Clear()

	for i = 1, #datas do
		local data = OptionData.New(datas[i])

		data.text = datas[i]

		self.TypeDropdown.options:Add(data)
	end

	self.TypeDropdown.value = 0

	self.TypeDropdown:Select()

	self.TypeDropdown.captionText.text = self.TypeDropdown.options[0].text
end

function m:DropDownCallBack(index)
	self.CurTypeDropdownIndex = index + 1

	if self.ClickDropCallBack then
		self.ClickDropCallBack(self.CurTypeDropdownIndex)
	end
end

function m:ScreenBtbClick()
	self.CurDropClickCount = self.CurDropClickCount + 1
	self.CurDropClickCount = self.CurDropClickCount > 2 and 1 or 2

	if self.ClickScreenCallBack then
		self.ClickScreenCallBack(self.CurDropClickCount)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
