-- chunkname: @modules/logic/versionactivity/config/VersionActivityConfig.lua

module("modules.logic.versionactivity.config.VersionActivityConfig", package.seeall)

local VersionActivityConfig = class("VersionActivityConfig", BaseConfig)

function VersionActivityConfig:reqConfigNames()
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame",
		"version_activity_puzzle_question",
		"activity112_task",
		"activity112",
		"activity113_task",
		"activity113_dungeon",
		"activity105"
	}
end

function VersionActivityConfig:onInit()
	self.activityId2TaskCountDict = {}
	self.activityId2TaskConfigList = {}
end

function VersionActivityConfig:onConfigLoaded(configName, configTable)
	if configName == "activity112_task" then
		self._activity112TaskConfig = configTable
	elseif configName == "activity112" then
		self._activity112Config = configTable
	end
end

function VersionActivityConfig:getAct112Config(actid)
	return self._activity112Config.configDict[actid]
end

function VersionActivityConfig:getActTaskDicConfig(actid)
	if self._activity112TaskConfig.configDict[actid] then
		return self._activity112TaskConfig.configDict[actid]
	end
end

function VersionActivityConfig:getTaskConfig(actid, taskId)
	if self._activity112TaskConfig.configDict[actid] then
		return self._activity112TaskConfig.configDict[actid][taskId]
	end
end

function VersionActivityConfig:getAct113TaskCount(actId)
	if self.activityId2TaskCountDict[actId] then
		return self.activityId2TaskCountDict[actId]
	end

	local count = 0

	for _, config in ipairs(lua_activity113_task.configList) do
		if config.activityId == actId and config.isOnline == 1 then
			count = count + 1
		end
	end

	self.activityId2TaskCountDict[actId] = count

	return self.activityId2TaskCountDict[actId]
end

function VersionActivityConfig:getAct113TaskList(actId)
	if self.activityId2TaskConfigList[actId] then
		return self.activityId2TaskConfigList[actId]
	end

	local configList = {}

	for _, config in ipairs(lua_activity113_task.configList) do
		if config.activityId == actId then
			table.insert(configList, config)
		end
	end

	self.activityId2TaskConfigList[actId] = configList

	return self.activityId2TaskConfigList[actId]
end

function VersionActivityConfig:getAct113TaskConfig(id)
	return lua_activity113_task.configDict[id]
end

function VersionActivityConfig:getAct113DungeonChapterIsOpen(chapterId)
	local dungeonCo = lua_activity113_dungeon.configDict[chapterId]

	if not dungeonCo then
		return true
	end

	local status = ActivityHelper.getActivityStatus(dungeonCo.activityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[dungeonCo.activityId]
	local chapterOpenTimeStamp = actInfoMo:getRealStartTimeStamp() + (dungeonCo.openDay - 1) * TimeUtil.OneDaySecond

	return ServerTime.now() - chapterOpenTimeStamp >= 0
end

function VersionActivityConfig:getAct113DungeonChapterOpenTimeStamp(chapterId)
	local dungeonCo = lua_activity113_dungeon.configDict[chapterId]
	local actInfoMo = ActivityModel.instance:getActivityInfo()[dungeonCo.activityId]

	return actInfoMo:getRealStartTimeStamp() + (dungeonCo.openDay - 1) * TimeUtil.OneDaySecond
end

VersionActivityConfig.instance = VersionActivityConfig.New()

return VersionActivityConfig
