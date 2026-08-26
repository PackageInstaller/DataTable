-- chunkname: @modules/logic/activity/model/warmup/ActivityWarmUpTaskListModel.lua

module("modules.logic.activity.model.warmup.ActivityWarmUpTaskListModel", package.seeall)

local ActivityWarmUpTaskListModel = class("ActivityWarmUpTaskListModel", ListScrollModel)

function ActivityWarmUpTaskListModel:init(actId)
	self._totalDict = self._totalDict or {}

	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity106)
	local taskCfgs = Activity106Config.instance:getTaskByActId(actId)
	local data = {}

	if taskDict ~= nil then
		for _, taskCO in ipairs(taskCfgs) do
			local taskId = taskCO.id
			local taskMO = taskDict[taskId]

			if taskMO ~= nil then
				local mo = self._totalDict[taskId]

				if not mo then
					mo = ActivityWarmUpTaskMO.New()
					self._totalDict[taskId] = mo
				end

				mo:init(taskMO, taskCO)
				table.insert(data, mo)
			end
		end

		table.sort(data, ActivityWarmUpTaskListModel.sortMO)
	end

	self._totalDatas = data

	self:groupByDay()
end

function ActivityWarmUpTaskListModel.sortMO(objA, objB)
	local alreadyGotA = objA:alreadyGotReward()
	local alreadyGotB = objB:alreadyGotReward()

	if alreadyGotA ~= alreadyGotB then
		return alreadyGotB
	else
		local finishA = objA:isFinished()
		local finishB = objB:isFinished()

		if finishA ~= finishB then
			return finishA
		end
	end

	return objA.id < objB.id
end

function ActivityWarmUpTaskListModel:setSelectedDay(day)
	self._selectDay = day
end

function ActivityWarmUpTaskListModel:updateDayList()
	local datas = self._taskGroup[self:getSelectedDay()]

	if datas then
		self:setList(datas)
	end
end

function ActivityWarmUpTaskListModel:getSelectedDay()
	return self._selectDay
end

function ActivityWarmUpTaskListModel:groupByDay()
	self._taskGroup = {}

	local taskList = self._totalDatas

	if not taskList then
		return
	end

	for _, taskMO in ipairs(taskList) do
		local day = taskMO.config.openDay

		self._taskGroup[day] = self._taskGroup[day] or {}

		table.insert(self._taskGroup[day], taskMO)
	end
end

function ActivityWarmUpTaskListModel:dayHasReward(day)
	local list = self._taskGroup[day]

	if list then
		for _, mo in ipairs(list) do
			if not mo:alreadyGotReward() and mo:isFinished() then
				return true
			end
		end
	end

	return false
end

function ActivityWarmUpTaskListModel:release()
	self._totalDict = nil
	self._totalDatas = nil
	self._taskGroup = nil
end

ActivityWarmUpTaskListModel.instance = ActivityWarmUpTaskListModel.New()

return ActivityWarmUpTaskListModel
