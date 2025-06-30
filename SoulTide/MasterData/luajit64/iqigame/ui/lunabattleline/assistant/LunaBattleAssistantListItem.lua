-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantListItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulHeadCell = SoulHeadCell.New(self.SoulHeadGO, true, false)
end

function m:SetData(assistant)
	local soulPrefab = assistant.soulPrefab

	self.SoulData = SoulData.New()

	self.SoulData:Initialize(soulPrefab.soulCid)

	self.SoulData.lv = soulPrefab.lv
	self.SoulData.soulQualityCid = soulPrefab.qualityId
	self.SoulData.dressCid2D = soulPrefab.dress2DCid
	self.SoulData.dressCid3D = soulPrefab.dress3DCid
	self.SoulData.atts = soulPrefab.attr
	self.SoulData.activationSkillStrengthen = soulPrefab.allSkillStrengths
	self.SoulData.unlockSkillGroups = soulPrefab.unlockSkillGroups
	self.SoulData.exp = soulPrefab.exp
	self.SoulData.talentCids = soulPrefab.activeTalentCids
	self.SoulData.talentGroupCids = soulPrefab.activeTalentGroupCids
	self.SoulData.soulMemoryPieces = soulPrefab.soulMemoryPieces
	self.SoulData.mood = soulPrefab.mood

	self.SoulHeadCell:RefreshView(self.SoulData)

	local starComponent = self.StarGrid:GetComponent("SimpleStarComponent")

	starComponent:UpdateView(5, self.SoulData:GetCfgSoulQuality().Quality)

	local friendData = FriendModule.GetFriendByPId(assistant.player.pid)

	self.FriendTag:SetActive(friendData ~= nil)

	local cfgSoulData = self.SoulData:GetCfgSoul()
	local toggleTexts = {
		cfgSoulData.Name,
		tostring(self.SoulData.lv),
		assistant.player.pName
	}
	local toggleHelperComponent = self.View:GetComponent("ToggleHelperComponent")

	toggleHelperComponent:SetTexts(toggleTexts)
end

function m:Dispose()
	self.SoulHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
