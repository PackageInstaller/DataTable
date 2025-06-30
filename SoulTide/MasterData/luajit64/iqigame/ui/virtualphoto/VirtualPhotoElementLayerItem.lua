-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoElementLayerItem.lua

local m = {
	IsDragging = false,
	Index = 0,
	HasData = false
}

function m.New(view, index, onToggleOn, onDelete)
	local obj = Clone(m)

	obj:Init(view, index, onToggleOn, onDelete)

	return obj
end

function m:Init(view, index, onToggleOn, onDelete)
	self.View = view
	self.Index = index
	self.OnToggleOnCallback = onToggleOn
	self.OnDeleteCallback = onDelete

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnMainToggleChanged(isOn)
		self:OnMainToggleChanged(isOn)
	end

	function self.DelegateOnClickDeleteBtn()
		self:OnClickDeleteBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.MainToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnMainToggleChanged)
	self.DeleteBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDeleteBtn)
end

function m:RemoveListeners()
	self.MainToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnMainToggleChanged)
	self.DeleteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDeleteBtn)
end

function m:SetData(elementController)
	self.HasData = elementController ~= nil

	self.View:SetActive(elementController ~= nil)
	self:SetDragging(false)
	self:HideLine()

	if elementController == nil then
		return
	end

	local toggleHelper = self.MainToggle:GetComponent("ToggleHelperComponent")
	local texts = {}

	texts[1] = tostring(self.Index)
	texts[2] = VirtualPhotoEditUIApi:GetString("ElementLayer_TypeName", elementController.CfgVirtualPhotoElementData.Type)
	texts[3] = elementController.CfgVirtualPhotoElementData.Name

	toggleHelper:SetTexts(texts)

	local toggle = self.MainToggle:GetComponent("Toggle")

	self.MainToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnMainToggleChanged)

	toggle.isOn = elementController.IsSelected

	self.MainToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnMainToggleChanged)
end

function m:OnMainToggleChanged(isOn)
	if isOn then
		self.OnToggleOnCallback(self.Index)
	end
end

function m:OnClickDeleteBtn()
	self.OnDeleteCallback(self.Index)
end

function m:ShowLine(isTopLine)
	self.TopInsertNoticeLine:SetActive(isTopLine)
	self.BottomInsertNoticeLine:SetActive(not isTopLine)
end

function m:HideLine()
	self.TopInsertNoticeLine:SetActive(false)
	self.BottomInsertNoticeLine:SetActive(false)
end

function m:SetDragging(value)
	self.IsDragging = value

	self.Root:SetActive(not value)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
