-- chunkname: @modules/logic/versionactivity1_7/isolde/model/ActIsoldeTaskListModel.lua

module("modules.logic.versionactivity1_7.isolde.model.ActIsoldeTaskListModel", package.seeall)

local ActIsoldeTaskListModel = class("ActIsoldeTaskListModel", ListScrollModel)

function ActIsoldeTaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, self.refreshData, self)
end

function ActIsoldeTaskListModel:refreshData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleActivity)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = RoleActivityConfig.instance:getActicityTaskList(VersionActivity1_7Enum.ActivityId.Isolde)

		for _, taskCfg in pairs(taskCfgList) do
			local mo = ActIsoldeTaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = ActIsoldeTaskMO.New()

		allMO.id = ActIsoldeEnum.TaskMOAllFinishId
		allMO.activityId = VersionActivity1_7Enum.ActivityId.Isolde

		table.insert(dataList, allMO)
	end

	table.sort(dataList, ActIsoldeTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function ActIsoldeTaskListModel.sortMO(objA, objB)
	local sidxA = ActIsoldeTaskListModel.getSortIndex(objA)
	local sidxB = ActIsoldeTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function ActIsoldeTaskListModel.getSortIndex(objA)
	if objA.id == ActIsoldeEnum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function ActIsoldeTaskListModel:getRankDiff(mo)
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

function ActIsoldeTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function ActIsoldeTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == ActIsoldeEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= ActIsoldeEnum.TaskMOAllFinishId then
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
		local allMO = self:getById(ActIsoldeEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, ActIsoldeTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function ActIsoldeTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= ActIsoldeEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

ActIsoldeTaskListModel.instance = ActIsoldeTaskListModel.New()

return ActIsoldeTaskListModel
