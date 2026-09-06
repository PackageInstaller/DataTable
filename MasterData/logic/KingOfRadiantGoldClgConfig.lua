-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/config/KingOfRadiantGoldClgConfig.lua

module("logic.extensions.kingofradiantgoldclg.config.KingOfRadiantGoldClgConfig", package.seeall)

local KingOfRadiantGoldClgConfig = class("KingOfRadiantGoldClgConfig", BaseConfig)

function KingOfRadiantGoldClgConfig:onInit()
	KingOfRadiantGoldClgConfig.super.onInit(self)
end

function KingOfRadiantGoldClgConfig:getNames()
	return {
		"king_of_radiant_gold_activity",
		"king_of_radiant_gold_challenge",
		"king_of_radiant_gold_stage",
		"king_of_radiant_gold_score",
		"king_of_radiant_gold_buff",
		"king_of_radiant_gold_pass",
		"king_of_radiant_gold_team",
		"king_of_radiant_gold_creeps"
	}
end

function KingOfRadiantGoldClgConfig:handleConfig(name, content)
	if name == "king_of_radiant_gold_activity" then
		self._king_of_radiant_gold_activity = content
	elseif name == "king_of_radiant_gold_challenge" then
		self._king_of_radiant_gold_challenge = content
	elseif name == "king_of_radiant_gold_stage" then
		self._king_of_radiant_gold_stage = content
	elseif name == "king_of_radiant_gold_score" then
		self._king_of_radiant_gold_score = content
	elseif name == "king_of_radiant_gold_buff" then
		self._king_of_radiant_gold_buff = content
	elseif name == "king_of_radiant_gold_pass" then
		self._king_of_radiant_gold_pass = content
	elseif name == "king_of_radiant_gold_team" then
		self._king_of_radiant_gold_team = content
	elseif name == "king_of_radiant_gold_creeps" then
		self._king_of_radiant_gold_creeps = content
	end
end

function KingOfRadiantGoldClgConfig:getActData(activityId)
	return self._king_of_radiant_gold_activity[activityId]
end

function KingOfRadiantGoldClgConfig:getChallengeCfg(activityId)
	return self._king_of_radiant_gold_challenge[activityId]
end

function KingOfRadiantGoldClgConfig:getChallengeData(activityId, challengeId)
	if self._king_of_radiant_gold_challenge[activityId] then
		return self._king_of_radiant_gold_challenge[activityId][challengeId]
	end
end

function KingOfRadiantGoldClgConfig:getStageCfgs(activityId)
	return self._king_of_radiant_gold_stage[activityId]
end

function KingOfRadiantGoldClgConfig:getStageCfg(activityId, challengeId)
	if self._king_of_radiant_gold_stage[activityId] then
		return self._king_of_radiant_gold_stage[activityId][challengeId]
	end
end

function KingOfRadiantGoldClgConfig:getStageData(activityId, challengeId, stageId)
	if self._king_of_radiant_gold_stage[activityId] and self._king_of_radiant_gold_stage[activityId][challengeId] then
		return self._king_of_radiant_gold_stage[activityId][challengeId][stageId]
	end
end

function KingOfRadiantGoldClgConfig:getScoreCfg(activityId, scorePlanId)
	if self._king_of_radiant_gold_score[activityId] then
		return self._king_of_radiant_gold_score[activityId][scorePlanId]
	end
end

function KingOfRadiantGoldClgConfig:getScoreCfgByStage(activityId, challengeId, stageId)
	local data = self:getStageData(activityId, challengeId, stageId)

	if data then
		if not data.scorePlanId then
			local scorePlanId = 0

			return self:getScoreCfg(activityId, scorePlanId)
		end
	end
end

function KingOfRadiantGoldClgConfig:getScoreDataByNum(activityId, challengeId, stageId, number)
	local data
	local cfg = self:getScoreCfgByStage(activityId, challengeId, stageId)

	if cfg then
		for _, v in ipairs(cfg) do
			if number >= v.number then
				data = v
			else
				break
			end
		end
	end

	return data
end

function KingOfRadiantGoldClgConfig:getBuffCfgs(activityId)
	return self._king_of_radiant_gold_buff[activityId]
end

function KingOfRadiantGoldClgConfig:getBuffCfg(activityId, buffId)
	if self._king_of_radiant_gold_buff[activityId] then
		return self._king_of_radiant_gold_buff[activityId][buffId]
	end
end

function KingOfRadiantGoldClgConfig:getBuffCfgData(activityId, buffId, level)
	local result
	local cfg = self:getBuffCfg(activityId, buffId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if level >= cfg[mid].level then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function KingOfRadiantGoldClgConfig:getBuffMaxLevel(activityId, buffId)
	local level = 0
	local cfg = self:getBuffCfg(activityId, buffId)

	if cfg then
		local maxData = cfg[#cfg]

		level = maxData.level
	end

	return level
end

function KingOfRadiantGoldClgConfig:getPassCfg(activityId)
	return self._king_of_radiant_gold_pass[activityId]
end

function KingOfRadiantGoldClgConfig:getPassData(activityId, num)
	local result
	local cfg = self._king_of_radiant_gold_pass[activityId]

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if num >= cfg[mid].num then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function KingOfRadiantGoldClgConfig:getTeamData(creepsMasterId)
	return self._king_of_radiant_gold_team[creepsMasterId]
end

function KingOfRadiantGoldClgConfig:getCreepsCfg(creepsMasterId)
	return self._king_of_radiant_gold_creeps[creepsMasterId]
end

KingOfRadiantGoldClgConfig.instance = KingOfRadiantGoldClgConfig.New()

return KingOfRadiantGoldClgConfig
