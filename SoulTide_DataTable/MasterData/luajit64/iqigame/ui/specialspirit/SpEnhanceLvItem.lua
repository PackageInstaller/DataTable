-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpEnhanceLvItem.lua

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

function m:SetData(isReleased, label, textValue)
	self.View:SetActive(isReleased)

	if not isReleased then
		return
	end

	UGUIUtil.SetText(self.EnhanceSkillName, label)
	UGUIUtil.SetText(self.EnhanceLvText, textValue)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SoulData = nil
end

return m
