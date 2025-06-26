-- chunkname: @IQIGame\\Module\\Jewelry\\JewelryData.lua

local m = {
	num = 0
}

function m.New(cid, num, id, newJewelryEquipmentVoPOD)
	local o = Clone(m)

	o:Init(cid, num, id, newJewelryEquipmentVoPOD)

	return o
end

function m:Init(cid, num, id, newJewelryEquipmentVoPOD)
	self.itemCid = cid
	self.num = num
	self.id = id
	self.newJewelryEquipmentVoPOD = newJewelryEquipmentVoPOD
end

function m:IsPutOnPrefab(prefabID)
	if self.newJewelryEquipmentVoPOD then
		return table.indexOf(self.newJewelryEquipmentVoPOD.soul, prefabID) ~= -1
	end

	return false
end

function m:GetJewelryQualityData()
	for i, v in pairsCfg(CfgJewelryQualityTable) do
		if v.JewelryId == self.itemCid and v.QualityLevel == self.newJewelryEquipmentVoPOD.star then
			return v
		end
	end

	return nil
end

function m:GetWearInFormationState(formation)
	local formationPOD = FormationModule.GetFormationByIndex(formation)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local isPutOnInPrefab = self:IsPutOnPrefab(prefabId)

		if isPutOnInPrefab then
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			if soulPrefabData then
				return isPutOnInPrefab, soulPrefabData.soulCid
			end
		end
	end

	return false, 0
end

return m
