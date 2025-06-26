-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineEndRoleCell.lua

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
	if data then
		for i = 1, 4 do
			self["ImgQuality" .. i]:SetActive(data.roleRare == i)
		end

		local path = UIGlobalApi.GetImagePath(data:GetCfgData().HomelandHeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgSoul:GetComponent("Image"))
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
