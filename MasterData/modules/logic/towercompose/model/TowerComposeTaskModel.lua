-- chunkname: @modules/logic/towercompose/model/TowerComposeTaskModel.lua

module("modules.logic.towercompose.model.TowerComposeTaskModel", package.seeall)

local TowerComposeTaskModel = class("TowerComposeTaskModel", MixScrollModel)

function TowerComposeTaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.curSelectThemeId = 1

	self:reInit()
end

function TowerComposeTaskModel:reInit()
	self.tempTaskModel:clear()
	self:clear()

	self.normalTaskMap = {}
	self.normalTaskList = {}
	self.limitTimeTaskMap = {}
	self.limitTimeTaskList = {}
	self.researchTaskMap = {}
	self.researchTaskList = {}
	self.reddotShowMap = {}
	self.curSelectTaskType = TowerComposeEnum.TaskType.Normal
end

function TowerComposeTaskModel:setTaskInfoList(taskInfoList)
	local list = {}

	self.limitTimeTaskMap = {}
	self.researchTaskMap = {}

	self.tempTaskModel:clear()

	for _, taskMO in pairs(taskInfoList) do
		if not taskMO.config then
			local config = TowerComposeConfig.instance:getTowerComposeTaskConfig(taskMO.id)

			if not config then
				logError("towerCompose任务配置表id不存在,请检查: " .. tostring(taskMO.id))
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

function TowerComposeTaskModel:updateTaskInfo(taskInfoList)
	local isChange = false

	if GameUtil.getTabLen(self.tempTaskModel:getList()) == 0 then
		return
	end

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.TowerCompose then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = TowerComposeConfig.instance:getTowerComposeTaskConfig(info.id)

				if config then
					mo = TaskMo.New()

					mo:init(info, config)
					self.tempTaskModel:addAtLast(mo)
					self:initTaskMap(mo)
				else
					logError("towerCompose任务配置表id不存在, 请检查: " .. tostring(info.id))
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

function TowerComposeTaskModel:initTaskMap(taskMO)
	if taskMO.config.taskType == TowerComposeEnum.TaskType.Normal then
		self.normalTaskMap[taskMO.id] = taskMO
	elseif taskMO.config.taskType == TowerComposeEnum.TaskType.LimitTime then
		self.limitTimeTaskMap[taskMO.id] = taskMO
	elseif taskMO.config.taskType == TowerComposeEnum.TaskType.Research then
		local pointBonusInfo = string.splitToNumber(taskMO.config.pointBonus, "#")
		local themeId = pointBonusInfo[1]

		self.researchTaskMap[themeId] = self.researchTaskMap[themeId] or {}

		table.insert(self.researchTaskMap[themeId], taskMO)
	end
end

function TowerComposeTaskModel:initTaskList()
	self.normalTaskList = {}

	for taskId, taskMO in pairs(self.normalTaskMap) do
		table.insert(self.normalTaskList, taskMO)
	end

	self.limitTimeTaskList = {}

	for taskId, taskMO in pairs(self.limitTimeTaskMap) do
		table.insert(self.limitTimeTaskList, taskMO)
	end

	self.researchTaskList = {}

	for themeId, taskMOList in pairs(self.researchTaskMap) do
		self.researchTaskList[themeId] = {}

		for taskId, taskMo in ipairs(taskMOList) do
			table.insert(self.researchTaskList[themeId], taskMo)
		end
	end
end

function TowerComposeTaskModel:sortList()
	if #self.normalTaskList > 0 then
		table.sort(self.normalTaskList, TowerComposeTaskModel.taskSortFunc)
	end

	if #self.limitTimeTaskList > 0 then
		table.sort(self.limitTimeTaskList, TowerComposeTaskModel.taskSortFunc)
	end

	if tabletool.len(self.researchTaskList) > 0 then
		for themeId, taskMOList in pairs(self.researchTaskList) do
			table.sort(taskMOList, TowerComposeTaskModel.researchTaskSortFunc)
		end
	end
end

function TowerComposeTaskModel.taskSortFunc(a, b)
	local aValue = a.finishCount >= 1 and a.progress >= a.config.maxProgress and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount >= 1 and b.progress >= b.config.maxProgress and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerComposeTaskModel.researchTaskSortFunc(a, b)
	local isModUnlockA = TowerComposeTaskModel.checkHaveBodyMod(a.config)
	local isModUnlockB = TowerComposeTaskModel.checkHaveBodyMod(b.config)
	local aValue = a.finishCount >= 1 and a.progress >= a.config.maxProgress and 4 or a.hasFinished and 1 or not isModUnlockA and 3 or 2
	local bValue = b.finishCount >= 1 and b.progress >= b.config.maxProgress and 4 or b.hasFinished and 1 or not isModUnlockB and 3 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerComposeTaskModel.checkHaveBodyMod(researchTaskConfig)
	local bodyModIdList = string.splitToNumber(researchTaskConfig.params, "#")
	local pointBonusInfo = string.splitToNumber(researchTaskConfig.pointBonus, "#")
	local themeId = pointBonusInfo[1]
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)

	if not themeMo then
		logError(themeId .. "主题信息不存在")

		return false
	end

	for _, modId in ipairs(bodyModIdList) do
		if not themeMo:isModUnlock(modId) then
			return false, modId
		end
	end

	return true
end

function TowerComposeTaskModel:checkRedDot()
	if #self.normalTaskList > 0 then
		local cangetCount = self:getTaskItemCanGetCount(self.normalTaskList)

		self.reddotShowMap[TowerComposeEnum.TaskType.Normal] = cangetCount > 0
	end

	if #self.limitTimeTaskList > 0 then
		local cangetCount = self:getTaskItemCanGetCount(self.limitTimeTaskList)

		self.reddotShowMap[TowerComposeEnum.TaskType.LimitTime] = cangetCount > 0
	end

	if tabletool.len(self.researchTaskList) > 0 then
		self.reddotShowMap[TowerComposeEnum.TaskType.Research] = {}

		for themeId, taskMOList in pairs(self.researchTaskList) do
			local cangetCount = self:getTaskItemCanGetCount(taskMOList)

			self.reddotShowMap[TowerComposeEnum.TaskType.Research][themeId] = cangetCount > 0
		end
	end
end

function TowerComposeTaskModel:canShowReddot(taskType, themeId)
	if taskType == TowerComposeEnum.TaskType.Research then
		return self.reddotShowMap[taskType][themeId]
	else
		return self.reddotShowMap[taskType]
	end
end

function TowerComposeTaskModel:getTaskItemCanGetCount(list)
	local count = 0

	for _, taskMo in pairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			count = count + 1
		end
	end

	return count
end

function TowerComposeTaskModel:isTaskFinished(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function TowerComposeTaskModel:getAllCanGetList()
	local idList = {}
	local taskList = self:getCurTaskList() or {}

	for _, taskMo in ipairs(taskList) do
		if taskMo.config and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			table.insert(idList, taskMo.id)
		end
	end

	return idList
end

function TowerComposeTaskModel:setSelectTaskType(taskType)
	self.curSelectTaskType = taskType
end

function TowerComposeTaskModel:refreshList(taskType, themeId)
	local curTaskList = self:getCurTaskList(taskType, themeId) or {}
	local list = tabletool.copy(curTaskList)
	local rewardCount = self:getTaskItemCanGetCount(list)

	if rewardCount > 1 and self.curSelectTaskType ~= TowerComposeEnum.TaskType.Research then
		table.insert(list, 1, {
			id = 0,
			canGetAll = true
		})
	end

	self:setList(list)
	self:checkRedDot()
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.TowerComposeRefreshTask)
end

function TowerComposeTaskModel:getCurTaskList(type, themeId)
	local taskMoList = {}

	self.curSelectTaskType = type or self.curSelectTaskType

	if self.curSelectTaskType == TowerComposeEnum.TaskType.Normal then
		taskMoList = self.normalTaskList
	elseif self.curSelectTaskType == TowerComposeEnum.TaskType.LimitTime then
		taskMoList = self.limitTimeTaskList
	elseif self.curSelectTaskType == TowerComposeEnum.TaskType.Research then
		if not themeId or themeId <= 0 or not themeId then
			::label_18_0::

			local curThemeId = TowerComposeModel.instance:getCurThemeIdAndLayer()

			taskMoList = self.researchTaskList[curThemeId]
		end
	end

	return taskMoList
end

function TowerComposeTaskModel:getTaskLimitTime()
	if #self.limitTimeTaskList > 0 then
		local taskConfig = self.limitTimeTaskList[1].config

		if not string.nilorempty(taskConfig.endTime) then
			local timeStamp = TimeUtil.stringToTimestamp(taskConfig.endTime)

			return timeStamp - ServerTime.now()
		end
	end
end

function TowerComposeTaskModel:getLimitTimeTaskList()
	return self.limitTimeTaskList
end

function TowerComposeTaskModel:getAllCanGetIndexList()
	local indexList = {}
	local taskList = self:getCurTaskList() or {}

	for index, taskMo in ipairs(taskList) do
		if taskMo.config and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			table.insert(indexList, index)
		end
	end

	return indexList
end

TowerComposeTaskModel.instance = TowerComposeTaskModel.New()

return TowerComposeTaskModel
