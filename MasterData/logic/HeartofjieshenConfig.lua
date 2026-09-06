-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/config/HeartofjieshenConfig.lua

module("logic.extensions.heartofjieshen.config.HeartofjieshenConfig", package.seeall)

local HeartofjieshenConfig = class("HeartofjieshenConfig", BaseConfig)

function HeartofjieshenConfig:onInit()
	return
end

function HeartofjieshenConfig:getNames()
	return {
		"heart_of_jie_shen_clg",
		"heart_of_jie_shen_clg_daily_balance",
		"heart_of_jie_shen_clg_creeps_master",
		"heart_of_jie_shen_clg_creeps",
		"heart_of_jie_shen_clg_common"
	}
end

function HeartofjieshenConfig:handleConfig(name, content)
	if name == "heart_of_jie_shen_clg" then
		self._heart_of_jie_shen_clg = content
	elseif name == "heart_of_jie_shen_clg_daily_balance" then
		self._heart_of_jie_shen_clg_daily_balance = content
	elseif name == "heart_of_jie_shen_clg_creeps_master" then
		self._heart_of_jie_shen_clg_creeps_master = content
	elseif name == "heart_of_jie_shen_clg_creeps" then
		self._heart_of_jie_shen_clg_creeps = content
	elseif name == "heart_of_jie_shen_clg_common" then
		self._heart_of_jie_shen_clg_common = content
	end
end

function HeartofjieshenConfig:getCommonValue(activityId, key)
	local actCfg = self:getActCfg(activityId)

	return (actCfg and actCfg[key] ~= nil or nil) and actCfg[key]
end

function HeartofjieshenConfig:getActCfg(activityId)
	return self._heart_of_jie_shen_clg[activityId]
end

function HeartofjieshenConfig:getRuleKey(activityId, key)
	return self._heart_of_jie_shen_clg[activityId][key]
end

function HeartofjieshenConfig:getCreepsMasterCfgs(activityId)
	local cfg = self:getActCfg(activityId)

	return {
		self._heart_of_jie_shen_clg_creeps_master[cfg.yiCreepsMasterId],
		self._heart_of_jie_shen_clg_creeps_master[cfg.chiCreepsMasterId]
	}
end

function HeartofjieshenConfig:getCreepsMasterCfg(creepsMasterId)
	return self._heart_of_jie_shen_clg_creeps_master[creepsMasterId]
end

function HeartofjieshenConfig:getCreepsCfgs(creepsMasterId)
	return self._heart_of_jie_shen_clg_creeps[creepsMasterId]
end

HeartofjieshenConfig.instance = HeartofjieshenConfig.New()

return HeartofjieshenConfig
