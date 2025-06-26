-- chunkname: @IQIGame\\UI\\Soul\\SoulAttrItem.lua

local m = {
	AttrId = 0,
	IsBlack = false
}

function m.New(view, isBlack)
	local obj = Clone(m)

	obj:Init(view, isBlack)

	return obj
end

function m:Init(view, isBlack)
	self.View = view

	if isBlack ~= nil then
		self.IsBlack = isBlack
	end

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(attrId, attrValue)
	local path = SoulUIApi:GetString("soulAttIconPath", attrId, self.IsBlack)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameLabel, AttributeModule.GetAttName(attrId))
	UGUIUtil.SetText(self.ValueText, AttributeModule.GetAttShowValue(attrId, attrValue))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
