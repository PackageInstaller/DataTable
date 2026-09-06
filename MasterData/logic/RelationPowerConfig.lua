-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/config/RelationPowerConfig.lua

module("logic.extensions.relationpower.config.RelationPowerConfig", package.seeall)

local RelationPowerConfig = class("RelationPowerConfig", BaseConfig)

function RelationPowerConfig:onInit()
	RelationPowerConfig.super.onInit(self)
end

function RelationPowerConfig:getNames()
	return {
		"relation_power_activity",
		"relation_power_form",
		"relation_power_task",
		"relation_power_form_verify_desc"
	}
end

function RelationPowerConfig:handleConfig(name, content)
	if name == "relation_power_activity" then
		-- block empty
	elseif name == "relation_power_form" then
		self._formCfgs = content
	elseif name == "relation_power_task" then
		self._taskCfgs = content
	elseif name == "relation_power_form_verify_desc" then
		self._raceGotoCfgs = content
	end
end

function RelationPowerConfig:getFormCfgsByActId(actId)
	return self._formCfgs[actId]
end

function RelationPowerConfig:getFormCfgByFormId(actId, fromId)
	local fromCfgs = self:getFormCfgsByActId(actId)

	return fromCfgs and fromCfgs[fromId]
end

function RelationPowerConfig:getGotoCfgByRaceId(actId, raceId)
	return self._raceGotoCfgs[actId] and self._raceGotoCfgs[actId][raceId]
end

function RelationPowerConfig:getTaskCfgs(actId)
	return self._taskCfgs[actId]
end

RelationPowerConfig.instance = RelationPowerConfig.New()

return RelationPowerConfig
