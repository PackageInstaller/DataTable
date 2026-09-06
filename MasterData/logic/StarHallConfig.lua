-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/config/StarHallConfig.lua

module("logic.extensions.starhall.config.StarHallConfig", package.seeall)

local StarHallConfig = class("StarHallConfig", BaseConfig)

function StarHallConfig:getNames()
	return {
		"star_hall_support_pet",
		"star_hall_stage_difficulty",
		"star_hall_settlement",
		"star_hall_creeps",
		"star_hall_activity",
		"star_hall_creeps_master",
		"star_hall_stage",
		"star_hall_rank_prize",
		"star_hall_hud_config"
	}
end

function StarHallConfig:handleConfig(name, content)
	if name == "star_hall_support_pet" then
		self._star_hall_support_pet = content

		self:_handlerSupportPetCfg()
	elseif name == "star_hall_stage_difficulty" then
		self._star_hall_stage_difficulty = content
	elseif name == "star_hall_settlement" then
		self._star_hall_settlement = content
	elseif name == "star_hall_creeps" then
		self._star_hall_creeps = content
	elseif name == "star_hall_activity" then
		self._star_hall_activity = content
	elseif name == "star_hall_creeps_master" then
		self._star_hall_creeps_master = content
	elseif name == "star_hall_stage" then
		self._star_hall_stage = content
	elseif name == "star_hall_rank_prize" then
		self._star_hall_rank_prize = content

		self:_handlerRankPrizeCfgs()
	elseif name == "star_hall_hud_config" then
		self._star_hall_hud_config = content
	end
end

function StarHallConfig:getActCfgById(actId)
	return self._star_hall_activity[actId]
end

function StarHallConfig:getStageCfgsById(actId)
	return self._star_hall_stage[actId]
end

function StarHallConfig:getStageCfgByStageId(actId, stageId)
	if self._star_hall_stage[actId] then
		return self._star_hall_stage[actId][stageId]
	end
end

function StarHallConfig:getStageDifficultyCfgsById(actId, stageId)
	if self._star_hall_stage_difficulty[actId] then
		return self._star_hall_stage_difficulty[actId][stageId]
	end
end

function StarHallConfig:getStageDifficultyCfgsByDiffId(actId, stageId, diffId)
	if self._star_hall_stage_difficulty[actId] and self._star_hall_stage_difficulty[actId][stageId] then
		return self._star_hall_stage_difficulty[actId][stageId][diffId]
	end
end

function StarHallConfig:getSettlementCfgsById(actId)
	return self._star_hall_settlement[actId]
end

function StarHallConfig:_handlerRankPrizeCfgs()
	self._star_hall_rank_prizelist = {}

	for i, v in ipairs(self._star_hall_rank_prize.dataList) do
		if not self._star_hall_rank_prizelist[v.activityId] then
			table.insert(self._star_hall_rank_prizelist[v.activityId], v)

			self._star_hall_rank_prizelist[v.activityId] = self._star_hall_rank_prizelist[v.activityId]
		end
	end
end

function StarHallConfig:getRankPrizeDataByRank(actId, rank)
	local prizeCfgs = self._star_hall_rank_prizelist[actId]

	if prizeCfgs then
		return MmUtil.binarySearchInArrayKey(prizeCfgs, "rankRange", rank)
	end
end

function StarHallConfig:getCreepCfgs(creepsMasterId)
	return self._star_hall_creeps[creepsMasterId]
end

function StarHallConfig:getTeamCfg(creepsMasterId)
	return self._star_hall_creeps_master[creepsMasterId]
end

function StarHallConfig:_handlerSupportPetCfg()
	self._star_hall_support_petlist = {}

	for i, v in ipairs(self._star_hall_support_pet.dataList) do
		if not self._star_hall_support_petlist[v.activityId] then
			table.insert(self._star_hall_support_petlist[v.activityId], v)

			self._star_hall_support_petlist[v.activityId] = self._star_hall_support_petlist[v.activityId]
		end
	end
end

function StarHallConfig:getSupportPetCfgs(actId)
	return self._star_hall_support_petlist[actId]
end

function StarHallConfig:getHudCommondValue(key)
	local cfg = self._star_hall_hud_config[key]

	if cfg then
		return cfg.value
	end
end

StarHallConfig.instance = StarHallConfig.New()

return StarHallConfig
