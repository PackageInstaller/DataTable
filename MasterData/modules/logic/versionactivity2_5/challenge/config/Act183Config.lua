-- chunkname: @modules/logic/versionactivity2_5/challenge/config/Act183Config.lua

module("modules.logic.versionactivity2_5.challenge.config.Act183Config", package.seeall)

local Act183Config = class("Act183Config", BaseConfig)

function Act183Config:reqConfigNames()
	return {
		"challenge_episode",
		"challenge_daily_unlock",
		"challenge_condition",
		"challenge_badge",
		"challenge_task",
		"challenge_const"
	}
end

function Act183Config:onConfigLoaded(configName, configTable)
	if configName == "challenge_episode" then
		self:_onEpisodeConfigLoaded(configTable)
	elseif configName == "challenge_reward" then
		self:_onRewardConfigsLoad(configTable)
	elseif configName == "challenge_task" then
		self:_onTaskConfigLoaded(configTable)
	end
end

function Act183Config:_onEpisodeConfigLoaded(configTable)
	self._episodeTab = configTable
	self._episodeGroupTab = {}

	for _, episodeCo in ipairs(configTable.configList) do
		local groupId = episodeCo.groupId
		local activityId = episodeCo.activityId
		local actGroupTab = self._episodeGroupTab[activityId]

		if not actGroupTab then
			actGroupTab = {}
			self._episodeGroupTab[activityId] = actGroupTab
		end

		local groupTab = actGroupTab[groupId]

		if not groupTab then
			groupTab = {}
			actGroupTab[groupId] = groupTab
		end

		table.insert(groupTab, episodeCo)
	end
end

function Act183Config:getEpisodeCo(episodeId)
	local episodeCo = self._episodeTab.configDict[episodeId]

	if not episodeCo then
		logError(string.format("关卡配置不存在 episodeId = %s", episodeId))
	end

	return episodeCo
end

function Act183Config:getEpisodeCosByGroupId(activityId, groupId)
	local actGroupTab = self._episodeGroupTab[activityId]
	local groupEpisodeCos = actGroupTab and actGroupTab[groupId]

	if not groupEpisodeCos then
		logError(string.format("关卡组配置不存在 activityId = %s, groupId = %s", activityId, groupId))
	end

	return groupEpisodeCos
end

function Act183Config:isGroupExist(activityId, groupId)
	local episodeCoList = self:getEpisodeCosByGroupId(activityId, groupId)

	return episodeCoList and #episodeCoList > 0
end

function Act183Config:getEpisodeAllRuleDesc(episodeId)
	local ruleDescList = {}
	local rule1Desc = self:getEpisodeRuleDesc(episodeId, 1)
	local rule2Desc = self:getEpisodeRuleDesc(episodeId, 2)

	if not string.nilorempty(rule1Desc) then
		table.insert(ruleDescList, rule1Desc)
	end

	if not string.nilorempty(rule2Desc) then
		table.insert(ruleDescList, rule2Desc)
	end

	return ruleDescList
end

function Act183Config:getEpisodeRuleDesc(episodeId, ruleIndex)
	local episodeCo = self:getEpisodeCo(episodeId)

	if not episodeCo then
		return
	end

	if ruleIndex == 1 then
		return episodeCo.ruleDesc1
	elseif ruleIndex == 2 then
		return episodeCo.ruleDesc2
	else
		logError(string.format("关卡机制序号不存在 episodeId = %s, ruleIndex = %s", episodeId, ruleIndex))
	end
end

function Act183Config:_onRewardConfigsLoad(configTable)
	self._taskTab = configTable
	self._taskChapterTab = {}

	for _, taskCo in ipairs(configTable.configList) do
		local typeTasks = self._taskChapterTab[taskCo.type1]

		if not typeTasks then
			typeTasks = {}
			self._taskChapterTab[taskCo.type1] = typeTasks
		end

		local subTypeTasks = typeTasks[taskCo.type2]

		if not subTypeTasks then
			subTypeTasks = {}
			typeTasks[taskCo.type2] = subTypeTasks
		end

		table.insert(subTypeTasks, taskCo)
	end
end

function Act183Config:getAllTaskByType(taskType)
	local typeTasks = self._taskChapterTab[taskType]

	if not typeTasks then
		logError(string.format("无法找到挑战任务配置! taskType = %s", taskType))
	end

	return typeTasks
end

function Act183Config:getChapterTasks(taskType, subTaskType)
	local typeTasks = self:getAllTaskByType(taskType)
	local subTypeTasks = typeTasks and typeTasks[subTaskType]

	if not subTypeTasks then
		logError(string.format("无法找到挑战任务配置! taskType = %s, subTaskType = %s", taskType, subTaskType))
	end

	return subTypeTasks
end

function Act183Config:getConditionCo(conditionId)
	if lua_challenge_condition then
		if not lua_challenge_condition then
			logError(string.format("战斗条件配置为空 conditionId = %s", conditionId))
		end

		return lua_challenge_condition
	end
end

function Act183Config:getActivityBadgeCos(activityId)
	local activityTab = lua_challenge_badge.configDict[activityId]

	if not activityTab then
		logError(string.format("活动中的神秘刻纹配置为空 activityId = %s", activityId, activityId))
	end

	return activityTab
end

function Act183Config:getBadgeCo(activityId, badgeNum)
	local activityTab = self:getActivityBadgeCos(activityId)
	local badgeCo = activityTab and activityTab[badgeNum]

	if not badgeCo then
		logError(string.format("神秘刻纹配置为空 activityId = %s, badgeNum = %s", activityId, badgeNum))
	end

	return badgeCo
end

function Act183Config:getEpisodeConditions(activityId, episodeId)
	local episodeCo = self:getEpisodeCo(activityId, episodeId)

	if episodeCo then
		return (string.splitToNumber(episodeCo.condition, "#"))
	end
end

function Act183Config:getGroupSubEpisodeConditions(activityId, groupId)
	local groupEpisodeCos = self:getEpisodeCosByGroupId(activityId, groupId)

	if not groupEpisodeCos then
		return
	end

	local conditions = {}

	for _, episodeCo in ipairs(groupEpisodeCos) do
		local episodeType = Act183Helper.getEpisodeType(episodeCo.episodeId)

		if episodeType == Act183Enum.EpisodeType.Sub then
			local episodeConditions = string.splitToNumber(episodeCo.condition, "#")

			tabletool.addValues(conditions, episodeConditions)
		end
	end

	return conditions
end

function Act183Config:_onTaskConfigLoaded(configTable)
	self._taskTab = configTable
	self._taskTypeMap = {}
	self._taskGroupMap = {}

	for _, taskCo in ipairs(configTable.configList) do
		self:_onSingleTaskConfigLoaded(taskCo)
	end
end

function Act183Config:_onSingleTaskConfigLoaded(taskCo)
	local isOnline = taskCo.isOnline == 1

	if not isOnline then
		return
	end

	local activityId = taskCo.activityId
	local activityTasks = self._taskTypeMap[activityId]

	if not activityTasks then
		activityTasks = {}
		self._taskTypeMap[activityId] = activityTasks
	end

	local type = taskCo.type
	local typeTasks = activityTasks[type]

	if not typeTasks then
		typeTasks = {}
		activityTasks[type] = typeTasks
	end

	table.insert(typeTasks, taskCo)

	local actId = taskCo.activityId

	self._taskGroupMap[actId] = self._taskGroupMap[actId] or {}

	local groupId = taskCo.groupId

	self._taskGroupMap[actId][groupId] = self._taskGroupMap[actId][groupId] or {}

	table.insert(self._taskGroupMap[actId][groupId], taskCo)
end

function Act183Config:getAllOnlineTypeTasks(activityId, taskType)
	local activityTasks = self._taskTypeMap[activityId]

	return activityTasks and activityTasks[taskType]
end

function Act183Config:getAllOnlineGroupTasks(actId, groupId)
	if self._taskGroupMap then
		local actTasks = self._taskGroupMap[actId]

		return actTasks and actTasks[groupId]
	end
end

function Act183Config:getTaskConfig(taskId)
	local taskCo = lua_challenge_task.configDict[taskId]

	if not taskCo then
		logError(string.format("任务配置不存在 taskId = %s", taskId))
	end

	return taskCo
end

function Act183Config:getPreEpisodeIds(activityId, episodeId)
	local episodeCo = self:getEpisodeCo(activityId, episodeId)

	if episodeCo and string.nilorempty(episodeCo.preEpisodeIds) then
		return (string.splitToNumber(episodeCo.preEpisodeIds, "#"))
	end
end

function Act183Config:getLeaderSkillDesc(episodeId)
	local episodeCo = self:getEpisodeCo(episodeId)

	return episodeCo and episodeCo.skillDesc
end

function Act183Config:getEpisodeLeaderPosition(episodeId)
	local episodeCo = self:getEpisodeCo(episodeId)

	return (episodeCo or nil) and (episodeCo.leaderPosition or 0)
end

Act183Config.instance = Act183Config.New()

return Act183Config
