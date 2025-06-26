-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseSoul\\PlaceGameFormationChooseSoulCell.lua

local m = {
	isCurrent = false,
	prefabIndex = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetSelect(value)
	self.View:GetComponent("Toggle").isOn = value
end

function m:SetData(placeGameSoulData, formationIndex, currentPrefabId)
	self.placeGameSoulData = placeGameSoulData

	local curPrefab = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(currentPrefabId)

	self.isCurrent = curPrefab.placeGameSoulPrefabPOD.soulCid == placeGameSoulData.cid
	self.prefabIndex = 0

	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)

		if soulPrefabData.placeGameSoulPrefabPOD.soulCid == placeGameSoulData.cid then
			self.prefabIndex = prefabIndex

			break
		end
	end

	local cfgSoulResData = CfgSoulResTable[self.placeGameSoulData:GetCfgPlaceGameSoulData().SoulResID]
	local path = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.LvValueText, self.placeGameSoulData.placeGameSoulPOD.level)
	self.CurTag:SetActive(self.isCurrent)
	self.UsingTag:SetActive(not self.isCurrent and self.prefabIndex ~= 0)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
