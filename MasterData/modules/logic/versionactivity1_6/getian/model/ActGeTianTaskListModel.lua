-- chunkname: @modules/logic/versionactivity1_6/getian/model/ActGeTianTaskListModel.lua

module("modules.logic.versionactivity1_6.getian.model.ActGeTianTaskListModel", package.seeall)

local ActGeTianTaskListModel = class("ActGeTianTaskListModel", ListScrollModel)

function ActGeTianTaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, self.refreshData, self)
end

function ActGeTianTaskListModel:refreshData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleActivity)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = RoleActivityConfig.instance:getActicityTaskList(ActGeTianEnum.ActivityId)

		for _, taskCfg in pairs(taskCfgList) do
			local mo = ActGeTianTaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = ActGeTianTaskMO.New()

		allMO.id = ActGeTianEnum.TaskMOAllFinishId
		allMO.activityId = ActGeTianEnum.ActivityId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, ActGeTianTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function ActGeTianTaskListModel.sortMO(objA, objB)
	local sidxA = ActGeTianTaskListModel.getSortIndex(objA)
	local sidxB = ActGeTianTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function ActGeTianTaskListModel.getSortIndex(objA)
	if objA.id == ActGeTianEnum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function ActGeTianTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function ActGeTianTaskListModel:getRankDiff(mo)
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

function ActGeTianTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function ActGeTianTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == ActGeTianEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= ActGeTianEnum.TaskMOAllFinishId then
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
		local allMO = self:getById(ActGeTianEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, ActGeTianTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function ActGeTianTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= ActGeTianEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

ActGeTianTaskListModel.instance = ActGeTianTaskListModel.New()

return ActGeTianTaskListModel
