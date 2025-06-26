-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameEquipData.lua

local m = {
	selectRecovery = false
}

function m.New(id, cid, placeGameEquipPOD)
	local o = Clone(m)

	o:Init(id, cid, placeGameEquipPOD)

	return o
end

function m:Init(id, cid, placeGameEquipPOD)
	self.id = id
	self.cid = cid
	self.placeGameEquipPOD = placeGameEquipPOD
end

function m:CheckEquipIsInPrefab(prefabID)
	local top = false
	local placeGameSoulCid = 0
	local prefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabID)

	if prefabData then
		for i, v in pairs(prefabData.placeGameSoulPrefabPOD.equipments) do
			if v == self.id then
				top = true
				placeGameSoulCid = prefabData.placeGameSoulPrefabPOD.soulCid

				break
			end
		end
	end

	if placeGameSoulCid == nil then
		placeGameSoulCid = 0
	end

	return top, placeGameSoulCid
end

function m:IsWearingState()
	local top, placeGameSoulCid

	for i, v in pairs(PlaceGameModule.placeGameSoulPrefabList) do
		top, placeGameSoulCid = self:CheckEquipIsInPrefab(v.id)

		if top then
			if placeGameSoulCid == nil then
				placeGameSoulCid = 0
			end

			return top, placeGameSoulCid
		end
	end

	return false, 0
end

return m
