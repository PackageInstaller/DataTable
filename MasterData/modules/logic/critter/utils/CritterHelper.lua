-- chunkname: @modules/logic/critter/utils/CritterHelper.lua

module("modules.logic.critter.utils.CritterHelper", package.seeall)

local CritterHelper = {}

function CritterHelper.getInitClassMOList(infoList, classMO, oldMOList)
	local moList = {}

	if infoList then
		for i, info in ipairs(infoList) do
			local tempMO

			if oldMOList then
				tempMO = oldMOList[i]
			end

			tempMO = tempMO or classMO.New()

			tempMO:init(info)
			table.insert(moList, tempMO)
		end
	end

	return moList
end

function CritterHelper.sortByCritterId(aCritterMO, bCritterMO)
	local aCritterId = aCritterMO:getDefineId()
	local bCritterId = bCritterMO:getDefineId()

	if aCritterId ~= bCritterId then
		return aCritterId < bCritterId
	end

	local aCritterUid = aCritterMO:getId()
	local bCritterUid = bCritterMO:getId()

	return aCritterUid < bCritterUid
end

function CritterHelper.sortByRareDescend(aCritterMO, bCritterMO)
	local aCfg = aCritterMO:getDefineCfg()
	local bCfg = bCritterMO:getDefineCfg()
	local aRare = aCfg.rare
	local bRare = bCfg.rare

	if aRare ~= bRare then
		return bRare < aRare
	end

	return CritterHelper.sortByCritterId(aCritterMO, bCritterMO)
end

function CritterHelper.sortByRareAscend(aCritterMO, bCritterMO)
	local aCfg = aCritterMO:getDefineCfg()
	local bCfg = bCritterMO:getDefineCfg()
	local aRare = aCfg.rare
	local bRare = bCfg.rare

	if aRare ~= bRare then
		return aRare < bRare
	end

	return CritterHelper.sortByCritterId(aCritterMO, bCritterMO)
end

function CritterHelper.getCritterAttrSortFunc(attrId, isHightToLow)
	if not CritterHelper._descendFuncMap then
		CritterHelper._descendFuncMap = {
			[CritterEnum.AttributeType.Efficiency] = CritterHelper.sortByEfficiencyDescend,
			[CritterEnum.AttributeType.Patience] = CritterHelper.sortByPatienceDescend,
			[CritterEnum.AttributeType.Lucky] = CritterHelper.sortByLuckyDescend
		}
		CritterHelper._ascendSortFuncMap = {
			[CritterEnum.AttributeType.Efficiency] = CritterHelper.sortByEfficiencyAscend,
			[CritterEnum.AttributeType.Patience] = CritterHelper.sortByPatienceAscend,
			[CritterEnum.AttributeType.Lucky] = CritterHelper.sortByLuckyAscend
		}
	end

	if isHightToLow then
		if not CritterHelper._ascendSortFuncMap then
			local sortFuncMap = CritterHelper._descendFuncMap

			return sortFuncMap[attrId]
		end
	end
end

function CritterHelper.sortByTotalAttrValue(aCritterMO, bCritterMO)
	local aTotalAttr = aCritterMO:getTotalAttrValue()
	local bTotalAttr = bCritterMO:getTotalAttrValue()

	if aTotalAttr ~= bTotalAttr then
		return bTotalAttr < aTotalAttr
	end

	return CritterHelper.sortByRareDescend(aCritterMO, bCritterMO)
end

function CritterHelper.sortByEfficiencyDescend(aCritterMO, bCritterMO)
	local aEffIncrRate = aCritterMO.efficiencyIncrRate
	local bEffIncrRate = bCritterMO.efficiencyIncrRate

	if aEffIncrRate ~= bEffIncrRate then
		return bEffIncrRate < aEffIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Efficiency)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Efficiency)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.efficiency ~= bCritterMO.efficiency then
		return aCritterMO.efficiency > bCritterMO.efficiency
	end

	return CritterHelper.sortByTotalAttrValue(aCritterMO, bCritterMO)
end

function CritterHelper.sortByEfficiencyAscend(aCritterMO, bCritterMO)
	local aEffIncrRate = aCritterMO.efficiencyIncrRate
	local bEffIncrRate = bCritterMO.efficiencyIncrRate

	if aEffIncrRate ~= bEffIncrRate then
		return aEffIncrRate < bEffIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Efficiency)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Efficiency)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.efficiency ~= bCritterMO.efficiency then
		return aCritterMO.efficiency < bCritterMO.efficiency
	end

	return CritterHelper.sortByTotalAttrValue(aCritterMO, bCritterMO)
end

function CritterHelper.sortByPatienceDescend(aCritterMO, bCritterMO)
	local aPatIncrRate = aCritterMO.patienceIncrRate
	local bPatIncrRate = bCritterMO.patienceIncrRate

	if aPatIncrRate ~= bPatIncrRate then
		return bPatIncrRate < aPatIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Patience)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Patience)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.patience ~= bCritterMO.patience then
		return aCritterMO.patience > bCritterMO.patience
	end

	return CritterHelper.sortByTotalAttrValue(aCritterMO, bCritterMO)
end

function CritterHelper.sortByPatienceAscend(aCritterMO, bCritterMO)
	local aPatIncrRate = aCritterMO.patienceIncrRate
	local bPatIncrRate = bCritterMO.patienceIncrRate

	if aPatIncrRate ~= bPatIncrRate then
		return aPatIncrRate < bPatIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Patience)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Patience)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.patience ~= bCritterMO.patience then
		return aCritterMO.patience < bCritterMO.patience
	end

	return CritterHelper.sortByTotalAttrValue(aCritterMO, bCritterMO)
end

function CritterHelper.sortByLuckyDescend(aCritterMO, bCritterMO)
	local aLuckyIncrRate = aCritterMO.luckyIncrRate
	local bLuckyIncrRate = bCritterMO.luckyIncrRate

	if aLuckyIncrRate ~= bLuckyIncrRate then
		return bLuckyIncrRate < aLuckyIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Lucky)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Lucky)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.lucky ~= bCritterMO.lucky then
		return aCritterMO.lucky > bCritterMO.lucky
	end

	return CritterHelper.sortByRareDescend(aCritterMO, bCritterMO)
end

function CritterHelper.sortByLuckyAscend(aCritterMO, bCritterMO)
	local aLuckyIncrRate = aCritterMO.luckyIncrRate
	local bLuckyIncrRate = bCritterMO.luckyIncrRate

	if aLuckyIncrRate ~= bLuckyIncrRate then
		return aLuckyIncrRate < bLuckyIncrRate
	end

	local aHasAddRate = aCritterMO:isAddition(CritterEnum.AttributeType.Lucky)
	local bHasAddRate = bCritterMO:isAddition(CritterEnum.AttributeType.Lucky)

	if aHasAddRate ~= bHasAddRate then
		return aHasAddRate
	end

	if aCritterMO.lucky ~= bCritterMO.lucky then
		return aCritterMO.lucky < bCritterMO.lucky
	end

	return CritterHelper.sortByRareDescend(aCritterMO, bCritterMO)
end

function CritterHelper.sortEvent(aCritterMO, bCritterMO)
	local aIdx = CritterHelper._getEventSortIndex(aCritterMO)
	local bIdx = CritterHelper._getEventSortIndex(bCritterMO)

	if aIdx ~= bIdx then
		return aIdx < bIdx
	end
end

function CritterHelper._getEventSortIndex(critterMO)
	if critterMO:isNoMood() then
		return 1
	elseif critterMO:isCultivating() then
		if critterMO.trainInfo:isHasEventTrigger() then
			return 2
		elseif critterMO.trainInfo:isTrainFinish() then
			return 3
		end
	end

	return 100
end

function CritterHelper.getEventTypeByCritterMO(critterMO)
	if not critterMO then
		return nil
	end

	if critterMO:isCultivating() then
		if critterMO.trainInfo:isHasEventTrigger() then
			return CritterEnum.CritterItemEventType.HasTrainEvent
		elseif critterMO.trainInfo:isTrainFinish() then
			return CritterEnum.CritterItemEventType.TrainEventComplete
		end
	elseif critterMO:isNoMoodWorking() then
		return CritterEnum.CritterItemEventType.NoMoodWork
	end

	return nil
end

function CritterHelper.getWorkCritterMOListByBuid(buildingUid)
	local critterMOList = {}
	local allMOList = CritterModel.instance:getAllCritters()

	for _, critterMO in ipairs(allMOList) do
		if critterMO:isMaturity() and critterMO.workInfo and critterMO.workInfo.workBuildingUid == buildingUid then
			table.insert(critterMOList, critterMO)
		end
	end

	return critterMOList
end

CritterHelper._sumTempAttrInfoParam = {}

function CritterHelper.sumArrtInfoMOByAttrId(attrId, critterMOList, buildingId, isPreview)
	local attrInfo = CritterHelper._sumTempAttrInfoParam

	attrInfo.attributeId = attrId
	attrInfo.value = 0
	attrInfo.rate = 0
	attrInfo.addRate = 0

	if critterMOList and #critterMOList > 0 then
		for _, critterMO in ipairs(critterMOList) do
			local tempInfo = critterMO:getAttributeInfoByType(attrId, buildingId, isPreview)

			if tempInfo then
				attrInfo.value = attrInfo.value + tempInfo.value
				attrInfo.rate = attrInfo.rate + tempInfo.rate
				attrInfo.addRate = attrInfo.addRate + tempInfo:getAdditionRate()
			end
		end
	end

	local infoMO = CritterAttributeInfoMO.New()

	infoMO:init(attrInfo)

	return infoMO
end

function CritterHelper.getPreViewAttrValue(attrId, critterUid, buildingId, isPreview)
	local preAttrInfo = ManufactureCritterListModel.instance:getPreviewAttrInfo(critterUid, buildingId, isPreview)

	if preAttrInfo then
		if attrId == CritterEnum.AttributeType.Efficiency then
			return preAttrInfo.efficiency or 0
		elseif attrId == CritterEnum.AttributeType.Patience then
			return preAttrInfo.moodCostSpeed or 0
		elseif attrId == CritterEnum.AttributeType.Lucky then
			return preAttrInfo.criRate or 0
		elseif attrId == CritterEnum.AttributeType.MoodRestore then
			return preAttrInfo.moodCostSpeed or 0
		end
	end

	return 0
end

function CritterHelper.sumPreViewAttrValue(attrId, critterUidList)
	local value = 0

	if critterUidList and #critterUidList > 0 then
		for _, critterUid in ipairs(critterUidList) do
			value = value + CritterHelper.getPreViewAttrValue(attrId, critterUid)
		end
	end

	return value
end

function CritterHelper.formatAttrValue(attrId, value)
	if attrId == CritterEnum.AttributeType.MoodRestore then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), value)
	elseif attrId == CritterEnum.AttributeType.Patience then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), value)
	elseif attrId == CritterEnum.AttributeType.Lucky then
		return string.format("%s%%", value)
	end

	return value
end

function CritterHelper.buildFakeCritterMoByConfig(config)
	local critterMo = CritterMO.New()
	local efficiency = 0
	local patience = 0
	local lucky = 0
	local efficiencyIncrRate = 0
	local patienceIncrRate = 0
	local luckyIncrRate = 0
	local skillInfo = {}

	if config then
		if not string.nilorempty(config.baseAttribute) then
			local values = GameUtil.splitString2(config.baseAttribute, true)

			efficiency = values[1][2] or 0
			patience = values[2][2] or 0
			lucky = values[3][2] or 0
		end

		if not string.nilorempty(config.baseAttribute) then
			local rates = GameUtil.splitString2(config.attributeIncrRate, true)

			efficiencyIncrRate = rates[1][2] or 0
			patienceIncrRate = rates[2][2] or 0
			luckyIncrRate = rates[3][2] or 0
		end

		skillInfo = {
			tags = {
				config.raceTag
			}
		}
	end

	local info = {
		uid = "0",
		id = "0",
		specialSkin = false,
		defineId = config.id,
		efficiency = efficiency,
		patience = patience,
		lucky = lucky,
		efficiencyIncrRate = efficiencyIncrRate,
		patienceIncrRate = patienceIncrRate,
		luckyIncrRate = luckyIncrRate,
		tagAttributeRates = {},
		skillInfo = skillInfo
	}

	critterMo:init(info)

	return critterMo
end

function CritterHelper.getPatienceChangeValue(buildingType)
	local cfg = CritterConfig.instance:getPatienceChangeCfg(buildingType)

	if cfg then
		return cfg.stepTime * cfg.stepValue / 3600
	end

	return 0
end

return CritterHelper
