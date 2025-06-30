-- chunkname: @IQIGame\\UI\\Girl\\RandomSecretary\\RandomSecretarySoulCell.lua

local m = {
	isSelect = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnToggle(isOn)
		self:OnToggle(isOn)
	end

	self:AddListener()
	self:SetSelect(self.isSelect)
end

function m:AddListener()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggle)
end

function m:RemoveListener()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggle)
end

function m:SetData(soulID)
	self.soulID = soulID

	self:UpdateView()
end

function m:UpdateView()
	if self.soulID then
		self.View:GetComponent("ToggleHelperComponent").text = CfgSoulTable[self.soulID].Name
	end
end

function m:OnToggle(isOn)
	self.isSelect = isOn
end

function m:SetSelect(top)
	self.View:GetComponent("Toggle").isOn = top
	self.isSelect = top
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.selectCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
