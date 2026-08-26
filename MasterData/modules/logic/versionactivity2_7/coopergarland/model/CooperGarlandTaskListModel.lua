-- chunkname: @modules/logic/versionactivity2_7/coopergarland/model/CooperGarlandTaskListModel.lua

module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandTaskListModel", package.seeall)

local CooperGarlandTaskListModel = class("CooperGarlandTaskListModel", ListScrollModel)

local function _getSortIndex(objA)
	if objA.id == CooperGarlandEnum.Const.TaskMOAllFinishId then
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

function CooperGarlandTaskListModel:init()
	local dataList = {}
	local rewardCount = 0
	local actId = CooperGarlandModel.instance:getAct192Id()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity192)

	if taskDict ~= nil then
		local taskCfgList = CooperGarlandConfig.instance:getTaskList(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = CooperGarlandTaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = CooperGarlandTaskMO.New()

		allMO.id = CooperGarlandEnum.Const.TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, _sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function CooperGarlandTaskListModel:getRankDiff(mo)
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

function CooperGarlandTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function CooperGarlandTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == CooperGarlandEnum.Const.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= CooperGarlandEnum.Const.TaskMOAllFinishId then
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
		local allMO = self:getById(CooperGarlandEnum.Const.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, _sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function CooperGarlandTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= CooperGarlandEnum.Const.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

CooperGarlandTaskListModel.instance = CooperGarlandTaskListModel.New()

return CooperGarlandTaskListModel
