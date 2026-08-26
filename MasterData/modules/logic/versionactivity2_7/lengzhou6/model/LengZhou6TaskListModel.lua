-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LengZhou6TaskListModel.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6TaskListModel", package.seeall)

local LengZhou6TaskListModel = class("LengZhou6TaskListModel", ListScrollModel)

local function _getSortIndex(objA)
	if objA.id == LengZhou6Enum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

local function _sortMO(objA, objB)
	local sidxA = _getSortIndex(objA)
	local sidxB = _getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function LengZhou6TaskListModel:init()
	local dataList = {}
	local rewardCount = 0
	local actId = LengZhou6Model.instance:getAct190Id()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity190)

	if taskDict ~= nil then
		local taskCfgList = LengZhou6Config.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = LengZhou6TaskMo.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = LengZhou6TaskMo.New()

		allMO.id = LengZhou6Enum.TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, _sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function LengZhou6TaskListModel:getRankDiff(mo)
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

function LengZhou6TaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function LengZhou6TaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == LengZhou6Enum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= LengZhou6Enum.TaskMOAllFinishId then
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
		local allMO = self:getById(LengZhou6Enum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, _sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function LengZhou6TaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= LengZhou6Enum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

LengZhou6TaskListModel.instance = LengZhou6TaskListModel.New()

return LengZhou6TaskListModel
