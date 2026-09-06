-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/LongnvConfig.lua

module("logic.extensions.timelimitedchallenge.config.LongnvConfig", package.seeall)

local LongnvConfig = class("LongnvConfig", BaseConfig)

function LongnvConfig:getNames()
	return {
		"long_nv_challenge_buy_times",
		"long_nv_challenge_common",
		"long_nv_challenge_creeps",
		"long_nv_challenge_monster",
		"long_nv_challenge_plan",
		"long_nv_challenge_type"
	}
end

function LongnvConfig:handleConfig(name, content)
	if name == "long_nv_challenge_common" then
		self._commonCfg = content
	elseif name == "long_nv_challenge_monster" then
		self._monsterCfg = content
	elseif name == "long_nv_challenge_creeps" then
		self._creepsCfg = content
	elseif name == "long_nv_challenge_buy_times" then
		self._timesCfg = content
	elseif name == "long_nv_challenge_plan" then
		self._plan_config = content
	elseif name == "long_nv_challenge_type" then
		self._type_config = content
	end
end

function LongnvConfig:getCommonValue(id)
	if self._commonCfg[id] then
		return self._commonCfg[id].value
	end
end

function LongnvConfig:getTimeCount()
	if self._timesCfg then
		return #self._timesCfg.dataList
	end

	return 0
end

function LongnvConfig:getTimeCfg(id)
	if self._timesCfg[id] then
		return self._timesCfg[id].consume
	end
end

function LongnvConfig:getPlanCfg(id)
	if self._plan_config[id] then
		return self._plan_config[id]
	end
end

function LongnvConfig:getTypeCfg(id)
	if self._type_config[id] then
		return self._type_config[id]
	end
end

function LongnvConfig:getMonsterListCfg(type, planId)
	if self._monsterCfg[planId] then
		return self._monsterCfg[planId][type]
	end
end

function LongnvConfig:getCreepsCfg(creepsMasterId)
	if self._creepsCfg[creepsMasterId] then
		return self._creepsCfg[creepsMasterId]
	end
end

LongnvConfig.instance = LongnvConfig.New()

return LongnvConfig
