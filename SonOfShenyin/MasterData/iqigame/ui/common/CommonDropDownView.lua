-- chunkname: @IQIGame\\UI\\Common\\CommonDropDownView.lua

local m = {}

function m.New(view, dropCallBack, screenCallBack)
	local obj = Clone(m)

	obj:Init(view, dropCallBack, screenCallBack)

	return obj
end

function m:Init(view, dropCallBack)
	self.View = view
	self.ClickDropCallBack = dropCallBack

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TypeDropdown = self.View:GetComponent("Dropdown")

	function self.DelegateDropdownCallback(index)
		self:DropDownCallBack(index)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.TypeDropdown.onValueChanged:AddListener(self.DelegateDropdownCallback)
end

function m:RemoveListeners()
	self.TypeDropdown.onValueChanged:RemoveListener(self.DelegateDropdownCallback)
end

function m:SetData(datas, normalSelectIndex)
	self:InitDropdownData(datas, normalSelectIndex)
end

function m:InitDropdownData(datas, normalSelectIndex)
	self.TypeDropdown.options:Clear()

	for i = 1, #datas do
		local data = UnityEngine.UI.Dropdown.OptionData.New(datas[i])

		data.text = datas[i]

		self.TypeDropdown.options:Add(data)
	end

	self.TypeDropdown.value = normalSelectIndex - 1

	self.TypeDropdown:Select()

	self.TypeDropdown.captionText.text = self.TypeDropdown.options[normalSelectIndex - 1].text
end

function m:DropDownCallBack(index)
	self.CurTypeDropdownIndex = index + 1

	if self.ClickDropCallBack then
		self.ClickDropCallBack(self.CurTypeDropdownIndex)
	end
end

function m:Dispose()
	self:RemoveListeners()

	self.TypeDropdown = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
