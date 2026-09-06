-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/config/FanTianChallengeConfig.lua

module("logic.extensions.fantian.config.FanTianChallengeConfig", package.seeall)

local FanTianChallengeConfig = class("FanTianChallengeConfig", BaseConfig)

function FanTianChallengeConfig:getNames()
	return {
		"fan_tian_clg_activity",
		"fan_tian_clg_progress",
		"fan_tian_clg_stage",
		"fan_tian_clg_monster",
		"fan_tian_clg_creeps",
		"fan_tian_clg_common"
	}
end

function FanTianChallengeConfig:handleConfig(name, content)
	if name == "fan_tian_clg_activity" then
		self._fan_tian_clg_activity = content
	elseif name == "fan_tian_clg_progress" then
		self._fan_tian_clg_progress = content
	elseif name == "fan_tian_clg_stage" then
		self._fan_tian_clg_stage = content
	elseif name == "fan_tian_clg_monster" then
		self._fan_tian_clg_monster = content
	elseif name == "fan_tian_clg_creeps" then
		self._fan_tian_clg_creeps = content
	elseif name == "fan_tian_clg_common" then
		self.fan_tian_clg_common = content
	end
end

function FanTianChallengeConfig:getCommonCfgByKey(key, isToNumber)
	if self.fan_tian_clg_common[key] then
		local value = self.fan_tian_clg_common[key].value

		if isToNumber then
			return checknumber(value)
		else
			return value
		end
	end

	return ""
end

function FanTianChallengeConfig:getActivityCfgById(activityId)
	return self._fan_tian_clg_activity[activityId]
end

function FanTianChallengeConfig:getProgressCfgList(activityId)
	return self._fan_tian_clg_progress[activityId]
end

function FanTianChallengeConfig:getProgressCfgById(activityId, id)
	if self._fan_tian_clg_progress[activityId] then
		return self._fan_tian_clg_progress[activityId][id]
	end
end

function FanTianChallengeConfig:getStageCfgList(activityId)
	return self._fan_tian_clg_stage[activityId]
end

function FanTianChallengeConfig:getStageTierList(activityId, tierId)
	if self._fan_tian_clg_stage[activityId] then
		return self._fan_tian_clg_stage[activityId][tierId]
	end
end

function FanTianChallengeConfig:getStageCfgById(activityId, tierId, stageId)
	if self._fan_tian_clg_stage[activityId] and self._fan_tian_clg_stage[activityId][tierId] then
		return self._fan_tian_clg_stage[activityId][tierId][stageId]
	end
end

function FanTianChallengeConfig:getMonsterCfgById(id)
	return self._fan_tian_clg_monster[id]
end

function FanTianChallengeConfig:getCreepsCfgById(id)
	return self._fan_tian_clg_creeps[id]
end

FanTianChallengeConfig.instance = FanTianChallengeConfig.New()

return FanTianChallengeConfig
