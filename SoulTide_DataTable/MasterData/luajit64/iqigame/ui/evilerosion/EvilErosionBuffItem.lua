-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionBuffItem.lua

local BuffCell = require("IQIGame.UI.Common.BuffCell")
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

function m:SetData(speEffectCid)
	local cfgSkillSpecialEffectExplainData = CfgSkillSpecialEffectExplainTable[speEffectCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSkillSpecialEffectExplainData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.DescText, EvilErosionBuffTipsUIApi:GetString("BuffInfoItemPrefab_DescText", cfgSkillSpecialEffectExplainData.EffectName, cfgSkillSpecialEffectExplainData.Describe))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
