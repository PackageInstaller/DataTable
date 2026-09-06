-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/config/YinZhiClgConfig.lua

module("logic.extensions.yinzhiclg.config.YinZhiClgConfig", package.seeall)

local YinZhiClgConfig = class("YinZhiClgConfig", BaseConfig)

function YinZhiClgConfig:getNames()
	return {
		"yin_zhi_clg_stage",
		"yin_zhi_clg_creeps",
		"yin_zhi_clg_creeps_master",
		"yin_zhi_clg_phase",
		"yin_zhi_clg_activity"
	}
end

function YinZhiClgConfig:handleConfig(name, content)
	if name == "yin_zhi_clg_stage" then
		self._yin_zhi_clg_stage = content
	elseif name == "yin_zhi_clg_creeps" then
		self._yin_zhi_clg_creeps = content
	elseif name == "yin_zhi_clg_creeps_master" then
		self._yin_zhi_clg_creeps_master = content
	elseif name == "yin_zhi_clg_phase" then
		self._yin_zhi_clg_phase = content
	elseif name == "yin_zhi_clg_activity" then
		self._yin_zhi_clg_activity = content
	end
end

function YinZhiClgConfig:getActCfgById(actId)
	return self._yin_zhi_clg_activity[actId]
end

function YinZhiClgConfig:getPhaseCfgsById(actId)
	return self._yin_zhi_clg_phase[actId]
end

function YinZhiClgConfig:getPhaseCfgByPhaseId(actId, phaseId)
	if self._yin_zhi_clg_phase[actId] then
		return self._yin_zhi_clg_phase[actId][phaseId]
	end
end

function YinZhiClgConfig:getStageCfgs(actId, phaseId)
	if self._yin_zhi_clg_stage[actId] then
		return self._yin_zhi_clg_stage[actId][phaseId]
	end
end

function YinZhiClgConfig:getCreepCfgs(creepsMasterId)
	return self._yin_zhi_clg_creeps[creepsMasterId]
end

function YinZhiClgConfig:getTeamCfg(creepsMasterId)
	return self._yin_zhi_clg_creeps_master[creepsMasterId]
end

YinZhiClgConfig.instance = YinZhiClgConfig.New()

return YinZhiClgConfig
