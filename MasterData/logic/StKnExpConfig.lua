-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/config/StKnExpConfig.lua

module("logic.extensions.stknexp.config.StKnExpConfig", package.seeall)

local StKnExpConfig = class("StKnExpConfig", BaseConfig)

function StKnExpConfig:getNames()
	return {
		"saint_knight_expedition_activity",
		"saint_knight_expedition_zone",
		"saint_knight_expedition_stage",
		"saint_knight_expedition_boss_prize",
		"saint_knight_expedition_stage_rank_prize",
		"saint_knight_expedition_boss_rank_prize",
		"saint_knight_expedition_pet_level",
		"saint_knight_expedition_equipment_level",
		"saint_knight_expedition_equipment_exp",
		"saint_knight_expedition_stargod_level",
		"saint_knight_expedition_holy_stripe",
		"saint_knight_expedition_cute_pet",
		"saint_knight_expedition_cult_show",
		"saint_knight_expedition_island",
		"saint_knight_expedition_island_level",
		"saint_knight_expedition_island_game",
		"saint_knight_expedition_island_buff",
		"saint_knight_expedition_island_buff_client",
		"saint_knight_expedition_mining",
		"saint_knight_expedition_mining_plan",
		"saint_knight_expedition_mining_floatword",
		"saint_knight_expedition_support",
		"saint_knight_expedition_master",
		"saint_knight_expedition_creeps"
	}
end

function StKnExpConfig:handleConfig(name, content)
	if name == "saint_knight_expedition_activity" then
		self._saint_knight_expedition_activity = content
	elseif name == "saint_knight_expedition_zone" then
		self._saint_knight_expedition_zone = content
	elseif name == "saint_knight_expedition_stage" then
		self._saint_knight_expedition_stage = content
	elseif name == "saint_knight_expedition_boss_prize" then
		self._saint_knight_expedition_boss_prize = content
	elseif name == "saint_knight_expedition_stage_rank_prize" then
		self._saint_knight_expedition_stage_rank_prize = content
	elseif name == "saint_knight_expedition_boss_rank_prize" then
		self._saint_knight_expedition_boss_rank_prize = content
	elseif name == "saint_knight_expedition_pet_level" then
		self._saint_knight_expedition_pet_level = content
	elseif name == "saint_knight_expedition_equipment_level" then
		self._saint_knight_expedition_equipment_level = content
	elseif name == "saint_knight_expedition_equipment_exp" then
		self._saint_knight_expedition_equipment_exp = content
	elseif name == "saint_knight_expedition_stargod_level" then
		self._saint_knight_expedition_stargod_level = content
	elseif name == "saint_knight_expedition_holy_stripe" then
		self._saint_knight_expedition_holy_stripe = content
	elseif name == "saint_knight_expedition_cute_pet" then
		self._saint_knight_expedition_cute_pet = content
	elseif name == "saint_knight_expedition_cult_show" then
		self._saint_knight_expedition_cult_show = content
	elseif name == "saint_knight_expedition_island" then
		self._saint_knight_expedition_island = content
	elseif name == "saint_knight_expedition_island_level" then
		self._saint_knight_expedition_island_level = content
	elseif name == "saint_knight_expedition_island_game" then
		self._saint_knight_expedition_island_game = content
	elseif name == "saint_knight_expedition_island_buff" then
		self._saint_knight_expedition_island_buff = content
	elseif name == "saint_knight_expedition_island_buff_client" then
		self._saint_knight_expedition_island_buff_client = content
	elseif name == "saint_knight_expedition_mining" then
		self._saint_knight_expedition_mining = content
	elseif name == "saint_knight_expedition_mining_plan" then
		self._saint_knight_expedition_mining_plan = content
	elseif name == "saint_knight_expedition_mining_floatword" then
		self._saint_knight_expedition_mining_floatword = content
	elseif name == "saint_knight_expedition_support" then
		self._saint_knight_expedition_support = content
	elseif name == "saint_knight_expedition_master" then
		self._saint_knight_expedition_master = content
	elseif name == "saint_knight_expedition_creeps" then
		self._saint_knight_expedition_creeps = content
	end
end

function StKnExpConfig:getActData(activityId)
	return self._saint_knight_expedition_activity[activityId]
end

function StKnExpConfig:getActDataValue(activityId, field, isToNumber)
	local data = self._saint_knight_expedition_activity[activityId]
	local value = data and data[field]

	value = isToNumber and checknumber(value) or value

	return value
end

function StKnExpConfig:getZoneCfg(activityId)
	return self._saint_knight_expedition_zone[activityId]
end

function StKnExpConfig:getZoneData(activityId, zoneId)
	if self._saint_knight_expedition_zone[activityId] then
		return self._saint_knight_expedition_zone[activityId][zoneId]
	end
end

function StKnExpConfig:getStageCfgs(activityId)
	return self._saint_knight_expedition_stage[activityId]
end

function StKnExpConfig:getStageCfg(activityId, zoneId)
	if self._saint_knight_expedition_stage[activityId] then
		return self._saint_knight_expedition_stage[activityId][zoneId]
	end
end

function StKnExpConfig:getStageData(activityId, zoneId, stageId)
	if self._saint_knight_expedition_stage[activityId] and self._saint_knight_expedition_stage[activityId][zoneId] then
		return self._saint_knight_expedition_stage[activityId][zoneId][stageId]
	end
end

function StKnExpConfig:getMaxStageId(activityId, zoneId)
	local cfg = self:getStageCfg(activityId, zoneId)

	return (cfg or nil) and (#cfg or 0)
end

function StKnExpConfig:getBossPrizeCfg(activityId, zoneId)
	if self._saint_knight_expedition_boss_prize[activityId] then
		return self._saint_knight_expedition_boss_prize[activityId][zoneId]
	end
end

function StKnExpConfig:getBossPrizeData(activityId, zoneId, prizeId)
	if self._saint_knight_expedition_boss_prize[activityId] and self._saint_knight_expedition_boss_prize[activityId][zoneId] then
		return self._saint_knight_expedition_boss_prize[activityId][zoneId][prizeId]
	end
end

function StKnExpConfig:getBossPrizeDataByDamage(activityId, zoneId, damage)
	local cfg = self:getBossPrizeCfg(activityId, zoneId)

	return MmUtil.binarySearchInSingleKey(cfg, "damage", damage)
end

function StKnExpConfig:getMaxPrizeIdInBoss(activityId, zoneId)
	local cfg = self:getBossPrizeCfg(activityId, zoneId)

	return (cfg or nil) and (#cfg or 0)
end

function StKnExpConfig:getStageRankPrizeCfg(activityId)
	return self._saint_knight_expedition_stage_rank_prize[activityId]
end

function StKnExpConfig:getStageRankPrizeData(activityId, rank)
	local cfg = self._saint_knight_expedition_stage_rank_prize[activityId]

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function StKnExpConfig:getBossRankPrizeCfg(activityId)
	return self._saint_knight_expedition_boss_rank_prize[activityId]
end

function StKnExpConfig:getBossRankPrizeData(activityId, rank)
	local cfg = self._saint_knight_expedition_boss_rank_prize[activityId]

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function StKnExpConfig:getPetLevelCfg(activityId)
	return self._saint_knight_expedition_pet_level[activityId]
end

function StKnExpConfig:getPetLevelData(activityId, level)
	if self._saint_knight_expedition_pet_level[activityId] then
		return self._saint_knight_expedition_pet_level[activityId][level]
	end
end

function StKnExpConfig:getPetLevelDataByExp(activityId, exp)
	local cfg = self:getPetLevelCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getEquLevelCfgss(activityId)
	return self._saint_knight_expedition_equipment_level[activityId]
end

function StKnExpConfig:getEquLevelCfgs(activityId, job)
	if self._saint_knight_expedition_equipment_level[activityId] then
		return self._saint_knight_expedition_equipment_level[activityId][job]
	end
end

function StKnExpConfig:getEquLevelCfg(activityId, job, posId)
	if self._saint_knight_expedition_equipment_level[activityId] and self._saint_knight_expedition_equipment_level[activityId][job] then
		return self._saint_knight_expedition_equipment_level[activityId][job][posId]
	end
end

function StKnExpConfig:getEquLevelData(activityId, job, posId, level)
	local cfg = self._saint_knight_expedition_equipment_level

	return cfg[activityId] and cfg[activityId][job] and cfg[activityId][job][posId] and cfg[activityId][job][posId][level]
end

function StKnExpConfig:getEquLevelDataByExp(activityId, job, posId, exp)
	local expData = self:getEquExpDataByExp(activityId, exp)

	if expData then
		if not expData.level then
			local level = 0

			return self:getEquLevelData(activityId, job, posId, level)
		end
	end
end

function StKnExpConfig:getEquExpCfg(activityId)
	return self._saint_knight_expedition_equipment_exp[activityId]
end

function StKnExpConfig:getEquExpData(activityId, level)
	if self._saint_knight_expedition_equipment_exp[activityId] then
		return self._saint_knight_expedition_equipment_exp[activityId][level]
	end
end

function StKnExpConfig:getEquExpDataByExp(activityId, exp)
	local cfg = self:getEquExpCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getStarGodLevelCfg(activityId)
	return self._saint_knight_expedition_stargod_level[activityId]
end

function StKnExpConfig:getStarGodLevelData(activityId, level)
	if self._saint_knight_expedition_stargod_level[activityId] then
		return self._saint_knight_expedition_stargod_level[activityId][level]
	end
end

function StKnExpConfig:getStarGodLevelDataByExp(activityId, exp)
	local cfg = self:getStarGodLevelCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getHolyStripeCfg(activityId)
	return self._saint_knight_expedition_holy_stripe[activityId]
end

function StKnExpConfig:getHolyStripeData(activityId, level)
	if self._saint_knight_expedition_holy_stripe[activityId] then
		return self._saint_knight_expedition_holy_stripe[activityId][level]
	end
end

function StKnExpConfig:getHolyStripeDataByExp(activityId, exp)
	local cfg = self:getHolyStripeCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getCutePetCfg(activityId)
	return self._saint_knight_expedition_cute_pet[activityId]
end

function StKnExpConfig:getCutePetData(activityId, level)
	if self._saint_knight_expedition_cute_pet[activityId] then
		return self._saint_knight_expedition_cute_pet[activityId][level]
	end
end

function StKnExpConfig:getCutePetDataByExp(activityId, exp)
	local cfg = self:getCutePetCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getCultShowCfg(cultType)
	return self._saint_knight_expedition_cult_show[cultType]
end

function StKnExpConfig:getCultShowData(cultType, showLevel)
	if self._saint_knight_expedition_cult_show[cultType] then
		return self._saint_knight_expedition_cult_show[cultType][showLevel]
	end
end

function StKnExpConfig:getIslandCfg(activityId)
	return self._saint_knight_expedition_island[activityId]
end

function StKnExpConfig:getIslandData(activityId, islandId)
	if self._saint_knight_expedition_island[activityId] then
		return self._saint_knight_expedition_island[activityId][islandId]
	end
end

function StKnExpConfig:getIslandLevelCfgs(activityId)
	return self._saint_knight_expedition_island_level[activityId]
end

function StKnExpConfig:getIslandLevelCfg(activityId, islandId)
	if self._saint_knight_expedition_island_level[activityId] then
		return self._saint_knight_expedition_island_level[activityId][islandId]
	end
end

function StKnExpConfig:getIslandLevelData(activityId, islandId, level)
	if self._saint_knight_expedition_island_level[activityId] and self._saint_knight_expedition_island_level[activityId][islandId] then
		return self._saint_knight_expedition_island_level[activityId][islandId][level]
	end
end

function StKnExpConfig:getIslandLevelDataByExp(activityId, islandId, exp)
	local cfg = self:getIslandLevelCfg(activityId, islandId)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getIslandGameCfg(activityId)
	return self._saint_knight_expedition_island_game[activityId]
end

function StKnExpConfig:getIslandGameData(activityId, index)
	if self._saint_knight_expedition_island_game[activityId] then
		return self._saint_knight_expedition_island_game[activityId][index]
	end
end

function StKnExpConfig:getIslandBuffCfgs(activityId)
	return self._saint_knight_expedition_island_buff[activityId]
end

function StKnExpConfig:getIslandBuffCfg(activityId, islandBuffId)
	if self._saint_knight_expedition_island_buff[activityId] then
		return self._saint_knight_expedition_island_buff[activityId][islandBuffId]
	end
end

function StKnExpConfig:getIslandBuffData(activityId, islandBuffId, index)
	if self._saint_knight_expedition_island_buff[activityId] and self._saint_knight_expedition_island_buff[activityId][islandBuffId] then
		return self._saint_knight_expedition_island_buff[activityId][islandBuffId][index]
	end
end

function StKnExpConfig:getIslandBuffClientCfg(activityId)
	return self._saint_knight_expedition_island_buff_client[activityId]
end

function StKnExpConfig:getIslandBuffClientData(activityId, islandBuffId)
	if self._saint_knight_expedition_island_buff_client[activityId] then
		return self._saint_knight_expedition_island_buff_client[activityId][islandBuffId]
	end
end

function StKnExpConfig:getMiningCfg(activityId)
	return self._saint_knight_expedition_mining[activityId]
end

function StKnExpConfig:getMiningData(activityId, times)
	local cfg = self._saint_knight_expedition_mining[activityId]

	return MmUtil.binarySearchInSingleKey(cfg, "times", times)
end

function StKnExpConfig:getMiningPlanCfg(activityId, planId)
	if self._saint_knight_expedition_mining_plan[activityId] then
		return self._saint_knight_expedition_mining_plan[activityId][planId]
	end
end

function StKnExpConfig:getMiningPlanData(activityId, planId, type)
	if self._saint_knight_expedition_mining_plan[activityId] and self._saint_knight_expedition_mining_plan[activityId][planId] then
		return self._saint_knight_expedition_mining_plan[activityId][planId][type]
	end
end

function StKnExpConfig:getFloatwordData(exp)
	local cfg = self._saint_knight_expedition_mining_floatword

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpConfig:getSupportCfg(activityId)
	return self._saint_knight_expedition_support[activityId]
end

function StKnExpConfig:getSupportData(activityId, creepsId)
	if self._saint_knight_expedition_support[activityId] then
		return self._saint_knight_expedition_support[activityId][creepsId]
	end
end

function StKnExpConfig:getMasterData(creepsMasterId)
	return self._saint_knight_expedition_master[creepsMasterId]
end

function StKnExpConfig:getCreepsCfg(creepsMasterId)
	return self._saint_knight_expedition_creeps[creepsMasterId]
end

StKnExpConfig.instance = StKnExpConfig.New()

return StKnExpConfig
