-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationToggleCell.lua

local m = {}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateToggleValueChange(isOn)
		self:OnToggleChange(isOn)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleValueChange)
end

function m:RemoveListener()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleValueChange)
end

function m:OnToggleChange(isOn)
	if isOn and self.selectToggleCallBack then
		self.selectToggleCallBack(self.index)
	end
end

function m:RefreshSelect(top)
	self.View:GetComponent("Toggle").isOn = top
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
