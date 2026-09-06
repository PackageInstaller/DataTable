-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/config/FreeScuffleConfig.lua

module("logic.extensions.freescuffle.config.FreeScuffleConfig", package.seeall)

local FreeScuffleConfig = class("FreeScuffleConfig", BaseConfig)

function FreeScuffleConfig:getNames()
	return {
		"free_scuffle_activity",
		"free_scuffle_block",
		"free_scuffle_pet",
		"free_scuffle_increase_effect",
		"free_scuffle_pet_relationship",
		"free_scuffle_level_plan",
		"free_scuffle_star_plan",
		"free_scuffle_extra_game",
		"free_scuffle_lottery_pool",
		"free_scuffle_lottery",
		"free_scuffle_package_plan",
		"free_scuffle_task",
		"free_scuffle_skill",
		"free_scuffle_guest_event_prize",
		"free_scuffle_lottery_card",
		"free_scuffle_lottery_extra_item",
		"free_scuffle_battle_pet",
		"free_scuffle_creeps_master",
		"free_scuffle_creeps",
		"free_scuffle_global_buff",
		"free_scuffle_pvp_score_rank_prize",
		"free_scuffle_coin_rank_prize",
		"free_scuffle_task_progress_prize"
	}
end

function FreeScuffleConfig:handleConfig(name, content)
	if name == "free_scuffle_activity" then
		self._free_scuffle_activity = content
	elseif name == "free_scuffle_block" then
		self._free_scuffle_block = content
	elseif name == "free_scuffle_pet" then
		self._free_scuffle_pet = content
	elseif name == "free_scuffle_increase_effect" then
		self._free_scuffle_increase_effect = content
	elseif name == "free_scuffle_pet_relationship" then
		self._free_scuffle_pet_relationship = content
	elseif name == "free_scuffle_level_plan" then
		self._free_scuffle_level_plan = content
	elseif name == "free_scuffle_star_plan" then
		self._free_scuffle_star_plan = content
	elseif name == "free_scuffle_extra_game" then
		self._free_scuffle_extra_game = content
	elseif name == "free_scuffle_lottery_pool" then
		self._free_scuffle_lottery_pool = content
	elseif name == "free_scuffle_lottery" then
		self._free_scuffle_lottery = content
	elseif name == "free_scuffle_package_plan" then
		self._free_scuffle_package_plan = content
	elseif name == "free_scuffle_task" then
		self._free_scuffle_task = content
		self._taskDataLists = {}
	elseif name == "free_scuffle_skill" then
		self._free_scuffle_skill = content
		self._skillDataLists = {}
	elseif name == "free_scuffle_guest_event_prize" then
		self._free_scuffle_guest_event_prize = content
	elseif name == "free_scuffle_lottery_card" then
		self._free_scuffle_lottery_card = content
	elseif name == "free_scuffle_lottery_extra_item" then
		self._free_scuffle_lottery_extra_item = content
	elseif name == "free_scuffle_battle_pet" then
		self._free_scuffle_battle_pet = content
	elseif name == "free_scuffle_creeps_master" then
		self._free_scuffle_creeps_master = content
	elseif name == "free_scuffle_creeps" then
		self._free_scuffle_creeps = content
	elseif name == "free_scuffle_global_buff" then
		self._free_scuffle_global_buff = content
	elseif name == "free_scuffle_pvp_score_rank_prize" then
		self._free_scuffle_pvp_score_rank_prize = content
		self._pvpScoreRankPrizeCfg = {}
	elseif name == "free_scuffle_coin_rank_prize" then
		self._free_scuffle_coin_rank_prize = content
		self._coinRankPrizeCfg = {}
	elseif name == "free_scuffle_task_progress_prize" then
		self._free_scuffle_task_progress_prize = content
	end
end

function FreeScuffleConfig:getActData(activityId)
	return self._free_scuffle_activity[activityId]
end

function FreeScuffleConfig:getBlockCfg(activityId)
	return self._free_scuffle_block[activityId]
end

function FreeScuffleConfig:getBlockData(activityId, blockId)
	if self._free_scuffle_block[activityId] then
		return self._free_scuffle_block[activityId][blockId]
	end
end

function FreeScuffleConfig:getPetCfg(activityId)
	return self._free_scuffle_pet[activityId]
end

function FreeScuffleConfig:getPetData(activityId, raceId)
	if self._free_scuffle_pet[activityId] then
		return self._free_scuffle_pet[activityId][raceId]
	end
end

function FreeScuffleConfig:getIncreaseEffectCfg(activityId)
	return self._free_scuffle_increase_effect[activityId]
end

function FreeScuffleConfig:getIncreaseEffectData(activityId, effectId)
	if self._free_scuffle_increase_effect[activityId] then
		return self._free_scuffle_increase_effect[activityId][effectId]
	end
end

function FreeScuffleConfig:getShipCfg(activityId)
	return self._free_scuffle_pet_relationship[activityId]
end

function FreeScuffleConfig:getShipData(activityId, relationshipId)
	if self._free_scuffle_pet_relationship[activityId] then
		return self._free_scuffle_pet_relationship[activityId][relationshipId]
	end
end

function FreeScuffleConfig:getLevelCfg(activityId, raceId)
	local data = self:getPetData(activityId, raceId)

	return data and self._free_scuffle_level_plan[data.levelPlan]
end

function FreeScuffleConfig:getLevelData(activityId, raceId, level)
	local cfg = self:getLevelCfg(activityId, raceId)

	return cfg and cfg[level]
end

function FreeScuffleConfig:getStarCfg(activityId, raceId)
	local data = self:getPetData(activityId, raceId)

	return data and self._free_scuffle_star_plan[data.starPlan]
end

function FreeScuffleConfig:getStarData(activityId, raceId, star)
	local cfg = self:getStarCfg(activityId, raceId)

	return cfg and cfg[star]
end

function FreeScuffleConfig:getExtraGameData(activityId, type)
	if self._free_scuffle_extra_game[activityId] then
		return self._free_scuffle_extra_game[activityId][type]
	end
end

function FreeScuffleConfig:getPoolCfg(activityId)
	return self._free_scuffle_lottery_pool[activityId]
end

function FreeScuffleConfig:getPoolData(activityId, poolId)
	if self._free_scuffle_lottery_pool[activityId] then
		return self._free_scuffle_lottery_pool[activityId][poolId]
	end
end

function FreeScuffleConfig:getLotteryCfg(activityId, poolId)
	local data = self:getPoolData(activityId, poolId)

	return data and self._free_scuffle_lottery[data.lotteryPlanId]
end

function FreeScuffleConfig:getLotteryData(activityId, poolId, prizeId)
	local cfg = self:getLotteryCfg(activityId, poolId)

	return cfg and cfg[prizeId]
end

function FreeScuffleConfig:getPackageCfg(activityId, blockId)
	local data = self:getBlockData(activityId, blockId)

	return data and self._free_scuffle_package_plan[data.packagePrizePlan]
end

function FreeScuffleConfig:getPackageData(activityId, blockId, packageId)
	local cfg = self:getPackageCfg(activityId, blockId)

	return cfg and cfg[packageId]
end

function FreeScuffleConfig:getTaskCfg(activityId)
	return self._free_scuffle_task[activityId]
end

function FreeScuffleConfig:getTaskData(activityId, taskId)
	if self._free_scuffle_task[activityId] then
		return self._free_scuffle_task[activityId][taskId]
	end
end

function FreeScuffleConfig:getTaskDataListByGroup(activityId, group)
	self._taskDataLists[activityId] = self._taskDataLists[activityId] or {}

	local dataList = self._taskDataLists[activityId][group]

	if dataList == nil then
		self._taskDataLists[activityId][group] = {}
		dataList = self._taskDataLists[activityId][group]

		local cfg = self:getTaskCfg(activityId) or {}

		for _, data in ipairs(cfg) do
			if data.group == group then
				table.insert(dataList, data)
			end
		end
	end

	return dataList
end

function FreeScuffleConfig:getSkillCfg(activityId)
	return self._free_scuffle_skill[activityId]
end

function FreeScuffleConfig:getSkillData(activityId, skillId)
	if self._free_scuffle_skill[activityId] then
		return self._free_scuffle_skill[activityId][skillId]
	end
end

function FreeScuffleConfig:getSkillDataListByType(activityId, type)
	self._skillDataLists[activityId] = self._skillDataLists[activityId] or {}

	if self._skillDataLists[activityId][type] == nil then
		self._skillDataLists[activityId][type] = {}

		local cfg = self:getSkillCfg(activityId) or {}

		for _, data in ipairs(cfg) do
			if data.type == type then
				table.insert(self._skillDataLists[activityId][type], data)
			end
		end
	end

	return self._skillDataLists[activityId][type]
end

function FreeScuffleConfig:getGuestEventPrizCfg(activityId, prizeId)
	return self._free_scuffle_guest_event_prize[activityId]
end

function FreeScuffleConfig:getGuestEventPrizeData(activityId, prizeId)
	if self._free_scuffle_guest_event_prize[activityId] then
		return self._free_scuffle_guest_event_prize[activityId][prizeId]
	end
end

function FreeScuffleConfig:getGuestEventPrizeDataByHit(activityId, hitCount)
	local cfg = self._free_scuffle_guest_event_prize[activityId]

	return MmUtil.binarySearchInSingleKey(cfg, "hitCount", hitCount)
end

function FreeScuffleConfig:getGuestLotteryCardData(activityId, type)
	if self._free_scuffle_lottery_card[activityId] then
		return self._free_scuffle_lottery_card[activityId][type]
	end
end

function FreeScuffleConfig:getLotteryExtraItemCfg(activityId, type)
	local data = self:getGuestLotteryCardData(activityId, type)

	return data and self._free_scuffle_lottery_extra_item[data.extraLotteryPlanId]
end

function FreeScuffleConfig:getLotteryExtraItemData(activityId, type, itemId)
	local cfg = self:getLotteryExtraItemCfg(activityId, type)

	return cfg and cfg[itemId]
end

function FreeScuffleConfig:getScuffleBattlePetCfg(activityId)
	return self._free_scuffle_battle_pet[activityId]
end

function FreeScuffleConfig:getScuffleBattlePetData(activityId, creepsId)
	if self._free_scuffle_battle_pet[activityId] then
		return self._free_scuffle_battle_pet[activityId][creepsId]
	end
end

function FreeScuffleConfig:getMasterData(creepsMasterId)
	return self._free_scuffle_creeps_master[creepsMasterId]
end

function FreeScuffleConfig:getCreepsCfg(creepsMasterId)
	return self._free_scuffle_creeps[creepsMasterId]
end

function FreeScuffleConfig:getGlobalBuffCfg(activityId)
	return self._free_scuffle_global_buff[activityId]
end

function FreeScuffleConfig:getGlobalBuffData(activityId, buffId)
	if self._free_scuffle_global_buff[activityId] then
		return self._free_scuffle_global_buff[activityId][buffId]
	end
end

function FreeScuffleConfig:getPvpScoreRankPrizeCfg(activityId)
	local cfg = self._pvpScoreRankPrizeCfg[activityId]

	if cfg == nil then
		local config = self._free_scuffle_pvp_score_rank_prize[activityId]

		if config then
			self._pvpScoreRankPrizeCfg[activityId] = {}
			cfg = self._pvpScoreRankPrizeCfg[activityId]

			for i, data in pairs(config) do
				cfg[data.id] = data
			end
		end
	end

	return cfg
end

function FreeScuffleConfig:getPvpScoreRankPrizeData(activityId, rank)
	local cfg = self:getPvpScoreRankPrizeCfg(activityId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function FreeScuffleConfig:getCoinRankPrizeCfg(activityId)
	local cfg = self._coinRankPrizeCfg[activityId]

	if cfg == nil then
		local config = self._free_scuffle_coin_rank_prize[activityId]

		if config then
			self._coinRankPrizeCfg[activityId] = {}
			cfg = self._coinRankPrizeCfg[activityId]

			for i, data in pairs(config) do
				cfg[data.id] = data
			end
		end
	end

	return cfg
end

function FreeScuffleConfig:getCoinRankPrizeData(activityId, rank)
	local cfg = self:getCoinRankPrizeCfg(activityId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function FreeScuffleConfig:getTaskProgressPrizeCfg(activityId)
	return self._free_scuffle_task_progress_prize[activityId]
end

function FreeScuffleConfig:getTaskProgressPrizeData(activityId, progressId)
	if self._free_scuffle_task_progress_prize[activityId] then
		return self._free_scuffle_task_progress_prize[activityId][progressId]
	end
end

FreeScuffleConfig.instance = FreeScuffleConfig.New()

return FreeScuffleConfig
