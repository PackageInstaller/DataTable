-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Enhance\\LunaBattleEnhanceChooseSoulCell.lua

local m = {
	ConflictSoul = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.UsingTag, FormationChooseSoulUIApi:GetString("SoulCellInTeamText"))
end

function m:SetData(soulPrefab, isSelectAtPrevUI, teamPrefabs)
	self.SoulPrefab = soulPrefab

	if self.SoulPrefab == nil then
		self.ConflictSoul = false

		return
	end

	local cfgDressData = CfgDressTable[soulPrefab.dress2DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]
	local path = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LvValueText, soulPrefab.lv)

	local isInTeam = table.indexOf(teamPrefabs, soulPrefab) ~= -1
	local conflictSoul = false

	for i = 1, #teamPrefabs do
		local teamPrefab = teamPrefabs[i]

		if teamPrefab.soulCid == soulPrefab.soulCid and teamPrefab.id ~= soulPrefab.id then
			conflictSoul = true

			break
		end
	end

	self.ConflictSoul = conflictSoul

	self.CurTag:SetActive(isSelectAtPrevUI)
	self.UsingTag:SetActive(not isSelectAtPrevUI and isInTeam)
	self.ConflictSoulTag:SetActive(conflictSoul)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
