-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildCell.lua

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

function m:SetData(data)
	self.BuildData = data

	if self.BuildData then
		local path = UIGlobalApi.GetImagePath(self.BuildData:GetCfgData().Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		self.MaxLv:SetActive(self.BuildData:IsMaxLevel())
	end
end

function m:SetSelect(top)
	self.Select:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
