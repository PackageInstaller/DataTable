-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/config/ChopKingConfig.lua

module("logic.extensions.chopking.config.ChopKingConfig", package.seeall)

local ChopKingConfig = class("ChopKingConfig", BaseConfig)

function ChopKingConfig:getNames()
	return {
		"chop_king_activity",
		"chop_king_first_clg",
		"chop_king_first_clg_buff_rerandom_cost",
		"chop_king_first_clg_buff",
		"chop_king_loop_clg",
		"chop_king_loop_clg_attribute",
		"chop_king_circle_clg",
		"chop_king_against_two_clg",
		"chop_king_score",
		"chop_king_first_rank_prize",
		"chop_king_total_rank_prize",
		"chop_king_support_pet",
		"chop_king_creeps_master",
		"chop_king_creeps"
	}
end

function ChopKingConfig:handleConfig(name, content)
	if name == "chop_king_activity" then
		self._chop_king_activity = content
	elseif name == "chop_king_first_clg" then
		self._chop_king_first_clg = content
	elseif name == "chop_king_first_clg_buff_rerandom_cost" then
		self._chop_king_first_clg_buff_rerandom_cost = content
	elseif name == "chop_king_first_clg_buff" then
		self._chop_king_first_clg_buff = content
	elseif name == "chop_king_loop_clg" then
		self._chop_king_loop_clg = content
	elseif name == "chop_king_loop_clg_attribute" then
		self._chop_king_loop_clg_attribute = content
	elseif name == "chop_king_circle_clg" then
		self._chop_king_circle_clg = content
	elseif name == "chop_king_against_two_clg" then
		self._chop_king_against_two_clg = content
	elseif name == "chop_king_score" then
		self._chop_king_score = content
	elseif name == "chop_king_first_rank_prize" then
		self._chop_king_first_rank_prize = content
	elseif name == "chop_king_total_rank_prize" then
		self._chop_king_total_rank_prize = content
	elseif name == "chop_king_support_pet" then
		self._chop_king_support_pet = content

		self:handlerSupportPetContent()
	elseif name == "chop_king_creeps_master" then
		self._chop_king_creeps_master = content
	elseif name == "chop_king_creeps" then
		self._chop_king_creeps = content
	end
end

function ChopKingConfig:getActivityCfg(activityId)
	return self._chop_king_activity[activityId]
end

function ChopKingConfig:getFirstClgStageList(activityId)
	return self._chop_king_first_clg[activityId]
end

function ChopKingConfig:getFirstClgStageCfg(activityId, stageId)
	if self._chop_king_first_clg[activityId] then
		return self._chop_king_first_clg[activityId][stageId]
	end
end

function ChopKingConfig:getMonsterCfg(creepsMasterId)
	return self._chop_king_creeps_master[creepsMasterId]
end

function ChopKingConfig:getCreeps(creepsMasterId)
	return self._chop_king_creeps[creepsMasterId]
end

function ChopKingConfig:getDropBuff(activityId, buffId)
	if self._chop_king_first_clg_buff[activityId] then
		return self._chop_king_first_clg_buff[activityId][buffId]
	end
end

function ChopKingConfig:handlerSupportPetContent()
	self._supportPetPool = {}

	for i, v in ipairs(self._chop_king_support_pet.dataList) do
		self._supportPetPool[v.activityId] = self._supportPetPool[v.activityId] or {}
		self._supportPetPool[v.activityId][v.supportPetPoolId] = self._supportPetPool[v.activityId][v.supportPetPoolId] or {}

		table.insert(self._supportPetPool[v.activityId][v.supportPetPoolId], v.creepsId)
	end
end

function ChopKingConfig:getSupportPetIds(activityId, supportPetPoolId)
	if self._supportPetPool[activityId] then
		return self._supportPetPool[activityId][supportPetPoolId]
	end
end

function ChopKingConfig:getSupportPetCfg(activityId, creepsId)
	if self._chop_king_support_pet[activityId] then
		return self._chop_king_support_pet[activityId][creepsId]
	end
end

function ChopKingConfig:getFirstClgReRandomCfg(activityId, reRandomCount)
	local cfgList = self._chop_king_first_clg_buff_rerandom_cost[activityId]

	if cfgList then
		local cfg = cfgList[#cfgList]

		for i, v in ipairs(cfgList) do
			if v.reRandomCount == reRandomCount then
				return v
			end
		end

		return cfg
	end
end

function ChopKingConfig:getCircleClgCfgs(activityId)
	return self._chop_king_circle_clg[activityId]
end

function ChopKingConfig:getCircleClgCfg(activityId, stageId)
	if self._chop_king_circle_clg[activityId] then
		return self._chop_king_circle_clg[activityId][stageId]
	end
end

function ChopKingConfig:getAgainstTwoStageCfgs(activityId)
	return self._chop_king_against_two_clg[activityId]
end

function ChopKingConfig:getAgainstTwoStageCfg(activityId, stageId)
	if self._chop_king_against_two_clg[activityId] then
		return self._chop_king_against_two_clg[activityId][stageId]
	end
end

function ChopKingConfig:getScoreByNum(activityId, planId, num)
	if self._chop_king_score[activityId] and self._chop_king_score[activityId][planId] then
		local maxIndex = 0

		for start, v in pairs(self._chop_king_score[activityId][planId]) do
			if start <= num and maxIndex < start then
				maxIndex = start
			end
		end

		return self._chop_king_score[activityId][planId][maxIndex].score
	end

	return 0
end

function ChopKingConfig:getLoopClgStageCfgs(activityId)
	return self._chop_king_loop_clg[activityId]
end

function ChopKingConfig:getLoopClgStageCfg(activityId, stageId)
	if self._chop_king_loop_clg[activityId] then
		return self._chop_king_loop_clg[activityId][stageId]
	end
end

function ChopKingConfig:getLoopClgLoopCfgs(activityId)
	return self._chop_king_loop_clg_attribute[activityId]
end

function ChopKingConfig:getLoopClgLoopCfg(activityId, loopId)
	if self._chop_king_loop_clg_attribute[activityId] then
		return self._chop_king_loop_clg_attribute[activityId][loopId]
	end
end

function ChopKingConfig:getFirstRankPrizeCfgs(activityId)
	return self._chop_king_first_rank_prize[activityId]
end

function ChopKingConfig:getTotalRankPrizeCfgs(activityId)
	return self._chop_king_total_rank_prize[activityId]
end

ChopKingConfig.instance = ChopKingConfig.New()

return ChopKingConfig
