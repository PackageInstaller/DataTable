-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainEdit\\AmusementParkMainEditAssetCell.lua

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

function m:SetData(id, num)
	self.cid = id

	local cfgData = CfgAmusementParkAttributeTable[self.cid]

	UGUIUtil.SetText(self.TextName, cfgData.AttName)
	UGUIUtil.SetText(self.TextValue, num)

	local path = UIGlobalApi.GetImagePath(cfgData.ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
