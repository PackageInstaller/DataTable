-- chunkname: @modules/logic/achievement/config/AchievementConfig.lua

module("modules.logic.achievement.config.AchievementConfig", package.seeall)

local AchievementConfig = class("AchievementConfig", BaseConfig)

function AchievementConfig:ctor()
	self._achievementConfig = nil
	self._achievementGroupConfig = nil
	self._achievementTaskConfig = nil
	self._gameCenterConfig = nil
end

function AchievementConfig:reqConfigNames()
	return {
		"achievement",
		"achievement_group",
		"achievement_task",
		"achievement_gmcenter"
	}
end

function AchievementConfig:onConfigLoaded(configName, configTable)
	if configName == "achievement" then
		self:buildAchievementCfgs(configTable)
	elseif configName == "achievement_group" then
		self._achievementGroupConfig = configTable
	elseif configName == "achievement_task" then
		self._achievementTaskConfig = configTable

		self:initAchievementTask()
	elseif configName == "achievement_gmcenter" then
		self._gameCenterConfig = configTable
	end
end

function AchievementConfig:buildAchievementCfgs(configTable)
	self._achievementConfig = configTable

	self:initAchievementStateDict()
end

function AchievementConfig:initAchievementStateDict()
	self._achievementState = {}
	self._waitOnlineList = {}
	self._waitOfflineList = {}

	for _, achievementState in pairs(AchievementEnum.AchievementState) do
		self._achievementState[achievementState] = {}
	end
end

function AchievementConfig:initWaitAchievements()
	self:initAchievementStateDict()

	for _, config in ipairs(self._achievementConfig.configList) do
		local achievementState, isReadyOnline, isReadyOffline = self:checkAchievementState(config)

		table.insert(self._achievementState[achievementState], config)

		if isReadyOnline then
			table.insert(self._waitOnlineList, config)
		end

		if isReadyOffline then
			table.insert(self._waitOfflineList, config)
		end
	end
end

function AchievementConfig:checkAchievementState(achievementCfg)
	local startTime = achievementCfg.startTime
	local endTime = achievementCfg.endTime
	local leftSec, rightSec

	if not string.nilorempty(startTime) then
		leftSec = TimeUtil.stringToTimestamp(startTime) + ServerTime.clientToServerOffset()
		leftSec = leftSec - ServerTime.now()
	end

	if not string.nilorempty(endTime) then
		rightSec = TimeUtil.stringToTimestamp(endTime) + ServerTime.clientToServerOffset()
		rightSec = rightSec - ServerTime.now()
	end

	if leftSec and rightSec and rightSec <= leftSec then
		logError("成就下架时间不可早于或等于成就上架时间,成就id = " .. achievementCfg.id)
	end

	local isReadyOnline = leftSec and leftSec > 0
	local isReadyOffline = rightSec and rightSec > 0

	return (isReadyOnline or rightSec and rightSec < 0 or nil) and AchievementEnum.AchievementState.Offline, isReadyOnline, isReadyOffline
end

function AchievementConfig:initAchievementTask()
	self._taskFirstLevelDict = {}

	for i, taskCO in ipairs(self._achievementTaskConfig.configList) do
		if not self._taskFirstLevelDict[taskCO.achievementId] then
			local targetCo = taskCO

			if self._taskFirstLevelDict[taskCO.achievementId] and self._taskFirstLevelDict[taskCO.achievementId].level > taskCO.level then
				targetCo = taskCO
			end

			self._taskFirstLevelDict[taskCO.achievementId] = self._taskFirstLevelDict[taskCO.achievementId]
		end
	end
end

function AchievementConfig:getAchievement(achievementId)
	return self._achievementConfig.configDict[achievementId]
end

function AchievementConfig:getTask(taskId)
	return self._achievementTaskConfig.configDict[taskId]
end

function AchievementConfig:getGroup(groupId)
	return self._achievementGroupConfig.configDict[groupId]
end

function AchievementConfig:getGroupName(groupId)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if not groupCfg then
		return luaLang(AchievementEnum.SpGroupNameLangId[groupId])
	end

	return groupCfg and groupCfg.name
end

function AchievementConfig:getAchievementFirstTask(achievementId)
	return self._taskFirstLevelDict[achievementId]
end

function AchievementConfig:getTaskByAchievementLevel(achievementId, level)
	for i, taskCO in ipairs(self._achievementTaskConfig.configList) do
		if taskCO.achievementId == achievementId and taskCO.level == level then
			return taskCO
		end
	end

	return nil
end

function AchievementConfig:getAchievementMaxLevelTask(achievementId)
	local taskList = {}

	for _, taskCO in ipairs(self._achievementTaskConfig.configList) do
		if taskCO.achievementId == achievementId then
			table.insert(taskList, taskCO)
		end
	end

	table.sort(taskList, self.achievementTaskSortFuncByLevel)

	return taskList[1]
end

function AchievementConfig.achievementTaskSortFuncByLevel(a, b)
	if a.level ~= b.level then
		return a.level > b.level
	end

	return a.id < b.id
end

function AchievementConfig:getAchievementsByGroupId(groupId, sortFunc)
	local result = {}

	for i, achievementCO in ipairs(self._achievementConfig.configList) do
		if achievementCO.groupId == groupId then
			table.insert(result, achievementCO)
		end
	end

	sortFunc = sortFunc or AchievementConfig.achievmentSortFuncInGroup

	table.sort(result, sortFunc)

	return result
end

function AchievementConfig.achievmentSortFuncInGroup(a, b)
	if a.order ~= b.order then
		return a.order < b.order
	else
		return a.id < b.id
	end
end

function AchievementConfig:getTasksByAchievementId(achievementId)
	local result = {}

	for _, taskCO in ipairs(self._achievementTaskConfig.configList) do
		if taskCO.achievementId == achievementId then
			table.insert(result, taskCO)
		end
	end

	return result
end

function AchievementConfig:getAllAchievements()
	return self._achievementConfig.configList
end

function AchievementConfig:getOnlineAchievements()
	return self._achievementState[AchievementEnum.AchievementState.Online]
end

function AchievementConfig:getAllTasks()
	return self._achievementTaskConfig.configList
end

function AchievementConfig:getCategoryAchievementMap()
	local infoDict = {}

	for category, v in ipairs(AchievementEnum.Type) do
		infoDict[category] = {}
	end

	local allCfgList = self:getOnlineAchievements()

	if allCfgList then
		for _, cfg in ipairs(allCfgList) do
			infoDict[cfg.category] = infoDict[cfg.category] or {}

			local list = infoDict[cfg.category]

			table.insert(list, cfg)
		end
	end

	return infoDict
end

function AchievementConfig:getGroupBgUrl(groupId, paramType, isUpgrade)
	local editorParam = self:getGroupEditConfigData(groupId, paramType)

	if editorParam then
		return (isUpgrade or nil) and (editorParam.groupUpgradeBgUrl or editorParam.groupNormalBgUrl)
	end
end

function AchievementConfig:getAchievementPosAndScaleInGroup(groupId, index, paramType)
	local editorParam = self:getGroupEditConfigData(groupId, paramType)

	if editorParam and editorParam.id[index] then
		return editorParam.pX[index], editorParam.pY[index], editorParam.sX[index], editorParam.sY[index]
	end
end

function AchievementConfig:getGroupTitleColorConfig(groupId, paramType)
	local editorParam = self:getGroupEditConfigData(groupId, paramType)

	if editorParam and editorParam.groupTitleColor then
		return editorParam.groupTitleColor
	end
end

function AchievementConfig:getGroupParamIdTab(groupId, paramType)
	local editorParam = self:getGroupEditConfigData(groupId, paramType)

	if editorParam and editorParam.id then
		return editorParam.id
	end
end

function AchievementConfig:getGroupEditConfigData(groupId, paramType)
	self._groupParamTab = self._groupParamTab or {}
	self._groupParamTab[groupId] = self._groupParamTab[groupId] or {}

	if not self._groupParamTab[groupId][paramType] then
		local groupCfg = self:getGroup(groupId)

		if paramType == AchievementEnum.GroupParamType.List then
			if not string.nilorempty(groupCfg.uiListParam) then
				self._groupParamTab[groupId][paramType] = cjson.decode(groupCfg.uiListParam)
			end
		elseif paramType == AchievementEnum.GroupParamType.Player and not string.nilorempty(groupCfg.uiPlayerParam) then
			self._groupParamTab[groupId][paramType] = cjson.decode(groupCfg.uiPlayerParam)
		end
	end

	return self._groupParamTab[groupId][paramType]
end

function AchievementConfig:getWaitOnlineAchievementList()
	return self._waitOnlineList
end

function AchievementConfig:getWaitOfflineAchievementList()
	return self._waitOfflineList
end

function AchievementConfig:getStateAchievement(achievementState)
	return self._achievementState and self._achievementState[achievementState]
end

function AchievementConfig:updateAchievementStateInternal(achievementCfg, originState, targetState)
	local originStateList = self:getStateAchievement(originState)

	if originStateList then
		tabletool.removeValue(originStateList, achievementCfg)
	end

	local targetStateList = self:getStateAchievement(targetState)

	table.insert(targetStateList, achievementCfg)
end

function AchievementConfig:onAchievementArriveOnlineTime(achievementId)
	local achievementCfg = self:getAchievement(achievementId)

	self:updateAchievementStateInternal(achievementCfg, AchievementEnum.AchievementState.Offline, AchievementEnum.AchievementState.Online)
	tabletool.removeValue(self._waitOnlineList, achievementCfg)
end

function AchievementConfig:onAchievementArriveOfflineTime(achievementId)
	local achievementCfg = self:getAchievement(achievementId)

	self:updateAchievementStateInternal(achievementCfg, AchievementEnum.AchievementState.Online, AchievementEnum.AchievementState.Offline)
	tabletool.removeValue(self._waitOfflineList, achievementCfg)
end

function AchievementConfig:getGameCenterCfgList()
	return self._gameCenterConfig and self._gameCenterConfig.configList
end

AchievementConfig.instance = AchievementConfig.New()

return AchievementConfig
