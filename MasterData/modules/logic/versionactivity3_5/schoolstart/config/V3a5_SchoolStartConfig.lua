-- chunkname: @modules/logic/versionactivity3_5/schoolstart/config/V3a5_SchoolStartConfig.lua

module("modules.logic.versionactivity3_5.schoolstart.config.V3a5_SchoolStartConfig", package.seeall)

local V3a5_SchoolStartConfig = class("V3a5_SchoolStartConfig", BaseConfig)

function V3a5_SchoolStartConfig:reqConfigNames()
	return {
		"activity228",
		"activity228_reward",
		"activity228_task"
	}
end

function V3a5_SchoolStartConfig:onInit()
	self._config = {}
	self._rewardConfig = {}
	self._taskDict = {}
end

function V3a5_SchoolStartConfig:onConfigLoaded(configName, configTable)
	if configName == "activity228" then
		self._config = configTable
	elseif configName == "activity228_reward" then
		self._rewardConfig = configTable
	elseif configName == "activity228_task" then
		self._taskDict = configTable
	end
end

function V3a5_SchoolStartConfig:get228ConfigById(actId)
	return self._config.configDict[actId]
end

function V3a5_SchoolStartConfig:getRewardConfigById(rewardId)
	return self._rewardConfig.configDict[rewardId]
end

function V3a5_SchoolStartConfig:getTaskList()
	if self._taskDict then
		return self._taskDict
	end
end

V3a5_SchoolStartConfig.instance = V3a5_SchoolStartConfig.New()

return V3a5_SchoolStartConfig
