-- chunkname: @IQIGame\\UI\\Attribute\\AttributeItemCell.lua

local m = {}

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

function m:SetData(attribute, isAddModel, showBg)
	self.attributeData = attribute

	local attrCfg = CfgAttributeTable[attribute.attType]

	UGUIUtil.SetText(self.AttributeName, attrCfg.Name)
	LuaUtility.SetGameObjectShow(self.AttributeImg, attrCfg.ImageUrl ~= "")

	if attrCfg.ImageUrl ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrCfg.ImageUrl), self.AttributeImg:GetComponent("Image"))
	end

	LuaUtility.SetGameObjectShow(self.Bg, showBg)
	self:RefreshAttributeValue(isAddModel)
end

function m:RefreshAttributeValue(isAddModel)
	LuaUtility.SetGameObjectShow(self.AttributeAddNum, false)
	LuaUtility.SetGameObjectShow(self.AttributeAddNumBg, false)

	if isAddModel then
		local isNotZero = self.attributeData.extraValue ~= 0 and self.attributeData.extraValue ~= "0%" and self.attributeData.extraValue ~= "-0%"

		LuaUtility.SetGameObjectShow(self.AttributeAddNum, isNotZero)
		LuaUtility.SetGameObjectShow(self.AttributeAddNumBg, isNotZero)
		UGUIUtil.SetText(self.AttributeAddNum, "(+" .. self.attributeData.extraValue .. ")")
	end

	UGUIUtil.SetText(self.AttributeValue, self.attributeData.attBaseValue)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
