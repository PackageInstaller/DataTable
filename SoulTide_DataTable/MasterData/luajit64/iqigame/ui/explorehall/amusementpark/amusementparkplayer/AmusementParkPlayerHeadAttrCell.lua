-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerHeadAttrCell.lua

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

function m:SetData(cid, num)
	self.Cid = cid
	self.AttrNum = num

	self:UpdateView()
end

function m:UpdateView()
	local cfgData = CfgAmusementParkAttributeTable[self.Cid]
	local path = UIGlobalApi.GetImagePath(cfgData.ImageIcon)

	AssetUtil.LoadImage(self, path, self.SoulAttrIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SoulAttrValue, self.AttrNum)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
