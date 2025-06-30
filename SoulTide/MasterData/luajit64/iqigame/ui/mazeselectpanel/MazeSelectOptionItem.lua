-- chunkname: @IQIGame\\UI\\MazeSelectPanel\\MazeSelectOptionItem.lua

local m = {
	Index = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self.EnabledView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:SetData(index, optionText, selectable, conditionText, onClick)
	self.Index = index
	self.OnClickCallback = onClick

	self.EnabledView:SetActive(selectable)
	self.DisabledView:SetActive(not selectable)

	local btnText = MazeSelectPanelUIApi:GetString("BtnText", optionText, selectable, conditionText)

	if selectable then
		UGUIUtil.SetTextInChildren(self.EnabledView, btnText)
	else
		UGUIUtil.SetTextInChildren(self.DisabledView, btnText)
	end
end

function m:OnClickSelf()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self.Index)
	end
end

function m:Dispose()
	self.EnabledView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
