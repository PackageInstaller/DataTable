-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpEnhanceLvOverviewController.lua

local SpEnhanceLvItem = require("IQIGame.UI.SpecialSpirit.SpEnhanceLvItem")
local m = {
	EnhanceLvItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 5 do
		local gameObject = UnityEngine.Object.Instantiate(self.EnhanceLvItemPrefab)

		gameObject.transform:SetParent(self.EnhanceLvGrid.transform, false)

		local item = SpEnhanceLvItem.New(gameObject, i)

		self.EnhanceLvItems[i] = item
	end

	self.EnhanceLvItemPrefab:SetActive(false)
end

function m:SetData(soulData)
	self.SoulData = soulData

	self:Refresh()
end

function m:Refresh()
	AssetUtil.LoadImage(self, SoulUIApi:GetString("SoulHeadIcon", self.SoulData.soulCid), self.SoulHeadIcon:GetComponent("Image"))

	local lv = self.SoulData:GetCurAttrSpiritLevel()
	local maxLv = SoulSpecialSpiritModule.GetMaxAttrSpiritLevel(self.SoulData.soulCid)

	self.EnhanceLvItems[1]:SetData(true, SpecialSpiritUIApi:GetEnhanceLvOverview_AttrLabel(), SpecialSpiritUIApi:GetEnhanceLvOverview_AttrLvText(lv, maxLv))

	for i = 2, #self.EnhanceLvItems do
		local skillIndex = i - 1

		lv = self.SoulData:GetSpSkillLvByIndex(skillIndex)
		maxLv = self.SoulData:GetSpSkillTotalLv(skillIndex)

		local cfgSkillData = self.SoulData:GetSpSkillByIndex(skillIndex)
		local skillName

		if cfgSkillData ~= nil then
			skillName = cfgSkillData.Name
		end

		self.EnhanceLvItems[i]:SetData(cfgSkillData ~= nil, SpecialSpiritUIApi:GetEnhanceLvOverview_SkillLabel(skillIndex, skillName), SpecialSpiritUIApi:GetEnhanceLvOverview_SkillLvText(skillIndex, lv, maxLv))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.EnhanceLvItems do
		self.EnhanceLvItems[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
