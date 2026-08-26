-- chunkname: @modules/logic/roleactivity/config/RoleActivityConfig.lua

module("modules.logic.roleactivity.config.RoleActivityConfig", package.seeall)

local RoleActivityConfig = class("RoleActivityConfig", BaseConfig)

function RoleActivityConfig:ctor()
	return
end

function RoleActivityConfig:reqConfigNames()
	return {
		"roleactivity_enter",
		"role_activity_task"
	}
end

function RoleActivityConfig:onConfigLoaded(configName, configTable)
	if configName == "roleactivity_enter" then
		self._enterConfig = configTable
	elseif configName == "role_activity_task" then
		self._taskConfig = configTable

		self:_rebuildTaskConfig()
	end
end

function RoleActivityConfig:_rebuildTaskConfig()
	self._taskDic = {}

	for _, taskCfg in pairs(self._taskConfig.configList) do
		self._taskDic[taskCfg.id] = taskCfg
	end
end

function RoleActivityConfig:getActivityEnterInfo(activityId)
	return self._enterConfig.configDict[activityId]
end

function RoleActivityConfig:getTaskCo(taskId)
	return self._taskDic[taskId]
end

function RoleActivityConfig:getStoryLevelList(activityId)
	local lvlGroupId = self._enterConfig.configDict[activityId].storyGroupId

	return (DungeonConfig.instance:getChapterEpisodeCOList(lvlGroupId))
end

function RoleActivityConfig:getBattleLevelList(activityId)
	local lvlGroupId = self._enterConfig.configDict[activityId].episodeGroupId
	local fightConfigList = DungeonConfig.instance:getChapterEpisodeCOList(lvlGroupId) or {}

	table.sort(fightConfigList, RoleActivityConfig.SortById)

	return fightConfigList
end

function RoleActivityConfig:getActicityTaskList(activityId)
	return self._taskConfig.configDict[activityId]
end

function RoleActivityConfig.SortById(a, b)
	return a.id < b.id
end

RoleActivityConfig.instance = RoleActivityConfig.New()

return RoleActivityConfig
