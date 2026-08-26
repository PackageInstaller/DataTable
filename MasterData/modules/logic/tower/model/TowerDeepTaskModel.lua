-- chunkname: @modules/logic/tower/model/TowerDeepTaskModel.lua

module("modules.logic.tower.model.TowerDeepTaskModel", package.seeall)

local TowerDeepTaskModel = class("TowerDeepTaskModel", MixScrollModel)

function TowerDeepTaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.ColumnCount = 1
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0
	self.AnimRowCount = 6
	self.succRwardTaskMo = nil

	self:reInit()
end

function TowerDeepTaskModel:reInit()
	self.tempTaskModel:clear()
	self:clear()

	self.taskList = {}
end

function TowerDeepTaskModel:setTaskInfoList()
	local list = {}
	local succRewardTaskId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.RewardTaskId)
	local taskMoDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.TowerPermanentDeep) or {}

	for taskId, taskMo in pairs(taskMoDict) do
		if not taskMo.config then
			local config = TowerDeepConfig.instance:getTaskConfig(taskMo.id)

			if not config then
				logError("爬塔深层任务配置表id不存在,请检查: " .. tostring(taskMo.id))
			end

			taskMo.init(taskMo, taskMo, config)
		end

		if taskMo.id == succRewardTaskId then
			self.succRwardTaskMo = taskMo
		else
			table.insert(list, taskMo)
		end
	end

	self.tempTaskModel:setList(list)
	self:sortList()
end

function TowerDeepTaskModel:updateTaskInfo(taskInfoList)
	local isChange = false

	if GameUtil.getTabLen(self.tempTaskModel:getList()) == 0 then
		return
	end

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.TowerPermanentDeep then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = TowerDeepConfig.instance:getTaskConfig(info.id)

				if config then
					mo = TaskMo.New()

					mo:init(info, config)
					self.tempTaskModel:addAtLast(mo)
				else
					logError("爬塔深层任务配置表id不存在: " .. tostring(info.id))
				end
			else
				mo:update(info)
			end

			isChange = true
		end
	end

	if isChange then
		self:sortList()
	end

	return isChange
end

function TowerDeepTaskModel:sortList()
	if tabletool.len(self.tempTaskModel:getList()) > 0 then
		table.sort(self.tempTaskModel:getList(), TowerDeepTaskModel.sortFunc)
	end
end

function TowerDeepTaskModel.sortFunc(a, b)
	local aValue = a.progress >= a.config.maxProgress and a.finishCount > 0 and 3 or a.hasFinished and 1 or 2
	local bValue = b.progress >= b.config.maxProgress and b.finishCount > 0 and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function TowerDeepTaskModel:refreshList()
	local list = tabletool.copy(self.tempTaskModel:getList())
	local rewardCount = self:getTaskItemCanGetCount(list)

	if rewardCount > 1 then
		table.insert(list, 1, {
			id = 0,
			canGetAll = true
		})
	end

	self:setList(list)
	TowerController.instance:dispatchEvent(TowerEvent.TowerDeepRefreshTask)
end

function TowerDeepTaskModel:getAllCanGetList()
	local idList = {}

	for _, taskMo in ipairs(self.tempTaskModel:getList()) do
		if taskMo.config and self:isTaskCanGet(taskMo) then
			table.insert(idList, taskMo.id)
		end
	end

	return idList
end

function TowerDeepTaskModel:getTaskItemCanGetCount(list)
	local count = 0

	for _, taskMo in pairs(list) do
		if self:isTaskCanGet(taskMo) then
			count = count + 1
		end
	end

	return count
end

function TowerDeepTaskModel:isTaskFinished(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function TowerDeepTaskModel:isTaskCanGet(taskMo)
	return taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0
end

function TowerDeepTaskModel:getSuccRewardTaskMo()
	return self.succRwardTaskMo
end

function TowerDeepTaskModel:isSuccRewardHasGet()
	return self.succRwardTaskMo and self:isTaskFinished(self.succRwardTaskMo)
end

function TowerDeepTaskModel:getDelayPlayTime(mo)
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

TowerDeepTaskModel.instance = TowerDeepTaskModel.New()

return TowerDeepTaskModel
