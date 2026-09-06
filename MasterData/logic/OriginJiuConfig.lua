-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/config/OriginJiuConfig.lua

module("logic.extensions.originjiu.config.OriginJiuConfig", package.seeall)

local OriginJiuConfig = class("OriginJiuConfig", BaseConfig)

function OriginJiuConfig:getNames()
	return {
		"origin_jiu_clg_activity",
		"origin_jiu_clg_team",
		"origin_jiu_clg_stage",
		"origin_jiu_clg_model",
		"origin_jiu_clg_phase",
		"origin_jiu_clg_creeps",
		"origin_jiu_clg_buff"
	}
end

function OriginJiuConfig:handleConfig(name, content)
	if name == "origin_jiu_clg_activity" then
		self._origin_jiu_clg_activity = content
	elseif name == "origin_jiu_clg_team" then
		self._origin_jiu_clg_team = content
	elseif name == "origin_jiu_clg_stage" then
		self._origin_jiu_clg_stage = content
	elseif name == "origin_jiu_clg_model" then
		self._origin_jiu_clg_model = content
	elseif name == "origin_jiu_clg_phase" then
		self._origin_jiu_clg_phase = content
	elseif name == "origin_jiu_clg_creeps" then
		self._origin_jiu_clg_creeps = content
	elseif name == "origin_jiu_clg_buff" then
		self._origin_jiu_clg_buff = content
	end
end

function OriginJiuConfig:getStageListCfgById(activityId, modelId, phaseId)
	if self._origin_jiu_clg_stage[activityId] and self._origin_jiu_clg_stage[activityId][modelId] then
		return self._origin_jiu_clg_stage[activityId][modelId][phaseId]
	end
end

function OriginJiuConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function OriginJiuConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function OriginJiuConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_jiu_clg_activity, activityId)
end

function OriginJiuConfig:getTeamData(creepsMasterId)
	return self:_safeGet(self._origin_jiu_clg_team, creepsMasterId)
end

function OriginJiuConfig:getModelDatas(activityId)
	return self:_safeGet(self._origin_jiu_clg_model, activityId)
end

function OriginJiuConfig:getModelData(activityId, modelId)
	return self:_safeGet(self._origin_jiu_clg_model, activityId, modelId)
end

function OriginJiuConfig:getPhaseDatas(activityId, modelId)
	return self:_safeGet(self._origin_jiu_clg_phase, activityId, modelId)
end

function OriginJiuConfig:getPhaseData(activityId, modelId, phaseId)
	return self:_safeGet(self._origin_jiu_clg_phase, activityId, modelId, phaseId)
end

function OriginJiuConfig:getStageDatass(activityId, modelId)
	return self:_safeGet(self._origin_jiu_clg_stage, activityId, modelId)
end

function OriginJiuConfig:getStageDatas(activityId, modelId, phaseId)
	return self:_safeGet(self._origin_jiu_clg_stage, activityId, modelId, phaseId)
end

function OriginJiuConfig:getStageData(activityId, modelId, phaseId, stageId)
	return self:_safeGet(self._origin_jiu_clg_stage, activityId, modelId, phaseId, stageId)
end

function OriginJiuConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_jiu_clg_creeps, creepsMasterId)
end

function OriginJiuConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_jiu_clg_creeps, creepsMasterId, creepsId)
end

function OriginJiuConfig:getBuffDatas(activityId)
	return self:_safeGet(self._origin_jiu_clg_buff, activityId)
end

function OriginJiuConfig:getBuffData(activityId, buffId)
	return self:_safeGet(self._origin_jiu_clg_buff, activityId, buffId)
end

OriginJiuConfig.instance = OriginJiuConfig.New()

return OriginJiuConfig
