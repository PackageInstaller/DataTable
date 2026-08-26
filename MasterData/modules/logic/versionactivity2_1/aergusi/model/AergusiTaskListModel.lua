-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiTaskListModel.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiTaskListModel", package.seeall)

local AergusiTaskListModel = class("AergusiTaskListModel", ListScrollModel)

function AergusiTaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity163
	}, self.refreshData, self)
	self:refreshData()
end

function AergusiTaskListModel:refreshData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity163)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = AergusiConfig.instance:getTaskByActId(VersionActivity2_1Enum.ActivityId.Aergusi)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = AergusiTaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = AergusiTaskMO.New()

		allMO.id = AergusiEnum.TaskMOAllFinishId
		allMO.activityId = VersionActivity2_1Enum.ActivityId.Aergusi

		table.insert(dataList, allMO)
	end

	table.sort(dataList, AergusiTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function AergusiTaskListModel.sortMO(objA, objB)
	local sidxA = AergusiTaskListModel.getSortIndex(objA)
	local sidxB = AergusiTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function AergusiTaskListModel.getSortIndex(objA)
	if objA.id == AergusiEnum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function AergusiTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function AergusiTaskListModel:getRankDiff(mo)
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

function AergusiTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function AergusiTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == AergusiEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= AergusiEnum.TaskMOAllFinishId then
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
		local allMO = self:getById(AergusiEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, AergusiTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function AergusiTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= AergusiEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

function AergusiTaskListModel:setAniDisable(disable)
	self._disableAni = disable
end

function AergusiTaskListModel:getAniDisableState()
	return self._disableAni
end

AergusiTaskListModel.instance = AergusiTaskListModel.New()

return AergusiTaskListModel
