-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyTaskModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyTaskModel", package.seeall)

local OdysseyTaskModel = class("OdysseyTaskModel", ListScrollModel)

function OdysseyTaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.ColumnCount = 1
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0
	self.AnimRowCount = 6

	self:reInit()
end

function OdysseyTaskModel:reInit()
	self.tempTaskModel:clear()
	self:clear()

	self._itemStartAnimTime = nil
	self.reddotShowMap = {}
	self.levelRewardTaskMap = {}
	self.normalTaskMap = {}
	self.levelRewardTaskList = {}
	self.normalTaskList = {}
	self.bigRewardTaskMo = nil
end

function OdysseyTaskModel:setTaskInfoList()
	local list = {}

	self.levelRewardTaskMap = {}
	self.normalTaskMap = {}

	local taskMoDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Odyssey)

	for taskId, taskMo in pairs(taskMoDict) do
		if not taskMo.config then
			local config = OdysseyConfig.instance:getTaskConfig(taskMo.id)

			if not config then
				logError("奥德赛任务配置表id不存在,请检查: " .. tostring(taskMo.id))
			end

			taskMo.init(taskMo, taskMo, config)
		end

		table.insert(list, taskMo)
	end

	self.tempTaskModel:setList(list)

	for _, taskMo in ipairs(self.tempTaskModel:getList()) do
		self:initTaskMap(taskMo)
	end

	self:initTaskList()
	self:sortList()
	self:checkRedDot()
end

function OdysseyTaskModel:initTaskMap(taskMo)
	if taskMo.config.taskGroupId == OdysseyEnum.TaskGroupType.LevelReward then
		self.levelRewardTaskMap[taskMo.id] = taskMo
	elseif OdysseyEnum.NormalTaskGroupType[taskMo.config.taskGroupId] then
		local taskTypeList = self.normalTaskMap[taskMo.config.taskGroupId]

		if not taskTypeList then
			taskTypeList = {}
			self.normalTaskMap[taskMo.config.taskGroupId] = taskTypeList
		end

		self.normalTaskMap[taskMo.config.taskGroupId][taskMo.id] = taskMo
	elseif taskMo.config.taskGroupId == 0 and taskMo.config.isKeyReward == 1 then
		self.bigRewardTaskMo = taskMo
	end
end

function OdysseyTaskModel:initTaskList()
	self.levelRewardTaskList = {}

	for _, taskMo in pairs(self.levelRewardTaskMap) do
		table.insert(self.levelRewardTaskList, taskMo)
	end

	self.normalTaskList = {}

	for typeGroupdId, taskList in pairs(self.normalTaskMap) do
		self.normalTaskList[typeGroupdId] = {}

		for taskId, taskMO in pairs(taskList) do
			table.insert(self.normalTaskList[typeGroupdId], taskMO)
		end
	end
end

function OdysseyTaskModel:sortList()
	if #self.levelRewardTaskList > 0 then
		table.sort(self.levelRewardTaskList, OdysseyTaskModel.levelRewardTaskSortFunc)
	end

	if tabletool.len(self.normalTaskList) > 0 then
		for _, taskList in pairs(self.normalTaskList) do
			table.sort(taskList, OdysseyTaskModel.taskSortFunc)
		end
	end
end

function OdysseyTaskModel.levelRewardTaskSortFunc(a, b)
	return a.config.maxProgress < b.config.maxProgress
end

function OdysseyTaskModel.taskSortFunc(a, b)
	local aValue = a.finishCount > 0 and a.progress >= a.config.maxProgress and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount > 0 and b.progress >= b.config.maxProgress and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function OdysseyTaskModel:updateTaskInfo(taskInfoList)
	local isChange = false

	if GameUtil.getTabLen(self.tempTaskModel:getList()) == 0 then
		return
	end

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.Odyssey then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = OdysseyConfig.instance:getTaskConfig(info.id)

				if config then
					mo = TaskMo.New()

					mo:init(info, config)
					self.tempTaskModel:addAtLast(mo)
					self:initTaskMap(mo)
				else
					logError("奥德赛任务配置表id不存在,请检查: " .. tostring(info.id))
				end
			else
				mo:update(info)
			end

			self:initTaskMap(mo)

			isChange = true
		end
	end

	if isChange then
		self:initTaskList()
		self:sortList()
		self:checkRedDot()
	end

	return isChange
end

function OdysseyTaskModel:checkRedDot()
	if tabletool.len(self.levelRewardTaskList) > 0 then
		local cangetCount = self:getTaskItemCanGetCount(self.levelRewardTaskList)

		self.reddotShowMap[OdysseyEnum.TaskType.LevelReward] = cangetCount > 0
	end

	if tabletool.len(self.normalTaskList) > 0 then
		self.reddotShowMap[OdysseyEnum.TaskType.NormalTask] = {}

		for typeGroupdId, taskList in pairs(self.normalTaskList) do
			local cangetCount = self:getTaskItemCanGetCount(taskList)

			self.reddotShowMap[OdysseyEnum.TaskType.NormalTask][typeGroupdId] = cangetCount > 0
		end
	end
end

function OdysseyTaskModel:canShowReddot(taskType, groupTypeId)
	if taskType == OdysseyEnum.TaskType.LevelReward then
		return self.reddotShowMap[taskType]
	else
		return self.reddotShowMap[taskType][groupTypeId]
	end
end

function OdysseyTaskModel:setCurSelectTaskTypeAndGroupId(taskType, groupTypeId)
	self.curTaskType = taskType
	self.curSelectGroupTypeId = groupTypeId
end

function OdysseyTaskModel:getCurSelectTaskTypeAndGroupId()
	return self.curTaskType, self.curSelectGroupTypeId
end

function OdysseyTaskModel:refreshList()
	local curTaskList = self:getCurTaskList(self.curTaskType) or {}

	if not curTaskList or #curTaskList == 0 then
		return
	end

	local list = tabletool.copy(curTaskList)

	if self.curTaskType == OdysseyEnum.TaskType.NormalTask then
		local rewardCount = self:getTaskItemCanGetCount(list)

		if rewardCount > 1 then
			table.insert(list, 1, {
				id = 0,
				canGetAll = true
			})
		end
	end

	self:setList(list)
	self:checkRedDot()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OdysseyTaskRefresh)
end

function OdysseyTaskModel:getCurTaskList(type)
	local list = {}

	if type == OdysseyEnum.TaskType.LevelReward then
		list = self.levelRewardTaskList
	elseif type == OdysseyEnum.TaskType.NormalTask then
		list = self.normalTaskList[self.curSelectGroupTypeId]
	end

	return list
end

function OdysseyTaskModel:getTaskItemCanGetCount(list)
	local count = 0

	for _, taskMo in pairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			count = count + 1
		end
	end

	return count
end

function OdysseyTaskModel:isTaskHasGet(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function OdysseyTaskModel:isTaskCanGet(taskMo)
	return taskMo.hasFinished
end

function OdysseyTaskModel:getAllCanGetMoList(type)
	local taskMoList = {}
	local curType = type or self.curTaskType
	local taskList = self:getCurTaskList(curType)

	for index, taskMo in ipairs(taskList) do
		if self:isTaskCanGet(taskMo) then
			table.insert(taskMoList, taskMo)
		end
	end

	return taskMoList
end

function OdysseyTaskModel:getAllCanGetIdList(type)
	local taskIdList = {}
	local curType = type or self.curTaskType
	local taskMoList = self:getAllCanGetMoList(curType)

	for index, taskMo in ipairs(taskMoList) do
		table.insert(taskIdList, taskMo.id)
	end

	return taskIdList
end

function OdysseyTaskModel:getBigRewardTaskMo()
	return self.bigRewardTaskMo
end

function OdysseyTaskModel:checkHasLevelReawrdTaskCanGet()
	return self:canShowReddot(OdysseyEnum.TaskType.LevelReward)
end

function OdysseyTaskModel:checkHasNormalTaskCanGet()
	if not self.reddotShowMap[OdysseyEnum.TaskType.NormalTask] then
		local hasCanGetReward = false

		for _, isCanGet in pairs(self.reddotShowMap[OdysseyEnum.TaskType.NormalTask]) do
			if isCanGet then
				hasCanGetReward = true

				break
			end
		end

		if self.bigRewardTaskMo then
			local hasBigRewardCanGet = self:isTaskCanGet(self.bigRewardTaskMo)

			return hasCanGetReward or hasBigRewardCanGet
		end
	end
end

function OdysseyTaskModel:getNormalTaskListByGroupType(groupType)
	return self.normalTaskList[groupType]
end

function OdysseyTaskModel:getTaskItemRewardCount(list)
	local count = 0

	for _, taskMo in ipairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function OdysseyTaskModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime + self.OpenAnimStartTime
	end

	local index = self:getIndex(mo)

	if not index or index > self.AnimRowCount * self.ColumnCount then
		return -1
	end

	local delayTime = math.floor((index - 1) / self.ColumnCount) * self.OpenAnimTime + self.OpenAnimStartTime
	local passTime = curTime - self._itemStartAnimTime

	if passTime - delayTime > 0.1 then
		return -1
	else
		return delayTime
	end
end

OdysseyTaskModel.instance = OdysseyTaskModel.New()

return OdysseyTaskModel
