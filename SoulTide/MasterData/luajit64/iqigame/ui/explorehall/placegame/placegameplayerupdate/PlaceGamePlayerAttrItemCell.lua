-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerUpdate\\PlaceGamePlayerAttrItemCell.lua

local m = {
	AttrId = 0
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

function m:SetData(attrId, attrValue)
	local path = PlaceGamePlayerUpdateUIApi:GetString("AttIconPath", attrId)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameLabel, AttributeModule.GetAttName(attrId))
	UGUIUtil.SetText(self.ValueText, AttributeModule.GetAttShowValue(attrId, attrValue))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
