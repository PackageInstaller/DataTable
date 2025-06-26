-- chunkname: @IQIGame\\UI\\MazeSubmitItem\\MazeSubmitItemRequireCell.lua

local m = {
	Enabled = false
}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetEnabled(value)
	self.Enabled = value

	self.View:SetActive(value)
end

function m:SetData(itemData)
	self.EmptyView:SetActive(itemData == nil)
	self.NormalView:SetActive(itemData ~= nil)
	self.ItemCell:SetItem(itemData, 1)
end

function m:OnClickSelf()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self)
	end
end

function m:Dispose()
	self:RemoveListeners()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
