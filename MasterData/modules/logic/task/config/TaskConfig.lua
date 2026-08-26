-- chunkname: @modules/logic/task/config/TaskConfig.lua

module("modules.logic.task.config.TaskConfig", package.seeall)

local sf = string.format
local TaskConfig = class("TaskConfig", BaseConfig)

function TaskConfig:ctor()
	self.taskdailyConfig = nil
	self.taskweeklyConfig = nil
	self.taskactivitybonusConfig = nil
	self.taskachievementConfig = nil
	self.tasknoviceConfig = nil
	self.tasktypeConfig = nil
	self.taskseasonConfig = nil
	self.taskactivityshowConfig = nil
end

function TaskConfig:reqConfigNames()
	return {
		"task_daily",
		"task_weekly",
		"task_activity_bonus",
		"task_achievement",
		"task_guide",
		"task_type",
		"task_room",
		"task_weekwalk",
		"task_season",
		"task_activity_show"
	}
end

function TaskConfig:onConfigLoaded(configName, configTable)
	if configName == "task_daily" then
		self.taskdailyConfig = configTable
	elseif configName == "task_weekly" then
		self.taskweeklyConfig = configTable
	elseif configName == "task_activity_bonus" then
		self.taskactivitybonusConfig = configTable
	elseif configName == "task_achievement" then
		self.taskachievementConfig = configTable
	elseif configName == "task_guide" then
		self.tasknoviceConfig = configTable
	elseif configName == "task_type" then
		self.tasktypeConfig = configTable
	elseif configName == "task_room" then
		self.taskroomConfig = configTable
	elseif configName == "task_weekwalk" then
		self:_initWeekWalkTask()
	elseif configName == "task_season" then
		self.taskseasonConfig = configTable
	elseif configName == "task_activity_show" then
		self.taskactivityshowConfig = configTable
	end
end

function TaskConfig:getSeasonTaskCo(taskId)
	return self.taskseasonConfig.configDict[taskId]
end

function TaskConfig:getWeekWalkTaskList(type)
	return self._taskTypeList[type]
end

function TaskConfig:_initWeekWalkTask()
	self._taskRewardList = {}
	self._taskTypeList = {}

	for i, v in ipairs(lua_task_weekwalk.configList) do
		if not self._taskTypeList[v.minTypeId] then
			table.insert(self._taskTypeList[v.minTypeId], v)

			self._taskTypeList[v.minTypeId] = self._taskTypeList[v.minTypeId]

			self:_initTaskReward(v)
		end
	end
end

function TaskConfig:_initTaskReward(config)
	local listenerParam

	if config.listenerType == "WeekwalkBattle" then
		local list = string.split(config.listenerParam, "#")

		listenerParam = tonumber(list[1])
	else
		listenerParam = tonumber(config.listenerParam)
	end

	if not listenerParam then
		return
	end

	local bonus = config.bonus

	self._taskRewardList[listenerParam] = self._taskRewardList[listenerParam] or {}

	local rewards = string.split(bonus, "|")

	for i = 1, #rewards do
		local itemCo = string.splitToNumber(rewards[i], "#")

		if itemCo[1] == MaterialEnum.MaterialType.Currency and itemCo[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			self._taskRewardList[listenerParam][config.id] = itemCo[3]
		end
	end
end

function TaskConfig:getWeekWalkRewardList(layerId)
	return self._taskRewardList[layerId]
end

function TaskConfig:gettaskdailyCO(id)
	return self.taskdailyConfig.configDict[id]
end

function TaskConfig:gettaskweeklyCO(id)
	return self.taskweeklyConfig.configDict[id]
end

function TaskConfig:gettaskNoviceConfigs()
	return self.tasknoviceConfig.configDict
end

function TaskConfig:gettaskNoviceConfig(id)
	return self.tasknoviceConfig.configDict[id]
end

function TaskConfig:gettaskactivitybonusCO(tasktype, id)
	local taskBonus = self.taskactivitybonusConfig.configDict[tasktype]

	if taskBonus then
		return taskBonus[id]
	end
end

function TaskConfig:getTaskActivityBonusConfig(taskType)
	return self.taskactivitybonusConfig.configDict[taskType]
end

function TaskConfig:getTaskBonusValue(taskType, id, num)
	self.taskBonusValueDict = self.taskBonusValueDict or {}

	if not self.taskBonusValueDict[taskType] then
		self.taskBonusValueDict[taskType] = {}

		local taskBonusCoDict = self:getTaskActivityBonusConfig(taskType)

		if not taskBonusCoDict then
			logError("not found task bonus , type : " .. tostring(taskType))

			return 0
		end

		local taskBonusCoList = {}

		for _, taskBonusCo in pairs(taskBonusCoDict) do
			table.insert(taskBonusCoList, taskBonusCo)
		end

		table.sort(taskBonusCoList, function(a, b)
			return a.id < b.id
		end)

		local preId

		for _id, taskBonusCo in ipairs(taskBonusCoList) do
			self.taskBonusValueDict[taskType][_id] = ((preId or nil) and (self.taskBonusValueDict[taskType][preId] or 0)) + taskBonusCo.needActivity
			preId = _id
		end
	end

	return (self.taskBonusValueDict[taskType][id - 1] or 0) + num
end

function TaskConfig:gettaskachievementCO(id)
	return self.taskachievementConfig.configDict[id]
end

function TaskConfig:gettasktypeCO(id)
	return self.tasktypeConfig.configDict[id]
end

function TaskConfig:gettaskRoomCO(id)
	return self.taskroomConfig.configDict[id]
end

function TaskConfig:gettaskroomlist()
	return self.taskroomConfig.configList
end

function TaskConfig:getTaskActivityShowConfig(actId)
	return self.taskactivityshowConfig.configDict[actId]
end

local kListenerType_ReadTask = "ReadTask"

function TaskConfig:initReadTaskList(source, refReadTaskCODict, inTaskTagEnumDefine, configTable)
	local errmsg, sb

	if isDebugBuild then
		sb = ConfigsCheckerMgr.instance:createStrBuf(source)
	end

	for _, CO in ipairs(configTable.configList) do
		local actId = CO.activityId
		local actTable = refReadTaskCODict[actId]

		if not actTable then
			actTable = {}

			for k, v in pairs(inTaskTagEnumDefine) do
				if isDebugBuild then
					sb:appendLineIfOK(actTable[v], sf("redefined enum enumKey: %s, enumValue: %s", k, v))
				end

				actTable[v] = {}
			end

			refReadTaskCODict[actId] = actTable
		end

		if CO.isOnline then
			local taskId = CO.id

			if CO.listenerType == kListenerType_ReadTask then
				local tag = inTaskTagEnumDefine[CO.tag]

				if not tag then
					errmsg = sf("[TaskConfig]: error actId: %s, taskId: %s", actId, taskId)

					if isDebugBuild then
						sb:appendLine(errmsg)
					end

					logError(errmsg)
				else
					local tagTable = actTable[tag]

					if tagTable then
						tagTable[taskId] = CO
					else
						errmsg = sf("[TaskConfig]: unsupported actId: %s, tag: %s", actId, CO.tag)

						if isDebugBuild then
							sb:appendLine(errmsg)
						end

						logError(errmsg)
					end
				end
			end
		end
	end

	if isDebugBuild then
		sb:logErrorIfGot()
	end
end

TaskConfig.instance = TaskConfig.New()

return TaskConfig
