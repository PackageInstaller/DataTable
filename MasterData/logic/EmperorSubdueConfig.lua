-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/config/EmperorSubdueConfig.lua

module("logic.extensions.emperorsubdue.config.EmperorSubdueConfig", package.seeall)

local EmperorSubdueConfig = class("EmperorSubdueConfig", BaseConfig)

function EmperorSubdueConfig:getNames()
	return {
		"emperor_subdue_buff",
		"emperor_subdue_score_rank_prize",
		"emperor_subdue_support_pet",
		"emperor_subdue_stage",
		"emperor_subdue_activity",
		"emperor_subdue_boss",
		"emperor_subdue_master",
		"emperor_subdue_creeps",
		"emperor_subdue_progress"
	}
end

function EmperorSubdueConfig:handleConfig(name, content)
	if name == "emperor_subdue_buff" then
		self._emperor_subdue_buff = content
	elseif name == "emperor_subdue_score_rank_prize" then
		self._emperor_subdue_score_rank_prize = content

		self:_handlerRankPrizeCfgs()
	elseif name == "emperor_subdue_support_pet" then
		self._emperor_subdue_support_pet = content
	elseif name == "emperor_subdue_stage" then
		self._emperor_subdue_stage = content
	elseif name == "emperor_subdue_activity" then
		self._emperor_subdue_activity = content
	elseif name == "emperor_subdue_boss" then
		self._emperor_subdue_boss = content
	elseif name == "emperor_subdue_master" then
		self._emperor_subdue_master = content
	elseif name == "emperor_subdue_creeps" then
		self._emperor_subdue_creeps = content
	elseif name == "emperor_subdue_progress" then
		self._emperor_subdue_progress = content
	end
end

function EmperorSubdueConfig:getCreepCfgs(creepsMasterId)
	return self._emperor_subdue_creeps[creepsMasterId]
end

function EmperorSubdueConfig:getTeamCfg(creepsMasterId)
	return self._emperor_subdue_master[creepsMasterId]
end

function EmperorSubdueConfig:getSupportPetCfgs(planId)
	return self._emperor_subdue_support_pet[planId]
end

function EmperorSubdueConfig:getActCfg(activityId)
	return self._emperor_subdue_activity[activityId]
end

function EmperorSubdueConfig:getBuffCfgs(activityId)
	return self._emperor_subdue_buff[activityId]
end

function EmperorSubdueConfig:getBuffCfgById(activityId, buffId)
	if self._emperor_subdue_buff[activityId] then
		return self._emperor_subdue_buff[activityId][buffId]
	end
end

function EmperorSubdueConfig:getStageCfgs(activityId)
	return self._emperor_subdue_stage[activityId]
end

function EmperorSubdueConfig:getStageCfgById(activityId, stageId)
	if self._emperor_subdue_stage[activityId] then
		return self._emperor_subdue_stage[activityId][stageId]
	end
end

function EmperorSubdueConfig:getBossCfgs(activityId)
	return self._emperor_subdue_boss[activityId]
end

function EmperorSubdueConfig:getBossCfgByTimes(activityId, times)
	if self._emperor_subdue_boss[activityId] then
		return self._emperor_subdue_boss[activityId][times]
	end
end

function EmperorSubdueConfig:getProgressCfgs(activityId)
	return self._emperor_subdue_progress[activityId]
end

function EmperorSubdueConfig:_handlerRankPrizeCfgs()
	self._emperor_subdue_score_rank_prizelist = {}

	for i, v in ipairs(self._emperor_subdue_score_rank_prize.dataList) do
		if not self._emperor_subdue_score_rank_prizelist[v.activityId] then
			table.insert(self._emperor_subdue_score_rank_prizelist[v.activityId], v)

			self._emperor_subdue_score_rank_prizelist[v.activityId] = self._emperor_subdue_score_rank_prizelist[v.activityId]
		end
	end
end

function EmperorSubdueConfig:getRankPrizeDataByRank(actId, rank)
	local prizeCfgs = self._emperor_subdue_score_rank_prizelist[actId]

	if prizeCfgs then
		return MmUtil.binarySearchInArrayKey(prizeCfgs, "rankRange", rank)
	end
end

EmperorSubdueConfig.instance = EmperorSubdueConfig.New()

return EmperorSubdueConfig
