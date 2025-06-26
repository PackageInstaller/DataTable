-- chunkname: @IQIGame\\UI\\Formation\\RoleDetailsInfo\\FormationAttributeView.lua

local m = {
	AttrItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(heroData)
	self.heroData = heroData

	self:SetRoleAttr()
end

function m:SetRoleAttr()
	local Attrs = {}

	for i, v in pairs(self.heroData.AttributeGroups) do
		if CfgAttributeTable[i] ~= nil and CfgAttributeTable[i].Type == 1 then
			local value = v

			if CfgAttributeTable[i].IsPer == false then
				value = math.floor(value)
			else
				value = string.format("%.3f", value)
				value = value * 100 .. "%"
			end

			table.insert(Attrs, i, {
				attType = i,
				value = value
			})
		end
	end

	table.sort(Attrs, function(a, b)
		return CfgAttributeTable[a.attType].Sort < CfgAttributeTable[b.attType].Sort
	end)

	local index = 1

	for k, v in pairs(Attrs) do
		local attrItem = self:CreateAttrItems(index)

		UGUIUtil.SetText(attrItem.TypeText, RoleDevelopmentModule.GetAttrCfg(k).Name)
		UGUIUtil.SetText(attrItem.ValueText, v.value)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(RoleDevelopmentModule.GetAttrCfg(k).ImageUrl), attrItem.IconImg:GetComponent("Image"))

		index = index + 1
	end
end

function m:CreateAttrItems(index)
	local attrItem = self.AttrItems[index]

	if attrItem == nil then
		local luaOutTable = {}
		local itemObj = UnityEngine.Object.Instantiate(self.AttributeItemPrefab)

		itemObj:SetActive(true)
		itemObj.transform:SetParent(self.AttributeGroup.transform, false)

		attrItem = LuaCodeInterface.BindOutlet(itemObj, luaOutTable)
		self.AttrItems[index] = attrItem
	end

	return attrItem
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
