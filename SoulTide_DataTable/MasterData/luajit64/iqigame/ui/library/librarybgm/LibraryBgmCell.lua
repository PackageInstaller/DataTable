-- chunkname: @IQIGame\\UI\\Library\\LibraryBgm\\LibraryBgmCell.lua

local m = {
	isFavor = false
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
		self:OnToggleChange(isOn)
	end

	self:AddListener()
end

function m:AddListener()
	self.FavorToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggle)
end

function m:RemoveListener()
	self.FavorToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggle)
end

function m:SetData(data, isFavor)
	self.cfgData = data
	self.isFavor = isFavor

	self:UpdateView()
end

function m:OnToggleChange(isOn)
	self.isFavor = isOn

	if self.favorCallBack then
		self.favorCallBack(self.cfgData.Id, isOn)
	end
end

function m:UpdateView()
	self.FavorToggle:GetComponent("Toggle").isOn = self.isFavor

	UGUIUtil.SetText(self.TextIDOff, self.cfgData.Id)
	UGUIUtil.SetText(self.TextNameOff, self.cfgData.Name)
	UGUIUtil.SetText(self.TextTimeOff, self.cfgData.Time)
	UGUIUtil.SetText(self.TextIDOn, self.cfgData.Id)
	UGUIUtil.SetText(self.TextNameOn, self.cfgData.Name)
	UGUIUtil.SetText(self.TextTimeOn, self.cfgData.Time)
end

function m:RefreshSelect(top)
	self.StateOff:SetActive(not top)
	self.StateOn:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	self.favorCallBack = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
