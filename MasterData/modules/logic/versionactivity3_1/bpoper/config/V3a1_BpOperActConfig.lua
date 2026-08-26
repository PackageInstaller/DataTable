-- chunkname: @modules/logic/versionactivity3_1/bpoper/config/V3a1_BpOperActConfig.lua

module("modules.logic.versionactivity3_1.bpoper.config.V3a1_BpOperActConfig", package.seeall)

local V3a1_BpOperActConfig = class("V3a1_BpOperActConfig", BaseConfig)

function V3a1_BpOperActConfig:ctor()
	self._taskConfig = nil
end

function V3a1_BpOperActConfig:reqConfigNames()
	return {
		"activity214_task"
	}
end

function V3a1_BpOperActConfig:onConfigLoaded(configName, configTable)
	if configName == "activity214_task" then
		self._taskConfig = configTable
	end
end

function V3a1_BpOperActConfig:getTaskCO(taskId)
	return self._taskConfig.configDict[taskId]
end

function V3a1_BpOperActConfig:getTaskCos(actId)
	if not actId then
		return self._taskConfig.configDict
	end

	local taskCos = {}

	for _, taskCo in pairs(self._taskConfig.configDict) do
		if taskCo.activityId == actId then
			table.insert(taskCos, taskCo)
		end
	end

	return taskCos
end

V3a1_BpOperActConfig.instance = V3a1_BpOperActConfig.New()

return V3a1_BpOperActConfig
