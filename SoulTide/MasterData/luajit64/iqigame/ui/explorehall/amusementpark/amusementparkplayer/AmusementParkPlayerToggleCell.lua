-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerToggleCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(str, index)
	self.View:GetComponent("ToggleHelperComponent").text = str

	for i = 1, 3 do
		self["index" .. i]:SetActive(i == index)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
