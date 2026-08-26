-- chunkname: @modules/logic/versionactivity2_6/xugouji/model/Activity188TaskListModel.lua

module("modules.logic.versionactivity2_6.xugouji.model.Activity188TaskListModel", package.seeall)

local Activity188TaskListModel = class("Activity188TaskListModel", ListScrollModel)

function Activity188TaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity188)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity188Config.instance:getTaskList(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity188TaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity188TaskMO.New()

		allMO.id = LoperaEnum.TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, Activity188TaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function Activity188TaskListModel.sortMO(objA, objB)
	local sidxA = Activity188TaskListModel.getSortIndex(objA)
	local sidxB = Activity188TaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity188TaskListModel.getSortIndex(objA)
	if objA.id == XugoujiEnum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function Activity188TaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function Activity188TaskListModel:getRankDiff(mo)
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

function Activity188TaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function Activity188TaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == XugoujiEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= XugoujiEnum.TaskMOAllFinishId then
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
		local allMO = self:getById(XugoujiEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, Activity188TaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function Activity188TaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= XugoujiEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

Activity188TaskListModel.instance = Activity188TaskListModel.New()

return Activity188TaskListModel
