-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/config/GoodOrEvilChallengeConfig.lua

module("logic.extensions.godxiuerchallenge.config.GoodOrEvilChallengeConfig", package.seeall)

local GoodOrEvilChallengeConfig = class("GoodOrEvilChallengeConfig", BaseConfig)

function GoodOrEvilChallengeConfig:onInit()
	GoodOrEvilChallengeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function GoodOrEvilChallengeConfig:getNames()
	return {
		"god_hyur_challenge_info",
		"god_hyur_challenge_type_info",
		"god_hyur_challenge_team",
		"god_hyur_challenge_creeps",
		"god_hyur_challenge_mood",
		"god_hyur_challenge_buff",
		"god_hyur_challenge_true_team",
		"god_hyur_challenge_true_creeps"
	}
end

function GoodOrEvilChallengeConfig:handleConfig(name, content)
	if name == "god_hyur_challenge_info" then
		self._godHyurChallengeInfo = content
	elseif name == "god_hyur_challenge_type_info" then
		self._godHyurChallengeTypeInfo = content
	elseif name == "god_hyur_challenge_team" then
		self._godHyurChallengeTeam = content
	elseif name == "god_hyur_challenge_creeps" then
		self._godHyurChallengeCreeps = content
	elseif name == "god_hyur_challenge_mood" then
		self._godHyurChallengeMood = content
	elseif name == "god_hyur_challenge_buff" then
		self._godHyurChallengeBuff = content
	elseif name == "god_hyur_challenge_true_team" then
		self._godHyurChallengeTrueTeam = content
	elseif name == "god_hyur_challenge_true_creeps" then
		self._godHyurChallengerueCreeps = content
	end
end

function GoodOrEvilChallengeConfig:getCfgById(challengeId)
	return self._godHyurChallengeInfo[challengeId]
end

function GoodOrEvilChallengeConfig:getGodHyurChallengeTrueTeam(creepsMasterId)
	return self._godHyurChallengeTrueTeam[creepsMasterId]
end

function GoodOrEvilChallengeConfig:getChallengerueCreeps(creepsMasterId)
	return self._godHyurChallengerueCreeps[creepsMasterId]
end

function GoodOrEvilChallengeConfig:getChallengeTypeInfo(challengeId)
	return self._godHyurChallengeTypeInfo[challengeId]
end

function GoodOrEvilChallengeConfig:getChallengeTypeInfoByType(challengeId, type, day)
	local list = {}
	local dataList = self._godHyurChallengeTypeInfo.dataList

	for i, v in ipairs(dataList) do
		if v.challengeId == challengeId and v.type == type and v.day == day then
			table.insert(list, v)
		end
	end

	return list
end

function GoodOrEvilChallengeConfig:getChallengeTeam(creepsMasterId)
	return self._godHyurChallengeTeam[creepsMasterId]
end

function GoodOrEvilChallengeConfig:getHyurLimintChallengeCreeps(creepsMasterId)
	return self._godHyurChallengeCreeps[creepsMasterId]
end

function GoodOrEvilChallengeConfig:getMoodCfgByMoodRangeNum(rangeNum, isFinishChallengeAll)
	local tempCfg

	for i, v in ipairs(self._godHyurChallengeMood.dataList) do
		if rangeNum > 0 then
			local min = v.range[1]
			local max = v.range[2]

			if min and max and min >= 0 and max >= 0 then
				tempCfg = v

				if min <= rangeNum and rangeNum <= max then
					return v
				end
			end
		elseif rangeNum < 0 then
			local min = v.range[1]
			local max = v.range[2]

			if min and max and min <= 0 and max <= 0 then
				tempCfg = v

				if min <= rangeNum and rangeNum <= max then
					return v
				end
			end
		elseif not isFinishChallengeAll and v.moodType == 3 then
			return v
		elseif isFinishChallengeAll and v.moodType == 4 then
			return v
		end
	end

	return tempCfg
end

function GoodOrEvilChallengeConfig:getBuffCfg(buffPlanId)
	return self._godHyurChallengeBuff[buffPlanId]
end

GoodOrEvilChallengeConfig.instance = GoodOrEvilChallengeConfig.New()

return GoodOrEvilChallengeConfig
