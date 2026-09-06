-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/config/SunWuKongChallengeConfig.lua

module("logic.extensions.sunwukongchallenge.config.SunWuKongChallengeConfig", package.seeall)

local SunWuKongChallengeConfig = class("SunWuKongChallengeConfig", BaseConfig)

function SunWuKongChallengeConfig:onInit()
	SunWuKongChallengeConfig.super.onInit(self)
end

function SunWuKongChallengeConfig:getNames()
	return {
		"sun_wu_kong_challenge",
		"sun_wu_kong_challenge_stage",
		"sun_wu_kong_challenge_master",
		"sun_wu_kong_challenge_creeps",
		"sun_wu_kong_challenge_hidden_task",
		"sun_wu_kong_challenge_prize",
		"sun_wu_kong_challenge_cimelia",
		"sun_wu_kong_challenge_cimelia_level",
		"sun_wu_kong_challenge_cimelia_buff",
		"sun_wu_kong_challenge_flip_game",
		"sun_wu_kong_challenge_balloon_game"
	}
end

function SunWuKongChallengeConfig:handleConfig(name, content)
	if name == "sun_wu_kong_challenge" then
		self._sun_wu_kong_challenge = content
	elseif name == "sun_wu_kong_challenge_stage" then
		self._sun_wu_kong_challenge_stage = content
	elseif name == "sun_wu_kong_challenge_master" then
		self._sun_wu_kong_challenge_master = content
	elseif name == "sun_wu_kong_challenge_creeps" then
		self._sun_wu_kong_challenge_creeps = content
	elseif name == "sun_wu_kong_challenge_hidden_task" then
		self._sun_wu_kong_challenge_hidden_task = content
	elseif name == "sun_wu_kong_challenge_prize" then
		self._sun_wu_kong_challenge_prize = content
	elseif name == "sun_wu_kong_challenge_cimelia" then
		self._sun_wu_kong_challenge_cimelia = content
	elseif name == "sun_wu_kong_challenge_cimelia_level" then
		self._sun_wu_kong_challenge_cimelia_level = content
	elseif name == "sun_wu_kong_challenge_cimelia_buff" then
		self._susun_wu_kong_challenge_cimelia_buff = content
	elseif name == "sun_wu_kong_challenge_flip_game" then
		self._sun_wu_kong_challenge_flip_game = content
	elseif name == "sun_wu_kong_challenge_balloon_game" then
		self._sun_wu_kong_challenge_balloon_game = content
	end
end

function SunWuKongChallengeConfig:getActivityCfg(activityId)
	return self._sun_wu_kong_challenge[activityId]
end

function SunWuKongChallengeConfig:getStageInfos(stagePlanId)
	return self._sun_wu_kong_challenge_stage[stagePlanId]
end

function SunWuKongChallengeConfig:getStageCfg(stagePlanId, stageId)
	return self._sun_wu_kong_challenge_stage[stagePlanId][stageId]
end

function SunWuKongChallengeConfig:getHiddendTaskInfo(hiddenTaskId)
	return self._sun_wu_kong_challenge_hidden_task[hiddenTaskId]
end

function SunWuKongChallengeConfig:getMasterTeamCfg(creepsMasterId)
	return self._sun_wu_kong_challenge_master[creepsMasterId]
end

function SunWuKongChallengeConfig:getCreepsCfg(creepsMasterId)
	return self._sun_wu_kong_challenge_creeps[creepsMasterId]
end

function SunWuKongChallengeConfig:getBalloonGameCfg(planId)
	if self._sun_wu_kong_challenge_balloon_game then
		local list = table.values(self._sun_wu_kong_challenge_balloon_game[planId])

		table.sort(list, function(a, b)
			return a.scale < b.scale
		end)

		return list
	end

	return {}
end

function SunWuKongChallengeConfig:getFlipGameCfg(planId)
	return self._sun_wu_kong_challenge_flip_game[planId]
end

function SunWuKongChallengeConfig:getHiddenPrize(prizePlanId)
	return self._sun_wu_kong_challenge_prize[prizePlanId]
end

function SunWuKongChallengeConfig:getCimeliaCfgs(cimeliaPlanId)
	return self._sun_wu_kong_challenge_cimelia[cimeliaPlanId]
end

function SunWuKongChallengeConfig:getCimeliaCfg(cimeliaPlanId, cimeliaId)
	return self._sun_wu_kong_challenge_cimelia[cimeliaPlanId][cimeliaId]
end

function SunWuKongChallengeConfig:getCimeliaBuffCfg(cimeliaBuffPlanId)
	return self._susun_wu_kong_challenge_cimelia_buff[cimeliaBuffPlanId]
end

function SunWuKongChallengeConfig:getCimeliaLevelCfg(cimeliaLevelPlanId)
	return self._sun_wu_kong_challenge_cimelia_level[cimeliaLevelPlanId]
end

SunWuKongChallengeConfig.instance = SunWuKongChallengeConfig.New()

return SunWuKongChallengeConfig
