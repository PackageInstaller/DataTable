-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/config/SixartdaoguanConfig.lua

module("logic.extensions.sixartdaoguan.config.SixartdaoguanConfig", package.seeall)

local SixartdaoguanConfig = class("SixartdaoguanConfig", BaseConfig)

function SixartdaoguanConfig:onInit()
	return
end

function SixartdaoguanConfig:getNames()
	return {
		"six_art_daoguan_drop_buff_rerandom_cost",
		"six_art_daoguan_rank_prize",
		"six_art_daoguan_drop_buff",
		"six_art_daoguan_creeps_master",
		"six_art_daoguan_rent_pet",
		"six_art_daoguan_challenge",
		"six_art_daoguan_creeps",
		"six_art_daoguan_activity",
		"six_art_daoguan_stage",
		"six_art_daoguan_client"
	}
end

function SixartdaoguanConfig:handleConfig(name, content)
	if name == "six_art_daoguan_drop_buff_rerandom_cost" then
		self._six_art_daoguan_drop_buff_rerandom_cost = content
	elseif name == "six_art_daoguan_rank_prize" then
		self._six_art_daoguan_rank_prize = content

		self:_handleRankPrizeSort()
	elseif name == "six_art_daoguan_drop_buff" then
		self._six_art_daoguan_drop_buff = content
	elseif name == "six_art_daoguan_creeps_master" then
		self._six_art_daoguan_creeps_master = content
	elseif name == "six_art_daoguan_rent_pet" then
		self._six_art_daoguan_rent_pet = content
	elseif name == "six_art_daoguan_challenge" then
		self._six_art_daoguan_challenge = content
	elseif name == "six_art_daoguan_creeps" then
		self._six_art_daoguan_creeps = content
	elseif name == "six_art_daoguan_activity" then
		self._six_art_daoguan_activity = content
	elseif name == "six_art_daoguan_stage" then
		self._six_art_daoguan_stage = content
	elseif name == "six_art_daoguan_client" then
		self._six_art_daoguan_client = content
	end
end

function SixartdaoguanConfig:getChallengeCfgs(activityId)
	return self._six_art_daoguan_challenge[activityId]
end

function SixartdaoguanConfig:getChallengeCfg(activityId, challengeId)
	return self._six_art_daoguan_challenge[activityId][challengeId]
end

function SixartdaoguanConfig:getStageCfgs(activityId, challengeId)
	return self._six_art_daoguan_stage[activityId][challengeId]
end

function SixartdaoguanConfig:getStageCfg(activityId, challengeId, stageId)
	return self._six_art_daoguan_stage[activityId][challengeId][stageId]
end

function SixartdaoguanConfig:getCreepsMasterCfg(creepsMasterId)
	return self._six_art_daoguan_creeps_master[creepsMasterId]
end

function SixartdaoguanConfig:getCreepsCfgs(creepsMasterId)
	return self._six_art_daoguan_creeps[creepsMasterId]
end

function SixartdaoguanConfig:getCreepsCfg(creepsMasterId, creepsId)
	return self._six_art_daoguan_creeps[creepsMasterId][creepsId]
end

function SixartdaoguanConfig:getCreepsCfgByRaceId(creepsMasterId, raceId)
	local cfgs = self:getCreepsCfgs(creepsMasterId)

	for i, v in pairs(cfgs) do
		if v.raceId == raceId then
			return v
		end
	end
end

function SixartdaoguanConfig:getRentPetCfgs(activityId)
	return self._six_art_daoguan_rent_pet[activityId]
end

function SixartdaoguanConfig:getRentPetCfg(activityId, creepsId)
	return self._six_art_daoguan_rent_pet[activityId][creepsId]
end

function SixartdaoguanConfig:getMaxBuffRerandomCount(activityId)
	return #self._six_art_daoguan_drop_buff_rerandom_cost[activityId]
end

function SixartdaoguanConfig:getBuffRerandomCfg(activityId, count)
	return self._six_art_daoguan_drop_buff_rerandom_cost[activityId][count]
end

function SixartdaoguanConfig:getBuffCfg(activityId, buffId)
	return self._six_art_daoguan_drop_buff[activityId][buffId]
end

function SixartdaoguanConfig:getRankPrizeCfg(activityId, rank)
	for i, v in pairs(self._six_art_daoguan_rank_prize[activityId]) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end

	return nil
end

function SixartdaoguanConfig:getRankPrizeCfgsWithSort(activityId)
	return self._rank_prize_sort[activityId]
end

function SixartdaoguanConfig:_handleRankPrizeSort()
	self._rank_prize_sort = {}

	for i, v in ipairs(self._six_art_daoguan_rank_prize.dataList) do
		self._rank_prize_sort[v.activityId] = self._rank_prize_sort[v.activityId] or {}

		table.insert(self._rank_prize_sort[v.activityId], v)
	end

	for i, list in ipairs(self._rank_prize_sort) do
		table.sort(list, function(a, b)
			return a.rankRange[1] < b.rankRange[1]
		end)
	end
end

function SixartdaoguanConfig:getClientValue(key, need2number)
	local value = self._six_art_daoguan_client[key].value

	if need2number then
		return checknumber(value)
	end

	return value
end

SixartdaoguanConfig.instance = SixartdaoguanConfig.New()

return SixartdaoguanConfig
