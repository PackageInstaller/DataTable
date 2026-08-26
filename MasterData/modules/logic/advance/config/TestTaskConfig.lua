-- chunkname: @modules/logic/advance/config/TestTaskConfig.lua

module("modules.logic.advance.config.TestTaskConfig", package.seeall)

local TestTaskConfig = class("TestTaskConfig", BaseConfig)

function TestTaskConfig:ctor()
	self._taskConfigs = nil
end

function TestTaskConfig:reqConfigNames()
	return {
		"test_server_task"
	}
end

function TestTaskConfig:onConfigLoaded(configName, configTable)
	self._taskConfigs = configTable
end

function TestTaskConfig:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for _, v in pairs(self._taskConfigs.configDict) do
		table.insert(self._task_list, v)
	end

	return self._task_list
end

TestTaskConfig.instance = TestTaskConfig.New()

return TestTaskConfig
