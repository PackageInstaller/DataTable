-- chunkname: @modules/logic/versionactivity1_4/act130/model/Activity130TaskListModel.lua

module("modules.logic.versionactivity1_4.act130.model.Activity130TaskListModel", package.seeall)

local Activity130TaskListModel = class("Activity130TaskListModel", ListScrollModel)

function Activity130TaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity130
	}, self.refreshData, self)
end

function Activity130TaskListModel:refreshData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity130)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity130Config.instance:getTaskByActId(Activity130Enum.ActivityId.Act130)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity130TaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity130TaskMO.New()

		allMO.id = Activity130Enum.TaskMOAllFinishId
		allMO.activityId = Activity130Enum.ActivityId.Act130

		table.insert(dataList, allMO)
	end

	table.sort(dataList, Activity130TaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function Activity130TaskListModel.sortMO(objA, objB)
	local sidxA = Activity130TaskListModel.getSortIndex(objA)
	local sidxB = Activity130TaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity130TaskListModel.getSortIndex(objA)
	if objA.id == Activity130Enum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function Activity130TaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function Activity130TaskListModel:getRankDiff(mo)
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

function Activity130TaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function Activity130TaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == Activity130Enum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= Activity130Enum.TaskMOAllFinishId then
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
		local allMO = self:getById(Activity130Enum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, Activity130TaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function Activity130TaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= Activity130Enum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

Activity130TaskListModel.instance = Activity130TaskListModel.New()

return Activity130TaskListModel
