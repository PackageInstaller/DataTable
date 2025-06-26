-- chunkname: @IQIGame\\Module\\Skill\\SkillModule.lua

SkillModule = {}

function SkillModule.GetStrengthen(skillId)
	local ret = {}

	for i, v in pairsCfg(CfgSkillStrengthenTable) do
		if v.INSkill == skillId and v.StrengthenType == 1 then
			ret[#ret + 1] = v
		end
	end

	table.sort(ret, function(a, b)
		return a.Order < b.Order
	end)

	return ret
end

function SkillModule.GetFeatureEffectDesc(soulData, skillId)
	local effectTxt = CfgSkillTable[skillId].EffectText
	local cfgSoulQualityData = soulData:GetCfgSoulQuality()
	local ret

	for i, v in pairs(cfgSoulQualityData.ADDSkillStrengthen) do
		local cfgStrengthenData = CfgSkillStrengthenTable[v]

		if cfgStrengthenData.INSkill == skillId and cfgStrengthenData.StrengthenType == 2 then
			if ret == nil then
				ret = cfgStrengthenData
			elseif cfgStrengthenData.Order > ret.Order then
				ret = cfgStrengthenData
			end
		end
	end

	if ret ~= nil then
		effectTxt = ret.Describe
	end

	return effectTxt
end

function SkillModule.GetSkillLv(skillId, soulData, customSkillStrengthen)
	local skillStrengthen

	if soulData ~= nil then
		skillStrengthen = soulData.activationSkillStrengthen
	end

	if customSkillStrengthen ~= nil then
		skillStrengthen = customSkillStrengthen
	end

	if skillStrengthen ~= nil then
		local cfgDatum = SkillModule.GetStrengthen(skillId)
		local lv = 0

		for i, v in pairs(cfgDatum) do
			if table.indexOf(skillStrengthen, v.Id) ~= -1 then
				lv = lv + 1
			end
		end

		return lv
	else
		return 0
	end
end

function SkillModule.GetDamageTypes(skillCids)
	local types = {}
	local typeDic = {}

	for i, v in ipairs(skillCids) do
		local cfgData = CfgSkillTable[v]

		if cfgData.ShowDamageType ~= 0 and typeDic[cfgData.ShowDamageType] == nil then
			typeDic[cfgData.ShowDamageType] = cfgData.ShowDamageType
			types[#types + 1] = cfgData.ShowDamageType
		end

		for j, k in ipairs(cfgData.SubSkills) do
			local subTypes = SkillModule.GetDamageTypes({
				k
			})

			for m, n in ipairs(subTypes) do
				if n ~= 0 and typeDic[n] == nil then
					typeDic[n] = n
					types[#types + 1] = n
				end
			end
		end
	end

	return types
end

function SkillModule.CheckSkillCanUp(soulData, cfgSkillData)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_SKILL) == false then
		return false
	end

	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_SKILL_UP) == false then
		return false
	end

	local cfgStrengthenDataTarget
	local cfgStrengthenDatum = SkillModule.GetStrengthen(cfgSkillData.Id)

	for i, v in ipairs(cfgStrengthenDatum) do
		if table.indexOf(soulData.activationSkillStrengthen, v.Id) == -1 and cfgStrengthenDataTarget == nil then
			cfgStrengthenDataTarget = v
		end
	end

	if cfgStrengthenDataTarget == nil then
		return false
	end

	if soulData.lv < cfgStrengthenDataTarget.UnLockLv then
		return false
	end

	for i, v in ipairs(cfgStrengthenDataTarget.UnLockCost) do
		if i % 2 ~= 0 then
			local id = v
			local count = cfgStrengthenDataTarget.UnLockCost[i + 1]
			local ownCount = WarehouseModule.GetItemNumByCfgID(id)

			if ownCount < count then
				return false
			end
		end
	end

	return true
end

function SkillModule.CheckSkillGroupUnlock(soulData, id)
	return table.indexOf(soulData.unlockSkillGroups, id) ~= -1
end

function SkillModule.CheckSkillGroupCanUnlock(soulData, cfgGroupData)
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_SKILL) == false then
		return false
	end

	if SkillModule.CheckSkillGroupUnlock(soulData, cfgGroupData.Id) then
		return false
	end

	if cfgGroupData.UnlockLv > soulData.lv then
		return false
	end

	if SkillModule.CheckPreSkillGroupUnlock(soulData, cfgGroupData.Id) == false then
		return false
	end

	for i, v in ipairs(cfgGroupData.GroupUnlockCost) do
		if i % 2 ~= 0 then
			local id = v
			local count = cfgGroupData.GroupUnlockCost[i + 1]
			local ownCount = WarehouseModule.GetItemNumByCfgID(id)

			if ownCount < count then
				return false
			end
		end
	end

	return true
end

function SkillModule.CheckPreSkillGroupUnlock(soulData, skillGroupCid)
	local cfgSoulData = soulData:GetCfgSoul()

	for i, v in ipairs(cfgSoulData.DefaultSkill) do
		if v == skillGroupCid then
			if i > 1 then
				return SkillModule.CheckSkillGroupUnlock(soulData, cfgSoulData.DefaultSkill[i - 1])
			else
				return true
			end
		end
	end

	return true
end

function SkillModule.GetValidSkillDesc(cfgSkillData, originalDesc, specificSoulData)
	if specificSoulData ~= nil then
		local curSpSkillStrengthenDesc = SkillModule.GetSoulCurSpSkillStrengthenDesc(specificSoulData, cfgSkillData)

		if curSpSkillStrengthenDesc == nil then
			return originalDesc
		end

		return curSpSkillStrengthenDesc
	end

	local allSoulDatum = SoulModule.GetSortedSoulDataList()

	for i, soulData in pairs(allSoulDatum) do
		local curSpSkillStrengthenDesc = SkillModule.GetSoulCurSpSkillStrengthenDesc(soulData, cfgSkillData)

		if curSpSkillStrengthenDesc ~= nil then
			return curSpSkillStrengthenDesc
		end
	end

	return originalDesc
end

function SkillModule.GetSoulCurSpSkillStrengthenDesc(soulData, cfgSkillData)
	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		local cfgSoulSpecialSpiritData = soulData.CfgSoulSpecialSpirits[i]

		if cfgSoulSpecialSpiritData ~= nil and cfgSoulSpecialSpiritData.Skill == cfgSkillData.Id and #cfgSoulSpecialSpiritData.ADDSkillStrengthen > 0 then
			local strengthenNum = #cfgSoulSpecialSpiritData.ADDSkillStrengthen
			local maxStrengthenCid = cfgSoulSpecialSpiritData.ADDSkillStrengthen[strengthenNum]
			local cfgStrengthData = CfgSkillStrengthenTable[maxStrengthenCid]

			return cfgStrengthData.Describe
		end
	end

	return nil
end

function SkillModule.FilterSkillsByShowType(skills, showType, exclusively)
	return SkillModule.__InnerFilterSkills(skills, showType, exclusively, #skills, 1)
end

function SkillModule.FilterSkillsByShowTypeForList(skills, showType, exclusively)
	return SkillModule.__InnerFilterSkills(skills, showType, exclusively, skills.Count, 0)
end

function SkillModule.FilterSkillsByShowTypeForArray(skills, showType, exclusively)
	return SkillModule.__InnerFilterSkills(skills, showType, exclusively, skills.Length, 0)
end

function SkillModule.__InnerFilterSkills(skills, showType, exclusively, length, indexDelta)
	local result = {}

	for i = 0 + indexDelta, length - 1 + indexDelta do
		local skillCid = skills[i]
		local cfgSkillData = CfgSkillTable[skillCid]

		if exclusively and cfgSkillData.ShowType ~= showType or not exclusively and cfgSkillData.ShowType == showType then
			table.insert(result, skillCid)
		end
	end

	return result
end

function SkillModule.UnlockSkillGroup(soulCid, groupCid)
	SkillModule.lastUnlockSkillGroupSoulCid = soulCid
	SkillModule.lastUnlockSkillGroupCid = groupCid

	net_soul.unlockSkillGroup(soulCid, groupCid)
end

function SkillModule.UnlockSkillGroupResult()
	EventDispatcher.Dispatch(EventID.SoulSkillGroupUnlockSuccess, SkillModule.lastUnlockSkillGroupSoulCid, SkillModule.lastUnlockSkillGroupCid)
end
