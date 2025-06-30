-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\AttrGrowupQualityItemCell.lua

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

function m:SetData(curValue, nextValue, type)
	UGUIUtil.SetText(self.TitleText, CfgAttributeTable[type].Name)
	UGUIUtil.SetText(self.ValueText, string.format("%s - %s", curValue, nextValue))
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
