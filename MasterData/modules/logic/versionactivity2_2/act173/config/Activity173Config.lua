-- chunkname: @modules/logic/versionactivity2_2/act173/config/Activity173Config.lua

module("modules.logic.versionactivity2_2.act173.config.Activity173Config", package.seeall)

local Activity173Config = class("Activity173Config", BaseConfig)

function Activity173Config:onInit()
	self._taskCfg = nil
end

function Activity173Config:reqConfigNames()
	return {
		"activity173_task",
		"act173_global_task"
	}
end

function Activity173Config:onConfigLoaded(configName, configTable)
	if configName == "activity173_task" then
		self._taskCfg = configTable
	elseif configName == "act173_global_task" then
		self._globalTaskCo = configTable
	end
end

function Activity173Config:getTaskConfig(taskId)
	return self._taskCfg.configDict[taskId]
end

function Activity173Config:getAllOnlineTasks()
	local taskCos = {}

	for _, taskCo in ipairs(self._taskCfg.configList) do
		if taskCo.isOnline == 1 then
			table.insert(taskCos, taskCo)
		end
	end

	table.sort(taskCos, self.onlineTaskSortFunc)

	return taskCos
end

function Activity173Config.onlineTaskSortFunc(aTaskCo, bTaskCo)
	if aTaskCo.sortId ~= bTaskCo.sortId then
		return aTaskCo.sortId < bTaskCo.sortId
	end

	return aTaskCo.id < bTaskCo.id
end

function Activity173Config:getGlobalTaskStages()
	return self._globalTaskCo and self._globalTaskCo.configList
end

function Activity173Config:getGlobalVisibleTaskStages()
	local stages = {}

	for _, stageCo in ipairs(self._globalTaskCo.configList) do
		if stageCo.isVisible == 1 then
			table.insert(stages, stageCo)
		end
	end

	return stages
end

function Activity173Config:getGlobalVisibleTaskStagesByActId(actId)
	local list = {}

	for _, stageCo in ipairs(self._globalTaskCo.configList) do
		if stageCo.activityId == actId then
			table.insert(list, stageCo)
		end
	end

	return list
end

Activity173Config.instance = Activity173Config.New()

return Activity173Config
