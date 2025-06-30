-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipAttrItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(attrId, attrValue)
	AssetUtil.LoadImage(self, SoulUIApi:GetString("soulAttIconPath", attrId), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.AttrNameText, AttributeModule.GetAttName(attrId))
	UGUIUtil.SetText(self.AttrValueText, AttributeModule.GetAttShowValue(attrId, attrValue))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
