-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMain\\AmusementParkMainAssetCell.lua

local m = {
	value = 0
}

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

function m:SetData(id)
	self.cid = id

	self:Refresh()
end

function m:Refresh()
	local cfgData = CfgAmusementParkAttributeTable[self.cid]

	UGUIUtil.SetText(self.TextName, cfgData.AttName)

	local path = UIGlobalApi.GetImagePath(cfgData.ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

	if self.cid == AmusementParkConstant.ParkAttr.ParkAttr_Level then
		self.value = AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level
	elseif self.cid == AmusementParkConstant.ParkAttr.ParkAttr_PlayerNum then
		self.value = #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave
	end

	UGUIUtil.SetText(self.TextValue, self.value)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
