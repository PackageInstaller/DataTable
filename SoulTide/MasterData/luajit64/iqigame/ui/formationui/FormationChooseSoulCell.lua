-- chunkname: @IQIGame\\UI\\FormationUI\\FormationChooseSoulCell.lua

local m = {
	IsCurrent = false,
	PrefabIndex = false
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

function m:SetData(soulData, formationIndex, currentPrefabId)
	self.SoulData = soulData

	local curPrefab = SoulPrefabModule.GetPrefab(currentPrefabId)

	self.IsCurrent = curPrefab.soulCid == soulData.soulCid
	self.PrefabIndex = 0

	local formationPOD = FormationModule.GetFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == soulData.soulCid then
			self.PrefabIndex = prefabIndex

			break
		end
	end

	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local path = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LvValueText, soulData.lv)
	self.CurTag:SetActive(self.IsCurrent)
	self.UsingTag:SetActive(not self.IsCurrent and self.PrefabIndex ~= 0)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
