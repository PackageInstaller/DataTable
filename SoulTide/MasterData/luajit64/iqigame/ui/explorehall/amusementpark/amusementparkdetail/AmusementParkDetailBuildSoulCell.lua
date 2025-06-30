-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailBuildSoulCell.lua

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

function m:SetData(soulCid)
	local path = UIGlobalApi.GetImagePath(CfgAmusementParkRoleTable[soulCid].HomelandHeadIcon)

	AssetUtil.LoadImage(self, path, self.Img:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
