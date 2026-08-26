-- chunkname: @modules/logic/act189/config/Activity189Config.lua

module("modules.logic.act189.config.Activity189Config", package.seeall)

local sf = string.format
local ti = table.insert
local Activity189Config = class("Activity189Config", BaseConfig)

function Activity189Config:reqConfigNames()
	return {
		"activity189_const",
		"activity189_mlstring",
		"activity189",
		"activity189_task"
	}
end

function Activity189Config:onConfigLoaded(configName, configTable)
	if configName == "activity189_task" then
		self.__onlineTaskList = nil

		self:__init_activity189_task(configTable)
	end
end

function Activity189Config:__init_activity189_task(configTable)
	if self.__onlineTaskList then
		return self.__onlineTaskList
	end

	local refReadTaskCODict = {}

	if isDebugBuild then
		local source = sf("[logError] 189_运营改版活动.xlsx - export_任务")

		TaskConfig.instance:initReadTaskList(source, refReadTaskCODict, Activity189Enum.TaskTag, configTable)
	else
		TaskConfig.instance:initReadTaskList(nil, refReadTaskCODict, Activity189Enum.TaskTag, configTable)
	end

	self.__onlineTaskList = {}

	for _, taskCO in ipairs(configTable.configList) do
		if taskCO.isOnline then
			ti(self.__onlineTaskList, taskCO)
		end
	end

	self.__readTasksTagTaskCoDict = refReadTaskCODict
end

function Activity189Config:getSettingCO(activityId)
	return lua_activity189.configDict[activityId]
end

function Activity189Config:getBonusList(activityId)
	local CO = self:getSettingCO(activityId)
	local bonus = CO.bonus

	return GameUtil.splitString2(bonus, true) or {}
end

function Activity189Config:getAllTaskList(activityId)
	local list = {}

	for _, taskCO in ipairs(self.__onlineTaskList) do
		if taskCO.activityId == activityId then
			ti(list, taskCO)
		end
	end

	return list
end

function Activity189Config:getTaskCO(id)
	return lua_activity189_task.configDict[id]
end

function Activity189Config:getConstCoById(id)
	return lua_activity189_const.configDict[id]
end

function Activity189Config:getTaskCO_ReadTask(activityId)
	return self.__readTasksTagTaskCoDict[activityId] or {}
end

function Activity189Config:getTaskCO_ReadTask_Tag(activityId, eActivity189Enum_TaskTag)
	local actTable = self:getTaskCO_ReadTask(activityId)

	return actTable[eActivity189Enum_TaskTag]
end

function Activity189Config:getTaskCO_ReadTask_Tag_TaskId(activityId, eActivity189Enum_TaskTag, taskId)
	local tagTable = self:getTaskCO_ReadTask_Tag(activityId, eActivity189Enum_TaskTag)

	return tagTable[taskId]
end

function Activity189Config:getTaskType()
	return TaskEnum.TaskType.Activity189
end

Activity189Config.instance = Activity189Config.New()

return Activity189Config
