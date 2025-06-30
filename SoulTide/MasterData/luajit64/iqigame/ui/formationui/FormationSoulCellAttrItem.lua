-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSoulCellAttrItem.lua

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

function m:SetData(attrId, prefabAttrValue, soulAttrValue)
	AssetUtil.LoadImage(self, SoulUIApi:GetString("soulAttIconPath", attrId), self.Icon:GetComponent("Image"), nil, nil, nil, true)

	if self.AttrNameText ~= nil then
		UGUIUtil.SetText(self.AttrNameText, AttributeModule.GetAttName(attrId))
	end

	local attrValueText
	local addAttrValue = 0

	if prefabAttrValue ~= nil then
		attrValueText = AttributeModule.GetAttShowValue(attrId, prefabAttrValue)

		if soulAttrValue ~= nil then
			local prefabAttrShowValue = AttributeModule.GetAttShowNumberValue(attrId, prefabAttrValue)
			local soulAttrShowValue = AttributeModule.GetAttShowNumberValue(attrId, soulAttrValue)

			addAttrValue = prefabAttrShowValue - soulAttrShowValue
		end
	else
		attrValueText = nil
	end

	UGUIUtil.SetText(self.AttrValueText, FormationUIApi:GetString("SoulInfoAttrValue", attrValueText, addAttrValue, attrId))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
