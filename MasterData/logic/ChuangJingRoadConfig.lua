-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/config/ChuangJingRoadConfig.lua

module("logic.extensions.chuangjingroad.config.ChuangJingRoadConfig", package.seeall)

local ChuangJingRoadConfig = class("ChuangJingRoadConfig", BaseConfig)

function ChuangJingRoadConfig:getNames()
	return {
		"chuang_jing_road_stage",
		"chuang_jing_road_stage_ext",
		"chuang_jing_road_activity",
		"chuang_jing_road_equipment_level",
		"chuang_jing_road_grass_boss",
		"chuang_jing_road_rank_prize",
		"chuang_jing_road_pet_level",
		"chuang_jing_road_awaken_cost",
		"chuang_jing_road_light_boss",
		"chuang_jing_road_fire_boss",
		"chuang_jing_road_progress_prize",
		"chuang_jing_road_zone_debuff",
		"chuang_jing_road_master",
		"chuang_jing_road_equipment_cost",
		"chuang_jing_road_zone",
		"chuang_jing_road_holy_stripe",
		"chuang_jing_road_creeps",
		"chuang_jing_road_stargod_level",
		"chuang_jing_road_support",
		"chuang_jing_road_water_boss",
		"chuang_jing_road_boss_prize"
	}
end

function ChuangJingRoadConfig:handleConfig(name, content)
	if name == "chuang_jing_road_stage" then
		self._chuang_jing_road_stage = content
	elseif name == "chuang_jing_road_stage_ext" then
		self._chuang_jing_road_stage_ext = content
	elseif name == "chuang_jing_road_activity" then
		self._chuang_jing_road_activity = content
	elseif name == "chuang_jing_road_equipment_level" then
		self._chuang_jing_road_equipment_level = content
	elseif name == "chuang_jing_road_grass_boss" then
		self._chuang_jing_road_grass_boss = content
	elseif name == "chuang_jing_road_rank_prize" then
		self._chuang_jing_road_rank_prize = content
	elseif name == "chuang_jing_road_pet_level" then
		self._chuang_jing_road_pet_level = content
	elseif name == "chuang_jing_road_awaken_cost" then
		self._chuang_jing_road_awaken_cost = content
	elseif name == "chuang_jing_road_light_boss" then
		self._chuang_jing_road_light_boss = content
	elseif name == "chuang_jing_road_fire_boss" then
		self._chuang_jing_road_fire_boss = content
	elseif name == "chuang_jing_road_progress_prize" then
		self._chuang_jing_road_progress_prize = content
	elseif name == "chuang_jing_road_zone_debuff" then
		self._chuang_jing_road_zone_debuff = content
	elseif name == "chuang_jing_road_master" then
		self._chuang_jing_road_master = content
	elseif name == "chuang_jing_road_equipment_cost" then
		self._chuang_jing_road_equipment_cost = content
	elseif name == "chuang_jing_road_zone" then
		self._chuang_jing_road_zone = content
	elseif name == "chuang_jing_road_holy_stripe" then
		self._chuang_jing_road_holy_stripe = content
	elseif name == "chuang_jing_road_creeps" then
		self._chuang_jing_road_creeps = content
	elseif name == "chuang_jing_road_stargod_level" then
		self._chuang_jing_road_stargod_level = content
	elseif name == "chuang_jing_road_support" then
		self._chuang_jing_road_support = content
	elseif name == "chuang_jing_road_water_boss" then
		self._chuang_jing_road_water_boss = content
	elseif name == "chuang_jing_road_boss_prize" then
		self._chuang_jing_road_boss_prize = content
	end
end

function ChuangJingRoadConfig:getActivityCfgById(activityId)
	return self._chuang_jing_road_activity[activityId]
end

function ChuangJingRoadConfig:getBossPrizeListById(activityId)
	return self._chuang_jing_road_boss_prize[activityId]
end

function ChuangJingRoadConfig:getSupportListById(activityId)
	return self._chuang_jing_road_support[activityId]
end

function ChuangJingRoadConfig:getDebuffListById(activityId)
	return self._chuang_jing_road_zone_debuff[activityId]
end

function ChuangJingRoadConfig:getEquipCostById(activityId, lvl)
	if self._chuang_jing_road_equipment_cost[activityId] then
		return self._chuang_jing_road_equipment_cost[activityId][lvl]
	end
end

function ChuangJingRoadConfig:getEquipCfg(activityId, job, posId, lvl)
	local cfg = self._chuang_jing_road_equipment_level

	if cfg[activityId] and cfg[activityId][job] and cfg[activityId][job][posId] then
		return cfg[activityId][job][posId][lvl]
	end
end

function ChuangJingRoadConfig:getLevelCostById(activityId, lvl)
	if self._chuang_jing_road_pet_level[activityId] then
		return self._chuang_jing_road_pet_level[activityId][lvl]
	end
end

function ChuangJingRoadConfig:getHolyStripeCostById(activityId, lvl)
	if self._chuang_jing_road_holy_stripe[activityId] and self._chuang_jing_road_holy_stripe[activityId][1] then
		return self._chuang_jing_road_holy_stripe[activityId][1][lvl]
	end
end

function ChuangJingRoadConfig:getHolyStripeListById(activityId)
	return self._chuang_jing_road_holy_stripe[activityId]
end

function ChuangJingRoadConfig:getStarGodCostById(activityId, lvl)
	if self._chuang_jing_road_stargod_level[activityId] then
		return self._chuang_jing_road_stargod_level[activityId][lvl]
	end
end

function ChuangJingRoadConfig:getAwakenCostById(activityId, lvl)
	if self._chuang_jing_road_awaken_cost[activityId] then
		return self._chuang_jing_road_awaken_cost[activityId][lvl]
	end
end

function ChuangJingRoadConfig:getZoneCfgById(activityId, zoneId)
	if self._chuang_jing_road_zone[activityId] then
		return self._chuang_jing_road_zone[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getZoneListById(activityId)
	return self._chuang_jing_road_zone[activityId]
end

function ChuangJingRoadConfig:getStageConfigById(activityId, zoneId, stageId)
	if self._chuang_jing_road_stage[activityId] and self._chuang_jing_road_stage[activityId][zoneId] then
		return self._chuang_jing_road_stage[activityId][zoneId][stageId]
	end
end

function ChuangJingRoadConfig:getStageListById(activityId, zoneId)
	if self._chuang_jing_road_stage[activityId] then
		return self._chuang_jing_road_stage[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getExtStageById(activityId, zoneId)
	if self._chuang_jing_road_stage_ext[activityId] then
		return self._chuang_jing_road_stage_ext[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getChallengePorgressById(activityId, zoneId)
	if self._chuang_jing_road_progress_prize[activityId] then
		return self._chuang_jing_road_progress_prize[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getLightBossCfgById(activityId, zoneId)
	if self._chuang_jing_road_light_boss[activityId] then
		return self._chuang_jing_road_light_boss[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getWaterBossCfgById(activityId, zoneId)
	if self._chuang_jing_road_water_boss[activityId] then
		return self._chuang_jing_road_water_boss[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getFireBossCfgById(activityId, zoneId)
	if self._chuang_jing_road_fire_boss[activityId] then
		return self._chuang_jing_road_fire_boss[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getGrassBossListCfgById(activityId, zoneId)
	if self._chuang_jing_road_grass_boss[activityId] then
		return self._chuang_jing_road_grass_boss[activityId][zoneId]
	end
end

function ChuangJingRoadConfig:getGrassBossCfgById(activityId, zoneId, stageId)
	if self._chuang_jing_road_grass_boss[activityId] and self._chuang_jing_road_grass_boss[activityId][zoneId] then
		return self._chuang_jing_road_grass_boss[activityId][zoneId][stageId]
	end
end

function ChuangJingRoadConfig:getRankCfg(activityId, zoneId, rank)
	local result

	if self._chuang_jing_road_rank_prize[activityId] then
		local tem = self._chuang_jing_road_rank_prize[activityId][zoneId]

		if tem then
			local list = {}

			for k, v in pairs(tem) do
				table.insert(list, v)
			end

			for i = #list, 1, -1 do
				local cfg = list[i]

				if cfg.rankRange and #cfg.rankRange > 0 and rank >= cfg.rankRange[1] and rank <= cfg.rankRange[2] then
					result = cfg

					break
				end
			end
		end
	end

	return result
end

function ChuangJingRoadConfig:getMonsterCfgById(creepsMasterId)
	return self._chuang_jing_road_master[creepsMasterId]
end

function ChuangJingRoadConfig:getCreepsCfgById(creepsMasterId)
	return self._chuang_jing_road_creeps[creepsMasterId]
end

ChuangJingRoadConfig.instance = ChuangJingRoadConfig.New()

return ChuangJingRoadConfig
