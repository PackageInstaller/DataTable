-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131TaskListModel.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131TaskListModel", package.seeall)

local Activity131TaskListModel = class("Activity131TaskListModel", ListScrollModel)

function Activity131TaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity131
	}, self.refreshData, self)
	self:refreshData()
end

function Activity131TaskListModel:refreshData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity131)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity131Config.instance:getTaskByActId(Activity131Enum.ActivityId.Act131)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity131TaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity131TaskMO.New()

		allMO.id = Activity131Enum.TaskMOAllFinishId
		allMO.activityId = Activity131Enum.ActivityId.Act131

		table.insert(dataList, allMO)
	end

	table.sort(dataList, Activity131TaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function Activity131TaskListModel.sortMO(objA, objB)
	local sidxA = Activity131TaskListModel.getSortIndex(objA)
	local sidxB = Activity131TaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity131TaskListModel.getSortIndex(objA)
	if objA.id == Activity131Enum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function Activity131TaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function Activity131TaskListModel:getRankDiff(mo)
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

function Activity131TaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function Activity131TaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == Activity131Enum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= Activity131Enum.TaskMOAllFinishId then
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
		local allMO = self:getById(Activity131Enum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, Activity131TaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function Activity131TaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= Activity131Enum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

Activity131TaskListModel.instance = Activity131TaskListModel.New()

return Activity131TaskListModel
