-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionEquipPabilityItem.lua

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

function m:SetData(pabilityCid)
	local cfgPabilityData = CfgPabilityTable[pabilityCid]

	UGUIUtil.SetText(self.NameText, cfgPabilityData.Name)
	UGUIUtil.SetText(self.DescText, EquipUIApi:GetString("goEffectDesc1", UIGlobalApi.GetTextWithoutKeywordTag(cfgPabilityData.Describe)))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
