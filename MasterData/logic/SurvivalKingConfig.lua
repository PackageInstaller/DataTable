-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/config/SurvivalKingConfig.lua

module("logic.extensions.survivalking.config.SurvivalKingConfig", package.seeall)

local SurvivalKingConfig = class("SurvivalKingConfig", BaseConfig)

function SurvivalKingConfig:getNames()
	return {
		"survival_king_common",
		"survival_king_prize",
		"survival_king_rank_prize",
		"survival_king_round",
		"survival_king_session",
		"survival_king_support_pet",
		"survival_king_activity",
		"survival_king_buff",
		"survival_king_buff_mode",
		"survival_king_level_buff",
		"survival_king_level_buff_cost"
	}
end

function SurvivalKingConfig:handleConfig(name, content)
	if name == "survival_king_common" then
		self._survival_king_common = content
	elseif name == "survival_king_prize" then
		self._survival_king_prize = content

		self:_handlerSessionPrizeCfgs()
	elseif name == "survival_king_rank_prize" then
		self._survival_king_rank_prize = content

		self:_handlerRankPrizeCfgs()
	elseif name == "survival_king_round" then
		self._survival_king_round = content

		self:_handlerRoundCfgs()
	elseif name == "survival_king_session" then
		self._survival_king_session = content
	elseif name == "survival_king_support_pet" then
		self._survival_king_support_pet = content
	elseif name == "survival_king_activity" then
		self._survival_king_activity = content
	elseif name == "survival_king_buff" then
		self._survival_king_buff = content
	elseif name == "survival_king_buff_mode" then
		self._survival_king_buff_mode = content
	elseif name == "survival_king_level_buff" then
		self._survival_king_level_buff = content
	elseif name == "survival_king_level_buff_cost" then
		self._survival_king_level_buff_cost = content
	end
end

function SurvivalKingConfig:_handlerRankPrizeCfgs()
	self._survival_king_rank_prizelist = {}

	for i, v in ipairs(self._survival_king_rank_prize.dataList) do
		if not self._survival_king_rank_prizelist[v.activityId] then
			table.insert(self._survival_king_rank_prizelist[v.activityId], v)

			self._survival_king_rank_prizelist[v.activityId] = self._survival_king_rank_prizelist[v.activityId]
		end
	end
end

function SurvivalKingConfig:getRankPrizeDataByRank(activityId, rank)
	local cfgs = self._survival_king_rank_prizelist[activityId]

	if cfgs then
		return MmUtil.binarySearchInArrayKey(cfgs, "rankRange", rank)
	end
end

function SurvivalKingConfig:_handlerSessionPrizeCfgs()
	self._survival_king_prizelist = {}

	for i, v in ipairs(self._survival_king_prize.dataList) do
		if not self._survival_king_prizelist[v.activityId] then
			table.insert(self._survival_king_prizelist[v.activityId], v)

			self._survival_king_prizelist[v.activityId] = self._survival_king_prizelist[v.activityId]
		end
	end
end

function SurvivalKingConfig:getRoundPrizeCfgs(activityId)
	return self._survival_king_prize[activityId]
end

function SurvivalKingConfig:getSessionRankPrizeCfg(activityId, lastRoundId)
	local cfgs = self._survival_king_prizelist[activityId]

	if cfgs then
		for i, cfg in ipairs(cfgs) do
			if not cfg.lastRoundId then
				for _, v in ipairs(cfg.lastRoundId) do
					if v == lastRoundId then
						return cfg
					end
				end
			end
		end
	end
end

function SurvivalKingConfig:getSessionCfg(activityId, sessionId)
	local activityCfgs = self._survival_king_session[activityId]

	if activityCfgs then
		return activityCfgs[sessionId]
	end
end

function SurvivalKingConfig:getAllSessionCfg(activityId)
	return self._survival_king_session[activityId]
end

function SurvivalKingConfig:getAllRoundCfgs(activityId)
	return self._survival_king_round[activityId]
end

function SurvivalKingConfig:getRoundCfgByRoundId(activityId, roundId)
	if self._survival_king_round[activityId] then
		return self._survival_king_round[activityId][roundId]
	end
end

function SurvivalKingConfig:_handlerRoundCfgs()
	self._survival_king_round_groupList = {}

	for i, v in ipairs(self._survival_king_round.dataList) do
		if not self._survival_king_round_groupList[v.activityId] then
			if not self._survival_king_round_groupList[v.activityId][v.groupId] then
				local groupCfgs = {}

				table.insert(groupCfgs, v)

				self._survival_king_round_groupList[v.activityId][v.groupId] = groupCfgs
				self._survival_king_round_groupList[v.activityId] = self._survival_king_round_groupList[v.activityId]
			end
		end
	end
end

function SurvivalKingConfig:getAllGroupCfgs(activityId)
	return self._survival_king_round_groupList[activityId]
end

function SurvivalKingConfig:getRoundGroupCfgs(activityId, groupId)
	local cfgs = self._survival_king_round_groupList[activityId]

	if cfgs then
		return cfgs[groupId]
	end
end

function SurvivalKingConfig:convertRoundId2GroupRoundId(activityId, roundId)
	local roundCfg = self:getRoundCfgByRoundId(activityId, roundId)

	if roundCfg then
		local groupId = roundCfg.groupId
		local groupCfgs = self:getRoundGroupCfgs(activityId, groupId) or {}

		for i, v in ipairs(groupCfgs) do
			if v.roundId == roundId then
				return i
			end
		end
	end

	return 0
end

function SurvivalKingConfig:convertGroupRoundId2RoundId(activityId, groupId, groupRoundId)
	local groupCfgs = self:getRoundGroupCfgs(activityId, groupId) or {}

	if groupCfgs[groupRoundId] then
		return groupCfgs[groupRoundId].roundId
	end

	return 0
end

function SurvivalKingConfig:getSupportPetCfgs(activityId)
	return self._survival_king_support_pet[activityId]
end

function SurvivalKingConfig:getSupportPetCfgById(activityId, petId)
	local cfgs = self._survival_king_support_pet[activityId]

	if cfgs then
		return cfgs[petId]
	end
end

function SurvivalKingConfig:getActivityCfg(activityId)
	return self._survival_king_activity[activityId]
end

function SurvivalKingConfig:getCommonValue(key)
	if self._survival_king_common[key] then
		return self._survival_king_common[key].value
	end

	return nil
end

function SurvivalKingConfig:getAllBuffCfgs(activityId)
	return self._survival_king_buff[activityId]
end

function SurvivalKingConfig:getBuffCfgById(activityId, buffId)
	if self._survival_king_buff[activityId] then
		return self._survival_king_buff[activityId][buffId]
	end
end

function SurvivalKingConfig:getBuffModeCfg(buffMode)
	if self._survival_king_buff_mode then
		if self._survival_king_buff_mode then
			return self._survival_king_buff_mode[next(self._survival_king_buff_mode)]
		end
	end
end

function SurvivalKingConfig:getBuffModeName(activityId)
	local cfg = self:getBuffModeCfg(self:getBuffMode(activityId))

	return cfg and cfg.modeName
end

function SurvivalKingConfig:getBuffMode(activityId)
	local actCfg = self:getActivityCfg(activityId)

	if not actCfg then
		return 0
	end

	return actCfg.buffMode or 0
end

function SurvivalKingConfig:isBuffMode(activityId, buffMode)
	return self:getBuffMode(activityId) == buffMode
end

function SurvivalKingConfig:canSetLevelBuff(activityId, roundId)
	local roundCfg = self:getRoundCfgByRoundId(activityId, roundId)

	return roundCfg and roundCfg.levelBuffEffect
end

function SurvivalKingConfig:getAllLevelBuffCfgs(activityId)
	return self._survival_king_level_buff and self._survival_king_level_buff[activityId]
end

function SurvivalKingConfig:getLevelBuffCfg(activityId, buffId, level)
	local cfgs = self:getAllLevelBuffCfgs(activityId)

	if cfgs and cfgs[buffId] then
		return cfgs[buffId][level]
	end
end

function SurvivalKingConfig:getLevelBuffMaxLevel(activityId, buffId)
	local cfgs = self:getAllLevelBuffCfgs(activityId)
	local levelCfgs = cfgs and cfgs[buffId]

	if not levelCfgs then
		return 0
	end

	return #levelCfgs
end

function SurvivalKingConfig:getLevelBuffCostCfg(activityId, level)
	if self._survival_king_level_buff_cost then
		return self._survival_king_level_buff_cost and self._survival_king_level_buff_cost[level]
	end
end

SurvivalKingConfig.instance = SurvivalKingConfig.New()

return SurvivalKingConfig
