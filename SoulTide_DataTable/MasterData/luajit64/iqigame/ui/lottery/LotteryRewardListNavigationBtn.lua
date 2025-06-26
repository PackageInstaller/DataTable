-- chunkname: @IQIGame\\UI\\Lottery\\LotteryRewardListNavigationBtn.lua

local m = {
	Index = 0
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

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:SetData(label, possibility, index)
	self.Index = index

	UGUIUtil.SetText(self.Label, label)
	UGUIUtil.SetText(self.PossibilityText, possibility .. "%")
end

function m:OnClickSelf()
	self.OnClickCallback(self.Index)
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
