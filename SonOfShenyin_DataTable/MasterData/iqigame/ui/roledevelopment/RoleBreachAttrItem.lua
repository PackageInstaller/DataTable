-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreachAttrItem.lua

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

function m:SetData(heroData, curAttrData, nextAttrData, index, lastAttrData)
	self.heroAttrDic = heroData.AttributeDir
	self.AttrType = nextAttrData.AttrType[index]

	if lastAttrData == nil then
		self.lastAttrData = 0
	else
		self.lastAttrData = lastAttrData.AttrValue[index]
	end

	UGUIUtil.SetText(self.AttrName, RoleDevelopmentModule.GetAttrCfg(self.AttrType).Name)
	UGUIUtil.SetText(self.CurAttrText, self:SetTextType(self.AttrType, self.heroAttrDic[self.AttrType].No_attValue, true))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgAttributeTable[self.AttrType].ImageUrl), self.AttrImg:GetComponent("Image"))
	self.NextAttrText:SetActive(not heroData:IsMaxBreachLv())
	self.ArrowImg:SetActive(not heroData:IsMaxBreachLv())

	if not heroData:IsMaxBreachLv() then
		UGUIUtil.SetText(self.NextAttrText, self:SetTextType(self.AttrType, RoleDevelopmentModule.PreviewHeroData.attr[self.AttrType], true))
	end
end

function m:SetTextType(attrId, value, needRide)
	if CfgAttributeTable[attrId].IsPer then
		value = string.format("%.3f", value)

		if needRide then
			value = value * 100 .. "%"
		else
			value = value .. "%"
		end
	else
		value = math.floor(value)
	end

	return value
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)
end

return m
