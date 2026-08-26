-- chunkname: @modules/logic/task/model/TaskModel.lua

module("modules.logic.task.model.TaskModel", package.seeall)

local TaskModel = class("TaskModel", BaseModel)

function TaskModel:onInit()
	self:reInit()
end

function TaskModel:reInit()
	self._taskMODict = {}
	self._taskActivityMODict = {}
	self._newTaskIdDict = {}
	self._curStage = 0
	self._taskList = {}
	self._hasTaskNoviceStageReward = false
	self._noviceTaskHeroParam = nil
end

function TaskModel:setHasTaskNoviceStageReward(has)
	self._hasTaskNoviceStageReward = has
end

function TaskModel:couldGetTaskNoviceStageReward()
	return self._hasTaskNoviceStageReward
end

function TaskModel:setTaskNoviceStageHeroParam(param)
	self._noviceTaskHeroParam = param
end

function TaskModel:getTaskNoviceStageParam()
	return self._noviceTaskHeroParam
end

function TaskModel:getTaskById(taskId)
	return self._taskList[taskId]
end

function TaskModel:getTaskMoList(typeId, actId)
	local taskMoList = {}
	local list = self:getAllUnlockTasks(typeId)

	if not list then
		return taskMoList
	end

	for _, taskMo in pairs(list) do
		if taskMo.config and taskMo.config.activityId == actId then
			table.insert(taskMoList, taskMo)
		end
	end

	return taskMoList
end

function TaskModel:getRefreshCount()
	return self._selectCount
end

function TaskModel:setRefreshCount(count)
	self._selectCount = count
end

function TaskModel:setTaskMOList(infos, typeIds)
	for _, type in ipairs(typeIds) do
		self._taskMODict[type] = {}
	end

	if infos then
		for _, v in ipairs(infos) do
			local config = self:getTaskConfig(v.type, v.id)
			local taskMo = TaskMo.New()

			taskMo:init(v, config)

			self._taskMODict[v.type] = self._taskMODict[v.type] or {}
			self._taskMODict[v.type][v.id] = taskMo
			self._taskList[v.id] = taskMo
		end
	end
end

function TaskModel:onTaskMOChange(infos)
	if infos then
		for _, v in ipairs(infos) do
			if self._taskMODict[v.type] then
				if not self._taskMODict[v.type][v.id] then
					local existMo

					if not existMo then
						local config = self:getTaskConfig(v.type, v.id)
						local taskMo = TaskMo.New()

						taskMo:init(v, config)

						self._taskMODict[v.type] = self._taskMODict[v.type] or {}
						self._taskMODict[v.type][v.id] = taskMo
						self._taskList[v.id] = taskMo
						self._newTaskIdDict[v.id] = true
					else
						existMo:update(v)
					end
				end
			end
		end
	end
end

function TaskModel:getTaskConfig(typeId, id)
	local taskFunc = TaskConfigGetDefine.instance:getTaskConfigFunc(typeId)

	if taskFunc then
		return taskFunc(id)
	end
end

function TaskModel:isTaskFinish(type, taskId)
	local dict = self._taskMODict[type]

	if not dict then
		return false
	end

	local taskMO = dict[taskId]

	if not taskMO then
		return false
	end

	return taskMO:isClaimed()
end

function TaskModel:taskHasFinished(type, taskId)
	local dict = self._taskMODict[type]

	if not dict then
		return false
	end

	local taskMO = dict[taskId]

	if not taskMO then
		return false
	end

	return taskMO:isFinished()
end

function TaskModel:isTaskUnlock(type, taskId)
	local dict = self._taskMODict[type]

	if not dict then
		return false
	end

	local taskMO = dict[taskId]

	if not taskMO then
		return false
	end

	return taskMO.id == taskId
end

function TaskModel:getAllUnlockTasks(type)
	return self._taskMODict[type] or {}
end

function TaskModel:setTaskActivityMOList(infos)
	if infos then
		for _, v in ipairs(infos) do
			local taskActivityMo = self._taskActivityMODict[v.typeId]

			if not taskActivityMo then
				local config = v.defineId + 1 <= 5 and TaskConfig.instance:gettaskactivitybonusCO(v.typeId, v.defineId + 1) or TaskConfig.instance:gettaskactivitybonusCO(v.typeId, v.defineId)

				taskActivityMo = TaskActivityMo.New()

				taskActivityMo:init(v, config)

				self._taskActivityMODict[v.typeId] = taskActivityMo
			else
				taskActivityMo:update(v)
			end
		end
	end
end

function TaskModel:onTaskActivityMOChange(infos)
	if infos then
		local moList

		for _, v in ipairs(infos) do
			local existMo = self._taskActivityMODict[v.typeId]

			if not existMo then
				local config = v.defineId + 1 <= 5 and TaskConfig.instance:gettaskactivitybonusCO(v.typeId, v.defineId + 1) or TaskConfig.instance:gettaskactivitybonusCO(v.typeId, v.defineId)
				local taskActivityMo = TaskActivityMo.New()

				if config ~= nil then
					taskActivityMo:init(v, config)
				end

				moList = moList or {}

				table.insert(moList, taskActivityMo)

				self._taskActivityMODict[v.typeId] = taskActivityMo
			else
				existMo:update(v)
			end
		end
	end
end

function TaskModel:deleteTask(ids)
	for _, id in pairs(ids) do
		for type, _ in pairs(self._taskMODict) do
			self._taskMODict[type][id] = nil
		end
	end
end

function TaskModel:clearNewTaskIds()
	self._newTaskIdDict = {}
end

function TaskModel:getNewTaskIds()
	return self._newTaskIdDict
end

function TaskModel:getTaskActivityMO(typeId)
	return self._taskActivityMODict[typeId]
end

function TaskModel:getNoviceTaskCurStage()
	if self._curStage == 0 then
		self._curStage = self:getNoviceTaskMaxUnlockStage()
	end

	return self._curStage
end

function TaskModel:setNoviceTaskCurStage(stage)
	self._curStage = stage
end

function TaskModel:setNoviceTaskCurSelectStage(stage)
	self._curSelectStage = stage
end

function TaskModel:getNoviceTaskCurSelectStage()
	return self._curSelectStage or self:getNoviceTaskCurStage()
end

function TaskModel:getStageRewardGetIndex()
	return self._taskActivityMODict[TaskEnum.TaskType.Novice].defineId
end

function TaskModel:getNoviceTaskMaxUnlockStage()
	local maxStage = 0

	if self._taskMODict[TaskEnum.TaskType.Novice] then
		for _, v in pairs(self._taskMODict[TaskEnum.TaskType.Novice]) do
			if v.config.minTypeId == TaskEnum.TaskMinType.Novice then
				local stage = TaskConfig.instance:gettaskNoviceConfig(v.id).stage

				if maxStage < stage and v.config.chapter == 0 then
					maxStage = stage
				end
			end
		end
	end

	return maxStage
end

function TaskModel:getCurStageActDotGetNum()
	local curStage = self:getNoviceTaskCurStage()
	local maxStage = self:getMaxStage(TaskEnum.TaskType.Novice)

	if curStage == maxStage and self._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue == self:getAllTaskTotalActDot() then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, maxStage).needActivity
	end

	if not self._taskActivityMODict[TaskEnum.TaskType.Novice] then
		return 0
	end

	return self._taskActivityMODict[TaskEnum.TaskType.Novice].value - self._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue
end

function TaskModel:getStageActDotGetNum(stage)
	local curStage = self:getNoviceTaskCurStage()

	if curStage < stage then
		return 0
	end

	if stage < curStage then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, stage).needActivity
	end

	return self:getCurStageActDotGetNum()
end

function TaskModel:getAllTaskTotalActDot()
	local value = 0
	local taskCo = TaskConfig.instance:gettaskNoviceConfigs()

	for _, v in pairs(taskCo) do
		value = value + v.activity
	end

	return value
end

function TaskModel:getCurStageMaxActDot()
	local co = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, self._curStage)

	if co then
		if not co.needActivity then
			return 0
		end
	end
end

function TaskModel:getStageMaxActDot(stage)
	local co = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, stage)

	if co then
		if not co.needActivity then
			return 0
		end
	end
end

function TaskModel:getMaxStage(taskType)
	local stage = 1
	local co = TaskConfig.instance:getTaskActivityBonusConfig(taskType)
	local isVerifing = VersionValidator.instance:isInReviewing()

	for _, v in pairs(co) do
		if (isVerifing and v.hideInVerifing == true) == false and stage < v.id then
			stage = v.id
		end
	end

	return stage
end

function TaskModel:getCurStageAllLockTaskIds()
	local ids = {}
	local co = TaskConfig.instance:gettaskNoviceConfigs()

	for _, v in pairs(co) do
		if v.stage == self._curStage and v.minTypeId == 1 and v.chapter == 0 and not self:isTaskUnlock(TaskEnum.TaskType.Novice, v.id) then
			table.insert(ids, v.id)
		end
	end

	return ids
end

function TaskModel:getAllRewardUnreceivedTasks(typeId)
	local tasks = {}

	for taskId, taskMo in pairs(self._taskMODict[typeId]) do
		if taskMo:isClaimable() then
			table.insert(tasks, taskMo)
		end
	end

	return tasks
end

function TaskModel:isTypeAllTaskFinished(typeId)
	local alltasks = self:getAllUnlockTasks(typeId)

	for _, task in pairs(alltasks) do
		if not self:isTaskFinish(typeId, task.id) then
			return false
		end
	end

	return true
end

function TaskModel:isAllRewardGet(typeId)
	local actCo = TaskConfig.instance:getTaskActivityBonusConfig(typeId)
	local actMo = TaskModel.instance:getTaskActivityMO(typeId)
	local totalAct = 0

	for i = 1, #actCo do
		totalAct = totalAct + actCo[i].needActivity
	end

	return totalAct <= actMo.value
end

function TaskModel:isFinishAllNoviceTask()
	local stageTotal = self:getMaxStage(TaskEnum.TaskType.Novice)
	local stage = self:getNoviceTaskCurStage()
	local total = self:getCurStageMaxActDot()
	local maxUnlockStage = self:getNoviceTaskMaxUnlockStage()
	local curProgress = self:getCurStageActDotGetNum()
	local hasGetReward = stage < maxUnlockStage and true or total <= curProgress

	return stage == stageTotal and hasGetReward and self:isTypeAllTaskFinished(TaskEnum.TaskType.Novice)
end

function TaskModel:getTaskTypeExpireTime(typeId)
	local expireTime = 0
	local tasks = self:getAllUnlockTasks(typeId)

	for _, v in pairs(tasks) do
		if v.expiryTime > 0 then
			expireTime = v.expiryTime

			break
		end
	end

	return expireTime
end

TaskModel.instance = TaskModel.New()

return TaskModel
