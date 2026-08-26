-- chunkname: @modules/logic/tower/model/TowerTaskModel.lua

module("modules.logic.tower.model.TowerTaskModel", package.seeall)

local TowerTaskModel = class("TowerTaskModel", MixScrollModel)

function TowerTaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.ColumnCount = 1
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0
	self.AnimRowCount = 6

	self:reInit()
end

function TowerTaskModel:reInit()
	self.tempTaskModel:clear()
	self:clear()

	self.limitTimeTaskMap = {}
	self.limitTimeTaskList = {}
	self.bossTaskMap = {}
	self.bossTaskList = {}
	self.actTaskMap = {}
	self.actTaskList = {}
	self.reddotShowMap = {}
	self._itemStartAnimTime = nil

	self:cleanData()
end

function TowerTaskModel:cleanData()
	self.curSelectToweId = 1
	self.curSelectTowerType = TowerEnum.TowerType.Limited
end

function TowerTaskModel:setTaskInfoList(taskInfoList)
	local list = {}

	self.limitTimeTaskMap = {}
	self.bossTaskMap = {}

	for _, taskMO in pairs(taskInfoList) do
		if not taskMO.config then
			local config = TowerConfig.instance:getTowerTaskConfig(taskMO.id)

			if not config then
				logError("爬塔任务配置表id不存在,请检查: " .. tostring(taskMO.id))
			end

			taskMO.init(taskMO, taskMO, config)
		end

		table.insert(list, taskMO)
	end

	self.tempTaskModel:setList(list)

	for _, taskMO in ipairs(self.tempTaskModel:getList()) do
		self:initTaskMap(taskMO)
	end

	self:initTaskList()
	self:sortList()
	self:checkRedDot()
end

function TowerTaskModel:initTaskMap(taskMO)
	local taskGroupId = taskMO.config.taskGroupId
	local bossTowerConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(taskGroupId)
	local timeTowerConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(taskGroupId)

	if bossTowerConfig and taskMO.config.activityId == 0 then
		local bossTasks = self.bossTaskMap[bossTowerConfig.towerId]

		if not bossTasks then
			bossTasks = {}
			self.bossTaskMap[bossTowerConfig.towerId] = bossTasks
		end

		self.bossTaskMap[bossTowerConfig.towerId][taskMO.id] = taskMO
	elseif timeTowerConfig then
		self.limitTimeTaskMap[taskMO.id] = taskMO
	elseif taskGroupId == 0 and taskMO.config.activityId > 0 and taskMO.config.isKeyReward ~= 1 then
		self.actTaskMap[taskMO.id] = taskMO
	end
end

function TowerTaskModel:initTaskList()
	self.limitTimeTaskList = {}

	for taskId, taskMO in pairs(self.limitTimeTaskMap) do
		table.insert(self.limitTimeTaskList, taskMO)
	end

	self.bossTaskList = {}

	for towerId, taskList in pairs(self.bossTaskMap) do
		self.bossTaskList[towerId] = {}

		for taskId, taskMO in pairs(taskList) do
			table.insert(self.bossTaskList[towerId], taskMO)
		end
	end

	self.actTaskList = {}

	for taskId, taskMO in pairs(self.actTaskMap) do
		table.insert(self.actTaskList, taskMO)
	end
end

function TowerTaskModel:sortList()
	if #self.limitTimeTaskList > 0 then
		table.sort(self.limitTimeTaskList, TowerTaskModel.limitTimeSortFunc)
	end

	if tabletool.len(self.bossTaskList) > 0 then
		for towerId, taskList in ipairs(self.bossTaskList) do
			table.sort(taskList, TowerTaskModel.bossSortFunc)
		end
	end

	if #self.actTaskList > 0 then
		table.sort(self.actTaskList, TowerTaskModel.actSortFunc)
	end
end

function TowerTaskModel.bossSortFunc(a, b)
	local aValue = a.finishCount >= a.config.maxProgress and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount >= b.config.maxProgress and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerTaskModel.limitTimeSortFunc(a, b)
	local aValue = a.finishCount >= 1 and a.progress >= a.config.maxProgress and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount >= 1 and b.progress >= b.config.maxProgress and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerTaskModel.actSortFunc(a, b)
	local aValue = a.finishCount >= a.config.maxProgress and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount >= b.config.maxProgress and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerTaskModel:updateTaskInfo(taskInfoList)
	local isChange = false

	if GameUtil.getTabLen(self.tempTaskModel:getList()) == 0 then
		return
	end

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.Tower then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = TowerConfig.instance:getTowerTaskConfig(info.id)

				if config then
					mo = TaskMo.New()

					mo:init(info, config)
					self.tempTaskModel:addAtLast(mo)
					self:initTaskMap(mo)
				else
					logError("Season123TaskCo by id is not exit: " .. tostring(info.id))
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

function TowerTaskModel:checkRedDot()
	if tabletool.len(self.limitTimeTaskList) > 0 then
		local cangetCount = self:getTaskItemCanGetCount(self.limitTimeTaskList)

		self.reddotShowMap[TowerEnum.TowerType.Limited] = cangetCount > 0
	end

	if tabletool.len(self.bossTaskList) > 0 then
		self.reddotShowMap[TowerEnum.TowerType.Boss] = {}

		for towerId, taskList in pairs(self.bossTaskList) do
			local cangetCount = self:getTaskItemCanGetCount(taskList)

			self.reddotShowMap[TowerEnum.TowerType.Boss][towerId] = cangetCount > 0
		end
	end

	if tabletool.len(self.actTaskList) > 0 then
		local cangetCount = self:getTaskItemCanGetCount(self.actTaskList)
		local actRewardTaskMO = self:getActRewardTask()

		if actRewardTaskMO and actRewardTaskMO.progress >= actRewardTaskMO.config.maxProgress and actRewardTaskMO.finishCount == 0 then
			cangetCount = cangetCount + 1
		end

		self.reddotShowMap[TowerEnum.ActTaskType] = cangetCount > 0
	end
end

function TowerTaskModel:canShowReddot(towerType, towerId)
	if towerType == TowerEnum.TowerType.Limited then
		return self.reddotShowMap[towerType]
	elseif towerType == TowerEnum.ActTaskType then
		return self.reddotShowMap[towerType]
	else
		return self.reddotShowMap[towerType][towerId]
	end
end

function TowerTaskModel:setCurSelectTowerTypeAndId(towerType, towerId)
	self.curSelectTowerType = towerType
	self.curSelectToweId = towerId
end

function TowerTaskModel:refreshList(type)
	local curTaskList = self:getCurTaskList(type) or {}
	local list = tabletool.copy(curTaskList)
	local rewardCount = self:getTaskItemCanGetCount(list)

	if rewardCount > 1 then
		table.insert(list, 1, {
			id = 0,
			canGetAll = true
		})
	end

	self:setList(list)
	self:checkRedDot()
	TowerController.instance:dispatchEvent(TowerEvent.TowerRefreshTask)
end

function TowerTaskModel:getAllCanGetList()
	local idList = {}
	local taskList = self:getCurTaskList() or {}

	for _, taskMo in ipairs(taskList) do
		if taskMo.config and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			table.insert(idList, taskMo.id)
		end
	end

	return idList
end

function TowerTaskModel:getCurTaskList(type)
	local list = {}

	self.curSelectTowerType = type or self.curSelectTowerType

	if self.curSelectTowerType == TowerEnum.TowerType.Limited then
		list = self.limitTimeTaskList
	elseif self.curSelectTowerType == TowerEnum.TowerType.Boss then
		list = self.bossTaskList[self.curSelectToweId]
	elseif self.curSelectTowerType == TowerEnum.ActTaskType then
		list = self.actTaskList
	end

	return list
end

function TowerTaskModel:getTaskItemRewardCount(list)
	local count = 0

	for _, taskMo in ipairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function TowerTaskModel:getTaskItemCanGetCount(list)
	local count = 0

	for _, taskMo in pairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			count = count + 1
		end
	end

	return count
end

function TowerTaskModel:getTaskItemFinishedCount(list)
	local count = 0

	for _, taskMo in ipairs(list) do
		if self:isTaskFinished(taskMo) then
			count = count + 1
		end
	end

	return count
end

function TowerTaskModel:isTaskFinished(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function TowerTaskModel:isTaskFinishedById(taskId)
	local mo = self.tempTaskModel:getById(taskId)

	return mo and mo.progress >= mo.config.maxProgress
end

function TowerTaskModel:getDelayPlayTime(mo)
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

function TowerTaskModel:getTotalTaskRewardCount()
	local taskMoList = self.tempTaskModel:getList()
	local totalTaskCount = #taskMoList
	local hasFinishedCount = self:getTaskItemRewardCount(taskMoList)

	return hasFinishedCount, totalTaskCount
end

function TowerTaskModel:checkHasBossTask()
	for _, bossTasks in pairs(self.bossTaskMap) do
		if tabletool.len(bossTasks) > 0 then
			return true
		end
	end

	return false
end

function TowerTaskModel:getActRewardTask()
	local taskMoList = self.tempTaskModel:getList()

	for index, taskMO in ipairs(taskMoList) do
		if taskMO.config.isKeyReward == 1 and taskMO.config.activityId > 0 then
			return taskMO
		end
	end
end

function TowerTaskModel:getBossTaskList(towerId)
	return self.bossTaskList[towerId]
end

TowerTaskModel.instance = TowerTaskModel.New()

return TowerTaskModel
