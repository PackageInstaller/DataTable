-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleAssistantSoulHeadCell.lua

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

function m:SetData(soulPrefab)
	self.View:SetActive(soulPrefab ~= nil)

	if soulPrefab == nil then
		return
	end

	local cfgDressData = CfgDressTable[soulPrefab.dress3DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]
	local headIconPath = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LevelText, LunaBattleLineDetailUIApi:GetString("AssistantHeadLevelText", soulPrefab.lv))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
