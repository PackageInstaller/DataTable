-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantSoulInfo.lua

local FormationSoulCellAttrItem = require("IQIGame.UI.FormationUI.FormationSoulCellAttrItem")
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

	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = FormationSoulCellAttrItem.New(UnityEngine.Object.Instantiate(self.AttrItemPrefab))

		item.View.transform:SetParent(self.AttrGrid.transform, false)

		self.AttrItems[i] = item
	end

	UGUIUtil.SetText(self.PowerLabel, LunaBattleLineAssistantUIApi:GetString("SoulInfoPowerLabel"))
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(soulPrefab)
	local showAttrIds = SoulUIApi:GetString("fightAttSort")

	for i = 1, #showAttrIds do
		local item = self.AttrItems[i]
		local attrId = showAttrIds[i]
		local prefabAttrValue = soulPrefab.attr[attrId]

		item:SetData(attrId, prefabAttrValue)
	end

	local cfgDressData = CfgDressTable[soulPrefab.dress2DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.SoulFormationImage), self.SoulPortraitImage:GetComponent("Image"))

	local cfgSoulQualityData = CfgSoulQualityTable[soulPrefab.qualityId]

	self.SoulStar:GetComponent("SimpleStarComponent"):UpdateView(5, cfgSoulQualityData.Quality)
	UGUIUtil.SetText(self.LevelText, LunaBattleLineAssistantUIApi:GetString("SoulInfoLevelText", soulPrefab.lv))
	UGUIUtil.SetText(self.PowerText, soulPrefab.power)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i = 1, #self.AttrItems do
		local item = self.AttrItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
