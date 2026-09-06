-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/config/FamilyHoudingClgConfig.lua

module("logic.extensions.familyhoundingclg.config.FamilyHoudingClgConfig", package.seeall)

local FamilyHoudingClgConfig = class("FamilyHoudingClgConfig", BaseConfig)

function FamilyHoudingClgConfig:onInit()
	FamilyHoudingClgConfig.super.onInit(self)
end

function FamilyHoudingClgConfig:getNames()
	return {
		"family_hounding_plan_time",
		"family_hounding_common",
		"family_hounding_buff",
		"family_hounding_boss",
		"family_hounding_damage_prize",
		"family_hounding_master",
		"family_hounding_creeps",
		"family_hounding_family_rank_prize",
		"family_hounding_person_rank_prize"
	}
end

function FamilyHoudingClgConfig:handleConfig(name, content)
	if name == "family_hounding_plan_time" then
		self._fhPlanTimeCfg = content
	elseif name == "family_hounding_common" then
		self._fhCommonCfg = content
	elseif name == "family_hounding_buff" then
		self._fhBuffCfg = content
	elseif name == "family_hounding_boss" then
		self._fhBossCfgs = content
	elseif name == "family_hounding_damage_prize" then
		self._fhDamagePrizeCfgs = content
	elseif name == "family_hounding_master" then
		self._fhMasterCfg = content
	elseif name == "family_hounding_creeps" then
		self._fhCreepsCfgs = content
	elseif name == "family_hounding_family_rank_prize" then
		self._fhFamilyRankPrizeCfgs = content
	elseif name == "family_hounding_person_rank_prize" then
		self._fhPersonRankPrizeCfgs = content
	end
end

function FamilyHoudingClgConfig:getFhPlanTimeDataList()
	return self._fhPlanTimeCfg.dataList
end

function FamilyHoudingClgConfig:getFhPlanTimeData(fhId)
	return self._fhPlanTimeCfg[fhId]
end

function FamilyHoudingClgConfig:getFhCommonData(fhId)
	local planTimeData = self:getFhPlanTimeData(fhId)

	if planTimeData then
		return self._fhCommonCfg[planTimeData.comPlanId]
	end
end

function FamilyHoudingClgConfig:getFhCommonValue(fhId, key)
	local data = self:getFhCommonData(fhId)

	if data then
		return data[key]
	end
end

function FamilyHoudingClgConfig:getFhBuffData(buffId)
	return self._fhBuffCfg[buffId]
end

function FamilyHoudingClgConfig:getFhBossCfg(fhId)
	local planTimeData = self:getFhPlanTimeData(fhId)

	if planTimeData then
		return self._fhBossCfgs[planTimeData.bossPlanId]
	end
end

function FamilyHoudingClgConfig:getFhBossData(fhId, dayIndex)
	local bossCfg = self:getFhBossCfg(fhId)

	if bossCfg then
		return bossCfg[dayIndex]
	end
end

function FamilyHoudingClgConfig:getFhDamagePrizeCfg(damagePrizePlanId)
	return self._fhDamagePrizeCfgs[damagePrizePlanId]
end

function FamilyHoudingClgConfig:getFhDamagePrizeData(damagePrizePlanId, prizeGearId)
	if self._fhDamagePrizeCfgs[damagePrizePlanId] then
		return self._fhDamagePrizeCfgs[damagePrizePlanId][prizeGearId]
	end
end

function FamilyHoudingClgConfig:getFhDamagePrizeDataByDamage(damagePrizePlanId, damage)
	local result
	local cfg = self:getFhDamagePrizeCfg(damagePrizePlanId)

	if cfg then
		for _, v in ipairs(cfg) do
			if damage >= v.damageRange[1] and damage < v.damageRange[2] then
				result = v

				break
			end
		end
	end

	return result
end

function FamilyHoudingClgConfig:getFhCreepsMasterData(creepsMasterId)
	return self._fhMasterCfg[creepsMasterId]
end

function FamilyHoudingClgConfig:getFhCreepsCfg(creepsMasterId)
	return self._fhCreepsCfgs[creepsMasterId]
end

function FamilyHoudingClgConfig:getFhCreepsData(creepsMasterId, creepsId)
	if self._fhCreepsCfgs[creepsMasterId] then
		return self._fhCreepsCfgs[creepsMasterId][creepsId]
	end
end

function FamilyHoudingClgConfig:getFhFamilyRankPrizeCfg(fhId)
	local planTimeData = self:getFhPlanTimeData(fhId)

	if planTimeData then
		return self._fhFamilyRankPrizeCfgs[planTimeData.rankPrizePlanId]
	end
end

function FamilyHoudingClgConfig:getFhFamilyRankPrizeData(fhId, id)
	local cfg = self:getFhFamilyRankPrizeCfg(fhId)

	if cfg then
		return cfg[id]
	end
end

function FamilyHoudingClgConfig:getFhPersonRankPrizeCfg(fhId)
	local planTimeData = self:getFhPlanTimeData(fhId)

	if planTimeData then
		return self._fhPersonRankPrizeCfgs[planTimeData.rankPrizePlanId]
	end
end

function FamilyHoudingClgConfig:getFhPersonRankPrizeData(fhId, id)
	local cfg = self:getFhPersonRankPrizeCfg(fhId)

	if cfg then
		return cfg[id]
	end
end

FamilyHoudingClgConfig.instance = FamilyHoudingClgConfig.New()

return FamilyHoudingClgConfig
