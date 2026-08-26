-- chunkname: @modules/logic/versionactivity1_5/dungeon/config/VersionActivity1_5DungeonConfig.lua

module("modules.logic.versionactivity1_5.dungeon.config.VersionActivity1_5DungeonConfig", package.seeall)

local VersionActivity1_5DungeonConfig = class("VersionActivity1_5DungeonConfig", BaseConfig)

function VersionActivity1_5DungeonConfig:ctor()
	return
end

function VersionActivity1_5DungeonConfig:reqConfigNames()
	return {
		"act139_dispatch_task",
		"activity140_building",
		"activity11502_episode_element",
		"act139_explore_task",
		"act139_hero_task",
		"act139_sub_hero_task",
		"activity139_const",
		"activity140_const"
	}
end

function VersionActivity1_5DungeonConfig:onConfigLoaded(configName, configTable)
	if configName == "activity139_const" then
		self.exploreTaskReward = string.splitToNumber(configTable.configDict[1].value, "#")
		self.exploreTaskUnlockEpisodeId = tonumber(configTable.configDict[2].value)
		self.exploreTaskLockToastId = tonumber(configTable.configDict[3].value)
		self.revivalTaskUnlockEpisodeId = tonumber(configTable.configDict[4].value)
		self.revivalTaskLockToastId = tonumber(configTable.configDict[5].value)
	elseif configName == "activity140_const" then
		self.buildReward = string.splitToNumber(configTable.configDict[2].value, "#")
		self.buildUnlockEpisodeId = tonumber(configTable.configDict[3].value)
		self.buildLockToastId = tonumber(configTable.configDict[4].value)
	end
end

function VersionActivity1_5DungeonConfig:initSubHeroTaskCo()
	if self.initedSubHeroTask then
		return
	end

	local metaTable = {}

	function metaTable.__index(t, key)
		local value = rawget(t, key)

		if not value then
			local srcCo = rawget(t, "srcCo")

			value = srcCo[key]
		end

		return value
	end

	self.taskId2SubTaskListDict = {}
	self.subHeroTaskElementIdDict = {}

	for _, heroTaskCo in ipairs(lua_act139_sub_hero_task.configList) do
		local taskList = self.taskId2SubTaskListDict[heroTaskCo.taskId]

		if not taskList then
			taskList = {}
			self.taskId2SubTaskListDict[heroTaskCo.taskId] = taskList
		end

		local newTaskCo = {}

		setmetatable(newTaskCo, metaTable)

		newTaskCo.elementList = string.splitToNumber(heroTaskCo.elementIds, "#")
		newTaskCo.srcCo = heroTaskCo
		newTaskCo.id = heroTaskCo.id

		table.insert(taskList, newTaskCo)

		for _, elementId in ipairs(newTaskCo.elementList) do
			self.subHeroTaskElementIdDict[elementId] = newTaskCo
		end
	end

	for _, taskList in ipairs(self.taskId2SubTaskListDict) do
		table.sort(taskList, function(a, b)
			return a.id < b.id
		end)
	end
end

function VersionActivity1_5DungeonConfig:getDispatchCo(dispatchId)
	return lua_act139_dispatch_task.configDict[dispatchId]
end

function VersionActivity1_5DungeonConfig:initExploreTaskCo()
	if self.initedExploreTask then
		return
	end

	self.exploreTaskCoDict = {}
	self.exploreTaskCoList = {}
	self.elementId2ExploreCoDict = {}
	self.initedExploreTask = true

	local metaTable = {}

	function metaTable.__index(t, key)
		local value = rawget(t, key)

		if not value then
			local srcCo = rawget(t, "srcCo")

			value = srcCo[key]
		end

		return value
	end

	for _, taskCo in ipairs(lua_act139_explore_task.configList) do
		local newCo = {}

		setmetatable(newCo, metaTable)

		newCo.srcCo = taskCo
		newCo.elementList = string.splitToNumber(taskCo.elementIds, "#")

		local areaPosList = string.splitToNumber(taskCo.areaPos, "#")

		newCo.areaPosX = areaPosList[1]
		newCo.areaPosY = areaPosList[2]

		table.insert(self.exploreTaskCoList, newCo)

		self.exploreTaskCoDict[taskCo.id] = newCo

		for _, elementId in ipairs(newCo.elementList) do
			self.elementId2ExploreCoDict[elementId] = newCo
		end
	end
end

function VersionActivity1_5DungeonConfig:getExploreTaskList()
	self:initExploreTaskCo()

	return self.exploreTaskCoList
end

function VersionActivity1_5DungeonConfig:getExploreTask(exploreId)
	self:initExploreTaskCo()

	return self.exploreTaskCoDict[exploreId]
end

function VersionActivity1_5DungeonConfig:getExploreTaskByElementId(elementId)
	self:initExploreTaskCo()

	return self.elementId2ExploreCoDict[elementId]
end

function VersionActivity1_5DungeonConfig:getHeroTaskCo(taskId)
	return lua_act139_hero_task.configDict[taskId]
end

function VersionActivity1_5DungeonConfig:getSubHeroTaskList(taskId)
	self:initSubHeroTaskCo()

	return self.taskId2SubTaskListDict[taskId]
end

function VersionActivity1_5DungeonConfig:getExploreReward()
	return self.exploreTaskReward[1], self.exploreTaskReward[2], self.exploreTaskReward[3]
end

function VersionActivity1_5DungeonConfig:getExploreUnlockEpisodeId()
	return self.exploreTaskUnlockEpisodeId
end

function VersionActivity1_5DungeonConfig:getSubHeroTaskCoByElementId(elementId)
	self:initSubHeroTaskCo()

	return self.subHeroTaskElementIdDict[elementId]
end

function VersionActivity1_5DungeonConfig:initBuildInfoList()
	if self.initBuild then
		return
	end

	local metaTable = {}

	function metaTable.__index(t, key)
		local value = rawget(t, key)

		if not value then
			local srcCo = rawget(t, "srcCo")

			value = srcCo[key]
		end

		return value
	end

	self.initBuild = true
	self.groupId2CoDict = {}
	self.buildCoList = {}

	for _, buildCo in ipairs(lua_activity140_building.configList) do
		local coDict = self.groupId2CoDict[buildCo.group]

		if not coDict then
			coDict = {}
			self.groupId2CoDict[buildCo.group] = coDict
		end

		local newCo = {}

		setmetatable(newCo, metaTable)

		newCo.costList = string.splitToNumber(buildCo.cost, "#")
		newCo.id = buildCo.id
		newCo.srcCo = buildCo

		local pos = string.splitToNumber(buildCo.focusPos, "#")

		newCo.focusPosX = pos[1]
		newCo.focusPosY = pos[2]

		table.insert(self.buildCoList, newCo)

		coDict[buildCo.type] = newCo
	end
end

function VersionActivity1_5DungeonConfig:getBuildCo(buildId)
	self:initBuildInfoList()

	for _, buildCo in ipairs(self.buildCoList) do
		if buildCo.id == buildId then
			return buildCo
		end
	end

	logError("not found build id : " .. tostring(buildId))
end

function VersionActivity1_5DungeonConfig:getBuildCoByGroupAndType(groupId, type)
	self:initBuildInfoList()

	return self.groupId2CoDict[groupId][type]
end

function VersionActivity1_5DungeonConfig:getBuildCoList(groupId)
	self:initBuildInfoList()

	return self.groupId2CoDict[groupId]
end

function VersionActivity1_5DungeonConfig:getBuildReward()
	return self.buildReward[1], self.buildReward[2], self.buildReward[3]
end

function VersionActivity1_5DungeonConfig:getBuildUnlockEpisodeId()
	return self.buildUnlockEpisodeId
end

function VersionActivity1_5DungeonConfig:checkElementBelongMapId(elementCo, mapId)
	local elementExtendConfig = lua_activity11502_episode_element.configDict[elementCo.id]
	local belongMapIdList

	return tabletool.indexOf(not string.nilorempty(elementExtendConfig.mapIds) and string.splitToNumber(elementExtendConfig.mapIds, "#") or {
		elementCo.mapId
	}, mapId)
end

VersionActivity1_5DungeonConfig.instance = VersionActivity1_5DungeonConfig.New()

return VersionActivity1_5DungeonConfig
