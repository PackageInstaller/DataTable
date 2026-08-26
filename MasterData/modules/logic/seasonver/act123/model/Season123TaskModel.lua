-- chunkname: @modules/logic/seasonver/act123/model/Season123TaskModel.lua

module("modules.logic.seasonver.act123.model.Season123TaskModel", package.seeall)

local Season123TaskModel = class("Season123TaskModel", ListScrollModel)

function Season123TaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.curTaskType = Activity123Enum.TaskNormalType
	self.stageTaskMap = {}
	self.normalTaskMap = {}
	self.reddotShowMap = {}
	self.curStage = 1
	self.TaskMaskTime = 0.65
	self.ColumnCount = 1
	self.AnimRowCount = 7
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0
end

function Season123TaskModel:reInit()
	self.tempTaskModel:clear()
end

function Season123TaskModel:clear()
	self.tempTaskModel:clear()
	Season123TaskModel.super.clear(self)

	self._itemStartAnimTime = nil
	self.stageTaskMap = {}
	self.normalTaskMap = {}
	self.reddotShowMap = {}
end

function Season123TaskModel:resetMapData()
	self.stageTaskMap = {}
	self.normalTaskMap = {}
end

function Season123TaskModel:setTaskInfoList(taskInfoList)
	local list = {}
	local curActId = Season123Model.instance:getCurSeasonId()

	for _, v in pairs(taskInfoList) do
		if v.config and v.config.seasonId == curActId then
			table.insert(list, v)
		end
	end

	self.tempTaskModel:setList(list)
	self:sortList()
	self:checkRedDot()

	for _, taskMO in pairs(self.tempTaskModel:getList()) do
		self:initTaskMap(taskMO)
	end
end

function Season123TaskModel:initTaskMap(taskMO)
	local listenerParam = Season123Config.instance:getTaskListenerParamCache(taskMO.config)

	if #listenerParam > 1 and taskMO.config.isRewardView == Activity123Enum.TaskRewardViewType then
		local stage = tonumber(listenerParam[1])

		self.stageTaskMap[stage] = self.stageTaskMap[stage] or {}
		self.stageTaskMap[stage][taskMO.id] = taskMO
	else
		self.normalTaskMap[taskMO.id] = taskMO
	end
end

function Season123TaskModel:sortList()
	self.tempTaskModel:sort(Season123TaskModel.sortFunc)
end

function Season123TaskModel.sortFunc(a, b)
	local aValue = a.finishCount >= a.config.maxFinishCount and 3 or a.hasFinished and 1 or 2
	local bValue = b.finishCount >= b.config.maxFinishCount and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	elseif a.config.sortId ~= b.config.sortId then
		return a.config.sortId < b.config.sortId
	else
		return a.config.id < b.config.id
	end
end

function Season123TaskModel:updateInfo(taskInfoList)
	local isChange = false

	if GameUtil.getTabLen(self.tempTaskModel:getList()) == 0 then
		return
	end

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.Season123 then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = Season123Config.instance:getSeason123TaskCo(info.id)

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

			isChange = true
		end
	end

	if isChange then
		self:sortList()
		self:checkRedDot()
	end

	return isChange
end

function Season123TaskModel:refreshList(curTaskType)
	self.curTaskType = curTaskType or self.curTaskType

	local list = {}

	for _, taskMO in pairs(self.tempTaskModel:getList()) do
		local listenerParam = Season123Config.instance:getTaskListenerParamCache(taskMO.config)

		if #listenerParam > 1 and tonumber(listenerParam[1]) == self.curStage and taskMO.config.isRewardView == self.curTaskType then
			table.insert(list, taskMO)
		elseif taskMO.config.isRewardView == Activity123Enum.TaskNormalType and taskMO.config.isRewardView == self.curTaskType then
			table.insert(list, taskMO)
		end
	end

	list = self:checkAndRemovePreposeTask(list)

	local rewardCount = self:getTaskItemRewardCount(list)

	if rewardCount > 1 then
		table.insert(list, 1, {
			id = 0,
			canGetAll = true
		})
	end

	self:setList(list)
	self:saveCurStageAndTaskType()
	self:checkRedDot()
end

function Season123TaskModel:getTaskItemRewardCount(list)
	local count = 0

	for _, taskMo in ipairs(list) do
		if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			count = count + 1
		end
	end

	return count
end

function Season123TaskModel:isTaskFinished(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function Season123TaskModel:checkRedDot()
	local isNormalTaskHaveReward = self:checkTaskHaveReward(self.normalTaskMap)

	self.reddotShowMap[Activity123Enum.TaskRewardViewType] = self:checkTaskHaveReward(self.stageTaskMap[self.curStage])
	self.reddotShowMap[Activity123Enum.TaskNormalType] = isNormalTaskHaveReward
end

function Season123TaskModel:getAllCanGetList()
	local idList = {}
	local taskList = self:getList() or {}

	for _, taskMo in ipairs(taskList) do
		if taskMo.config and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			table.insert(idList, taskMo.id)
		end
	end

	return idList
end

function Season123TaskModel:checkAndRemovePreposeTask(taskList)
	local newTaskList = tabletool.copy(taskList)

	for index, taskMo in ipairs(newTaskList) do
		local preposTaskTab = string.split(taskMo.config.prepose, "#")

		for _, preposTaskId in ipairs(preposTaskTab) do
			local preposTaskMo = self.tempTaskModel:getById(tonumber(preposTaskId))

			if preposTaskMo and not self:isTaskFinished(preposTaskMo) then
				table.remove(newTaskList, index)

				break
			end
		end
	end

	return newTaskList
end

function Season123TaskModel:getDelayPlayTime(mo)
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

function Season123TaskModel:getLocalKey()
	local actId = Season123Model.instance:getCurSeasonId()

	return "Season123Task" .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Season123TaskModel:saveCurStageAndTaskType()
	local saveStr = self.curStage .. "#" .. self.curTaskType

	PlayerPrefsHelper.setString(self:getLocalKey(), saveStr)
end

function Season123TaskModel:initStageAndTaskType()
	local saveStr = PlayerPrefsHelper.getString(self:getLocalKey(), 1 .. "#" .. Activity123Enum.TaskRewardViewType)
	local saveInfo = string.splitToNumber(saveStr, "#")
	local saveStageIndex = saveInfo[1]
	local haveRewardIndexList = self:getHaveRewardTaskIndexList()

	if #haveRewardIndexList > 0 then
		if not haveRewardIndexList[1] then
			local stageIndex = saveStageIndex
			local isNormalTaskHaveReward = self:checkTaskHaveReward(self.normalTaskMap)
			local isRewardTaskHaveReward = self:checkTaskHaveReward(self.stageTaskMap[stageIndex])

			self.curTaskType = isRewardTaskHaveReward and Activity123Enum.TaskRewardViewType or isNormalTaskHaveReward and Activity123Enum.TaskNormalType or Activity123Enum.TaskNormalType
			self.curStage = stageIndex
		end
	end
end

function Season123TaskModel:getHaveRewardTaskIndexList()
	local rewardStageIndexList = {}
	local rewardStafeIndexMap = {}

	for stage = 1, 6 do
		if not self.stageTaskMap[stage] then
			for _, taskMO in pairs(self.stageTaskMap[stage]) do
				if taskMO.progress >= taskMO.config.maxProgress and taskMO.finishCount == 0 then
					table.insert(rewardStageIndexList, stage)

					rewardStafeIndexMap[stage] = true

					break
				end
			end
		end
	end

	return rewardStageIndexList, rewardStafeIndexMap
end

function Season123TaskModel:checkTaskHaveReward(taskList)
	if not taskList then
		return false
	end

	for _, taskMO in pairs(taskList) do
		if taskMO.progress >= taskMO.config.maxProgress and taskMO.finishCount == 0 then
			return true
		end
	end

	return false
end

Season123TaskModel.instance = Season123TaskModel.New()

return Season123TaskModel
