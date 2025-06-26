-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationAttrCell.lua

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

function m:SetData(attrId, prefabAttrValue, soulAttrValue)
	local path = PlaceGamePlayerUpdateUIApi:GetString("AttIconPath", attrId)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))

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

	UGUIUtil.SetText(self.AttrValueText, PlaceGamePlayerFormationUIApi:GetString("SoulInfoAttrValue", attrValueText, addAttrValue, attrId))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
