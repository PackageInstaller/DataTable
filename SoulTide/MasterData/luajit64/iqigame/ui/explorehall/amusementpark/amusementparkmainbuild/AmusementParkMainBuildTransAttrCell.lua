-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildTransAttrCell.lua

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

function m:SetData(attrID, attrValue)
	local cfgAttrData = CfgAmusementParkAttributeTable[attrID]
	local path = UIGlobalApi.GetImagePath(cfgAttrData.ImageIcon)

	AssetUtil.LoadImage(self, path, self.AttrIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.AttrDes, AmusementParkMainBuildUIApi:GetString("AttrDes", attrValue * 0.01, cfgAttrData.AttName))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
