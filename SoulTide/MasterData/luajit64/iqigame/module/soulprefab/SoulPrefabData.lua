-- chunkname: @IQIGame\\Module\\SoulPrefab\\SoulPrefabData.lua

SoulPrefabData = {
	position = 0,
	optionalSkill = 0
}

function SoulPrefabData.New()
	local o = Clone(SoulPrefabData)

	return o
end

function SoulPrefabData:Initialize(SoulPrefabPOD)
	self:Update(SoulPrefabPOD)
end

function SoulPrefabData:Update(soulPrefabPOD)
	self.customSkills = {}
	self.attrs = {}
	self.equipItemDatum = {}
	self.soulCid = soulPrefabPOD.soulCid
	self.id = soulPrefabPOD.id
	self.soulCid = soulPrefabPOD.soulCid
	self.power = soulPrefabPOD.power

	if self.power == nil then
		self.power = 0
	end

	self.attrs = soulPrefabPOD.attr
	self.skillGroupId = soulPrefabPOD.skillGroupId
	self.customSkills = soulPrefabPOD.customSkills

	for i, v in pairs(soulPrefabPOD.equipments) do
		self.equipItemDatum[i] = WarehouseModule.GetItemDataById(v)
	end

	self.position = soulPrefabPOD.position
	self.optionalSkill = soulPrefabPOD.optionalSkill
	self.jewelrySpeeds = soulPrefabPOD.jewelrySpeeds
	self.newJewelrySpeeds = soulPrefabPOD.newJewelrySpeeds
end

function SoulPrefabData:CheckExistSameEquip(id, cid)
	for i, v in pairs(self.equipItemDatum) do
		if v.id ~= nil and v.id ~= id and v.cid == cid then
			return true
		end
	end

	return false
end

function SoulPrefabData:GetSkills()
	if self.soulCid == nil then
		return nil
	end

	local cfgSoulData = CfgSoulTable[self.soulCid]
	local groupIndex = table.indexOf(cfgSoulData.DefaultSkill, self.skillGroupId)

	if groupIndex == -1 then
		logError("在Soul.DefaultSkill里找不到对应的技能系。GroupId：" .. self.skillGroupId)

		return nil
	end

	local cfgGroupId

	if groupIndex ~= 3 then
		cfgGroupId = self.skillGroupId
	elseif self.customSkills == nil then
		cfgGroupId = cfgSoulData.DefaultSkill[1]
	end

	if cfgGroupId ~= nil then
		local cfgSkillGroupData = CfgSkillGroupTable[cfgGroupId]

		return cfgSkillGroupData.GroupSkills
	end

	return self.customSkills
end

function SoulPrefabData:GetEquipJewelryAndSpeed()
	if self.newJewelrySpeeds == nil then
		return nil, 0
	end

	for i, v in pairs(self.newJewelrySpeeds) do
		return i, v
	end

	return nil, 0
end
