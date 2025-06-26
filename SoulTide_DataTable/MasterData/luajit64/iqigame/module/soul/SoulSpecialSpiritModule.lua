-- chunkname: @IQIGame\\Module\\Soul\\SoulSpecialSpiritModule.lua

SoulSpecialSpiritModule = {
	__AllAddAttrTypes = {},
	__MaxAttrSpiritStageMap = {},
	__MaxAttrSpiritLevelMap = {},
	__GroupLvDataDictMap = {},
	__GroupStageCfgListMap = {},
	__SkillMaxLvCfgMap = {},
	__SkillStrengthensMap = {}
}

function SoulSpecialSpiritModule.Init()
	local m = SoulSpecialSpiritModule
	local addAttrMaps = {}

	for i, cfgData in pairsCfg(CfgSoulSpecialSpiritTable) do
		local soulCid = cfgData.SoulId

		if cfgData.Group == 1 then
			local maxStep = m.GetOrCreateFromMap(m.__MaxAttrSpiritStageMap, soulCid, true, 0)

			m.__MaxAttrSpiritStageMap[soulCid] = math.max(maxStep, cfgData.Stage)

			local maxLevel = m.GetOrCreateFromMap(m.__MaxAttrSpiritLevelMap, soulCid, true, 0)

			m.__MaxAttrSpiritLevelMap[soulCid] = math.max(maxLevel, cfgData.Level)
		end

		local attrMap = m.GetOrCreateFromMap(addAttrMaps, soulCid)

		for attrIndex, attrType in pairs(cfgData.AttType) do
			attrMap[attrType] = attrType
		end

		local groupLevelCfgMap = m.GetOrCreateFromMap(m.__GroupLvDataDictMap, soulCid)
		local levelCfgMap = m.GetOrCreateFromMap(groupLevelCfgMap, cfgData.Group)

		levelCfgMap[cfgData.Level] = cfgData

		if cfgData.Skill ~= 0 then
			local maxLvCfgData = m.__SkillMaxLvCfgMap[cfgData.Skill]

			if maxLvCfgData == nil or cfgData.Level > maxLvCfgData.Level then
				maxLvCfgData = cfgData
			end

			m.__SkillMaxLvCfgMap[cfgData.Skill] = maxLvCfgData
		end

		local strengthenList = m.__SkillStrengthensMap[cfgData.Skill]

		if strengthenList == nil or #cfgData.ADDSkillStrengthen > #strengthenList then
			m.__SkillStrengthensMap[cfgData.Skill] = cfgData.ADDSkillStrengthen
		end
	end

	for skillCid, strengthenList in pairs(m.__SkillStrengthensMap) do
		local newList = table.clone(strengthenList)

		m.__SkillStrengthensMap[skillCid] = newList
	end

	for soulCid, addAttrMap in pairs(addAttrMaps) do
		local attrTypes = {}

		for _, attrType in pairs(addAttrMap) do
			table.insert(attrTypes, attrType)
		end

		table.sort(attrTypes)

		m.__AllAddAttrTypes[soulCid] = attrTypes
	end
end

function SoulSpecialSpiritModule.GetOrCreateFromMap(map, key, valueIsValueType, default)
	valueIsValueType = valueIsValueType or false

	if valueIsValueType and default == nil or not valueIsValueType and default ~= nil then
		logError("参数default非法。")
	end

	local value = map[key]

	if value ~= nil then
		return value
	end

	value = valueIsValueType and default or {}
	map[key] = value

	return value
end

function SoulSpecialSpiritModule.GetSpSkillIndex(group)
	return group - 1
end

function SoulSpecialSpiritModule.GetSpiritGroup(index)
	return index + 1
end

function SoulSpecialSpiritModule.GetSpSkillIndexByOptionalSkillIndex(index)
	return index + 2
end

function SoulSpecialSpiritModule.GetOptionalSkillIndexBySpSkillIndex(index)
	if index <= 2 then
		return -1
	end

	return index - 2
end

function SoulSpecialSpiritModule.IsSpSkillGroup(group)
	return group == 2 or group == 3 or group == 4 or group == 5
end

function SoulSpecialSpiritModule.GetSpSkillNum()
	return 4
end

function SoulSpecialSpiritModule.GetMaxAttrSpiritStage(soulCid)
	return SoulSpecialSpiritModule.__MaxAttrSpiritStageMap[soulCid] or 0
end

function SoulSpecialSpiritModule.GetMaxAttrSpiritLevel(soulCid)
	return SoulSpecialSpiritModule.__MaxAttrSpiritLevelMap[soulCid] or 0
end

function SoulSpecialSpiritModule.GetAddAttrTypes(soulCid)
	return SoulSpecialSpiritModule.__AllAddAttrTypes[soulCid] or {}
end

function SoulSpecialSpiritModule.GetCfgData(soulCid, group, level)
	local groupLevelCfgMap = SoulSpecialSpiritModule.__GroupLvDataDictMap[soulCid]

	if groupLevelCfgMap == nil then
		return nil
	end

	local levelCfgMap = groupLevelCfgMap[group]

	if levelCfgMap == nil then
		return nil
	end

	return levelCfgMap[level]
end

function SoulSpecialSpiritModule.GetMaxLvInGroup(soulCid, group)
	local levelCfgDataMap = SoulSpecialSpiritModule.__GetLevelCfgMapBySoulGroup(soulCid, group)

	if levelCfgDataMap == nil then
		return 0
	end

	local maxLevel = 0

	for level, cfgData in pairs(levelCfgDataMap) do
		maxLevel = math.max(maxLevel, level)
	end

	return maxLevel
end

function SoulSpecialSpiritModule.GetCfgListByGroupStage(soulCid, group, stage)
	local m = SoulSpecialSpiritModule
	local cfgDataList = m.__GetCfgListByGroupStage(soulCid, group, stage)

	if cfgDataList ~= nil then
		return cfgDataList
	end

	local levelCfgDataMap = m.__GetLevelCfgMapBySoulGroup(soulCid, group)

	if levelCfgDataMap == nil then
		return nil
	end

	cfgDataList = {}

	for level, cfgData in pairs(levelCfgDataMap) do
		if cfgData.Stage == stage then
			table.insert(cfgDataList, cfgData)
		end
	end

	table.sort(cfgDataList, function(cfgData1, cfgData2)
		return cfgData1.Level < cfgData2.Level
	end)

	local groupStageCfgListMap = m.GetOrCreateFromMap(m.__GroupStageCfgListMap, soulCid)
	local stageCfgListMap = m.GetOrCreateFromMap(groupStageCfgListMap, group)

	stageCfgListMap[stage] = cfgDataList

	return cfgDataList
end

function SoulSpecialSpiritModule.__GetLevelCfgMapBySoulGroup(soulCid, group)
	local groupLevelCfgDataMap = SoulSpecialSpiritModule.__GroupLvDataDictMap[soulCid]

	if groupLevelCfgDataMap == nil then
		return nil
	end

	return groupLevelCfgDataMap[group]
end

function SoulSpecialSpiritModule.__GetCfgListByGroupStage(soulCid, group, stage)
	local groupStageCfgList = SoulSpecialSpiritModule.__GroupStageCfgListMap[soulCid]

	if groupStageCfgList == nil then
		return nil
	end

	local map = groupStageCfgList[group]

	if map == nil then
		return nil
	end

	return map[stage]
end

function SoulSpecialSpiritModule.CheckSpAllActive(skillCid)
	local maxCfgData = SoulSpecialSpiritModule.__SkillMaxLvCfgMap[skillCid]

	if maxCfgData ~= nil then
		local soulData = SoulModule.GetSoulData(maxCfgData.SoulId)
		local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndex(maxCfgData.Group)

		if soulData.CfgSoulSpecialSpirits[skillIndex] ~= nil and soulData.CfgSoulSpecialSpirits[skillIndex].Level >= maxCfgData.Level then
			return true
		end
	end

	return false
end

function SoulSpecialSpiritModule.GetAllSpStrengthens(skillCid)
	return SoulSpecialSpiritModule.__SkillStrengthensMap[skillCid]
end
