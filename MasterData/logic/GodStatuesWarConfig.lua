-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/config/GodStatuesWarConfig.lua

module("logic.extensions.divinexiuerclg.config.GodStatuesWarConfig", package.seeall)

local GodStatuesWarConfig = class("GodStatuesWarConfig", BaseConfig)

function GodStatuesWarConfig:onInit()
	GodStatuesWarConfig.super.onInit(self)
end

function GodStatuesWarConfig:getNames()
	return {
		"new_family_battle_season",
		"new_family_battle_client_common",
		"new_family_battle_step",
		"new_family_battle_nest",
		"new_family_battle_damage_prize",
		"new_family_battle_master",
		"new_family_battle_creeps",
		"new_family_battle_params",
		"new_family_battle_divine_pillar",
		"new_family_battle_pillar_entry",
		"new_family_battle_rank_prize",
		"new_family_battle_rules",
		"new_family_battle_zone"
	}
end

function GodStatuesWarConfig:handleConfig(name, content)
	if name == "new_family_battle_season" then
		self._nfbSeasonCfg = content
	elseif name == "new_family_battle_client_common" then
		self._nfbClientCommonCfg = content
	elseif name == "new_family_battle_step" then
		self._nfbStepCfgs = content
	elseif name == "new_family_battle_nest" then
		self._nfbNestCfgs = content
	elseif name == "new_family_battle_damage_prize" then
		self._nfbDamagePrizeCfgs = content
	elseif name == "new_family_battle_master" then
		self._nfbMasterCfg = content
	elseif name == "new_family_battle_creeps" then
		self._nfbCreepsCfgs = content
	elseif name == "new_family_battle_params" then
		self._nfbParamsCfg = content
	elseif name == "new_family_battle_divine_pillar" then
		self._nfbDivinePillarCfgs = content
	elseif name == "new_family_battle_pillar_entry" then
		self._nfbPillarEntryCfgs = content
	elseif name == "new_family_battle_rank_prize" then
		self._nfbRankPrizeCfgs = content
	elseif name == "new_family_battle_rules" then
		self._nfbRulesCfg = content
	elseif name == "new_family_battle_zone" then
		self._nfbZoneCfgs = content
	end
end

function GodStatuesWarConfig:getNfbSeasonDataList()
	return self._nfbSeasonCfg.dataList
end

function GodStatuesWarConfig:getNfbSeasonData(seasonId)
	return self._nfbSeasonCfg[seasonId]
end

function GodStatuesWarConfig:getNfbCommonValue(seasonId, key, isToNumber)
	local seasonData = self:getNfbSeasonData(seasonId)

	if seasonData then
		if not seasonData.comPlanId then
			local comPlanId = 0
			local data = self._nfbClientCommonCfg[comPlanId]

			if data then
				if isToNumber then
					return checknumber(data[key])
				else
					return data[key]
				end
			end
		end
	end
end

function GodStatuesWarConfig:getNfbClientCommonValue(seasonId, key)
	local seasonData = self:getNfbSeasonData(seasonId)

	if seasonData then
		local data = self._nfbClientCommonCfg[seasonData.comPlanId]

		if data then
			return data[key]
		end
	end
end

function GodStatuesWarConfig:getNfbStepCfg(seasonId)
	return self._nfbStepCfgs[seasonId]
end

function GodStatuesWarConfig:getNfbStepData(seasonId, step)
	if self._nfbStepCfgs[seasonId] then
		return self._nfbStepCfgs[seasonId][step]
	end
end

function GodStatuesWarConfig:getNfbNestCfg(nestPlanId)
	return self._nfbNestCfgs[nestPlanId]
end

function GodStatuesWarConfig:getNfbNestData(nestPlanId, nestId)
	if self._nfbNestCfgs[nestPlanId] then
		return self._nfbNestCfgs[nestPlanId][nestId]
	end
end

function GodStatuesWarConfig:getNfbDamagePrizeCfg(damageScorePlan)
	return self._nfbDamagePrizeCfgs[damageScorePlan]
end

function GodStatuesWarConfig:getNfbDamagePrizeData(damageScorePlan, prizeId)
	if self._nfbDamagePrizeCfgs[damageScorePlan] then
		return self._nfbDamagePrizeCfgs[damageScorePlan][prizeId]
	end
end

function GodStatuesWarConfig:getNfbDamagePrizeDataByDamage(damageScorePlan, damage)
	local result
	local cfg = self:getNfbDamagePrizeCfg(damageScorePlan)

	if cfg then
		for _, data in ipairs(cfg) do
			if damage < data.damage then
				break
			else
				result = data
			end
		end
	end

	return result
end

function GodStatuesWarConfig:getNfbMasterData(creepsMasterId)
	return self._nfbMasterCfg[creepsMasterId]
end

function GodStatuesWarConfig:getNfbCreepsCfg(creepsMasterId)
	return self._nfbCreepsCfgs[creepsMasterId]
end

function GodStatuesWarConfig:getNfbCreepsData(creepsMasterId, creepsId)
	if self._nfbCreepsCfgs[creepsMasterId] then
		return self._nfbCreepsCfgs[creepsMasterId][creepsId]
	end
end

function GodStatuesWarConfig:getNfbParamsValue(key, isToNumber)
	local data = self._nfbParamsCfg[key]
	local value = data and data.value

	if isToNumber then
		return checknumber(value)
	else
		return value
	end
end

function GodStatuesWarConfig:getNfbDivinePillarCfg(divinePillarPlanId)
	return self._nfbDivinePillarCfgs[divinePillarPlanId]
end

function GodStatuesWarConfig:getNfbDivinePillarData(divinePillarPlanId, divinePillarTier)
	if self._nfbDivinePillarCfgs[divinePillarPlanId] then
		return self._nfbDivinePillarCfgs[divinePillarPlanId][divinePillarTier]
	end
end

function GodStatuesWarConfig:getNfbPillarEntryCfg(seasonId)
	local data = self:getNfbSeasonData(seasonId)

	if data then
		return self._nfbPillarEntryCfgs[data.pillarPlanId]
	end
end

function GodStatuesWarConfig:getNfbPillarInfoData(seasonId, pillarId)
	local cfg = self:getNfbPillarEntryCfg(seasonId)

	if cfg then
		return cfg[pillarId]
	end
end

function GodStatuesWarConfig:getNfbRankPrizeCfg(rankPrizePlanId)
	return self._nfbRankPrizeCfgs[rankPrizePlanId]
end

function GodStatuesWarConfig:getNfbRankPrizeData(rankPrizePlanId, rankPrizeId)
	if self._nfbRankPrizeCfgs[rankPrizePlanId] then
		return self._nfbRankPrizeCfgs[rankPrizePlanId][rankPrizeId]
	end
end

function GodStatuesWarConfig:getNfbRulesCfg(seasonId)
	local data = self:getNfbSeasonData(seasonId)

	if data then
		return self._nfbRulesCfg[data.rulePlanId]
	end
end

function GodStatuesWarConfig:getNfbRulesData(seasonId, rulesId)
	local cfg = self:getNfbRulesCfg(seasonId)

	if cfg then
		return cfg[rulesId]
	end
end

function GodStatuesWarConfig:getNfbZoneCfg(seasonId)
	return self._nfbZoneCfgs[seasonId]
end

function GodStatuesWarConfig:getNfbZoneData(seasonId, zoneId)
	if self._nfbZoneCfgs[seasonId] then
		return self._nfbZoneCfgs[seasonId][zoneId]
	end
end

function GodStatuesWarConfig:getNfbZoneDataByAreaId(seasonId, areaId)
	areaId = checknumber(areaId)

	local targetData
	local cfg = self:getNfbZoneCfg(seasonId)

	for i = 0, #cfg do
		local data = cfg[i]

		if data and areaId >= data.areaIds[1] and areaId <= data.areaIds[2] then
			targetData = data

			break
		end
	end

	return targetData
end

GodStatuesWarConfig.instance = GodStatuesWarConfig.New()

return GodStatuesWarConfig
