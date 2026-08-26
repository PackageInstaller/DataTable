-- chunkname: @modules/logic/versionactivity3_1/towerdeep/config/TowerDeepOperActConfig.lua

module("modules.logic.versionactivity3_1.towerdeep.config.TowerDeepOperActConfig", package.seeall)

local TowerDeepOperActConfig = class("TowerDeepOperActConfig", BaseConfig)

function TowerDeepOperActConfig:ctor()
	self._taskConfig = nil
end

function TowerDeepOperActConfig:reqConfigNames()
	return {
		"activity209_task"
	}
end

function TowerDeepOperActConfig:onConfigLoaded(configName, configTable)
	if configName == "activity209_task" then
		self._taskConfig = configTable
	end
end

function TowerDeepOperActConfig:getTaskCO(taskId)
	return self._taskConfig.configDict[taskId]
end

function TowerDeepOperActConfig:getTaskCos()
	return self._taskConfig.configDict
end

TowerDeepOperActConfig.instance = TowerDeepOperActConfig.New()

return TowerDeepOperActConfig
