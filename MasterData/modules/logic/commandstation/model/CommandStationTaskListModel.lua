-- chunkname: @modules/logic/commandstation/model/CommandStationTaskListModel.lua

module("modules.logic.commandstation.model.CommandStationTaskListModel", package.seeall)

local CommandStationTaskListModel = class("CommandStationTaskListModel", ListScrollModel)

function CommandStationTaskListModel:ctor()
	self.allNormalTaskMos = {}
	self.allCatchTaskMos = {}
	self.curSelectType = 1

	CommandStationTaskListModel.super.ctor(self)
end

function CommandStationTaskListModel:isCatchTaskType()
	return self.curSelectType == CommandStationEnum.TaskType.Catch
end

function CommandStationTaskListModel:initServerData(tasks, catchTasks)
	self.allNormalTaskMos = {}
	self.allCatchTaskMos = {}

	for _, task in ipairs(tasks) do
		local taskCo = lua_copost_version_task.configDict[task.id]

		if taskCo then
			local taskMo = TaskMo.New()

			taskMo:init(task, taskCo)
			table.insert(self.allNormalTaskMos, taskMo)
		else
			logError("指挥部任务ID不存在" .. task.id)
		end
	end

	for _, task in ipairs(catchTasks) do
		local taskCo = lua_copost_catch_task.configDict[task.id]

		if taskCo then
			local taskMo = TaskMo.New()

			taskMo:init(task, taskCo)
			table.insert(self.allCatchTaskMos, taskMo)
		else
			logError("指挥部任务ID不存在" .. task.id)
		end
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnTaskUpdate)
end

function CommandStationTaskListModel:init()
	local isNormal = self.curSelectType == 1

	if isNormal then
		if not self.allNormalTaskMos then
			local taskDict = self.allCatchTaskMos
			local dataList = {}
			local rewardCount = 0

			if taskDict ~= nil then
				for _, taskMo in ipairs(taskDict) do
					local mo = isNormal and CommandStationTaskMo.New() or CommandStationCatchTaskMo.New()

					mo:init(taskMo.config, taskMo)

					if mo:alreadyGotReward() and not mo:isFinished() then
						rewardCount = rewardCount + 1
					end

					table.insert(dataList, mo)
				end
			end

			if rewardCount > 1 then
				local allMO = isNormal and CommandStationTaskMo.New() or CommandStationCatchTaskMo.New()

				allMO.id = -99999

				table.insert(dataList, allMO)
			end

			table.sort(dataList, CommandStationTaskListModel.sortMO)

			self._hasRankDiff = false

			self:setList(dataList)
		end
	end
end

function CommandStationTaskListModel.sortMO(objA, objB)
	local sidxA = CommandStationTaskListModel.getSortIndex(objA)
	local sidxB = CommandStationTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function CommandStationTaskListModel.getSortIndex(objA)
	if objA.id == -99999 then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	local actStatus = objA:getActivityStatus()

	if actStatus and actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return 80
	end

	return 50
end

function CommandStationTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function CommandStationTaskListModel:getRankDiff(mo)
	if self._hasRankDiff and mo then
		local oldIdx = tabletool.indexOf(self._idIdxList, mo.id)
		local curIdx = self:getIndex(mo)

		if oldIdx and curIdx then
			self._idIdxList[oldIdx] = -2

			return curIdx - oldIdx
		end
	end

	return 0
end

function CommandStationTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function CommandStationTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == -99999 then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= -99999 then
				tempMO.preFinish = true
				isCanSort = true
				preCount = preCount + 1
			end
		end
	elseif taskMO:alreadyGotReward() then
		taskMO.preFinish = true
		isCanSort = true
		preCount = preCount + 1
	end

	if isCanSort then
		local allMO = self:getById(-99999)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, CommandStationTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function CommandStationTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= -99999 then
			count = count + 1
		end
	end

	return count
end

CommandStationTaskListModel.instance = CommandStationTaskListModel.New()

return CommandStationTaskListModel
