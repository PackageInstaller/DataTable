-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/model/Activity164TaskListModel.lua

module("modules.logic.versionactivity2_1.lanshoupa.model.Activity164TaskListModel", package.seeall)

local Activity164TaskListModel = class("Activity164TaskListModel", ListScrollModel)

function Activity164TaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity164)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity164Config.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity164TaskMO.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity164TaskMO.New()

		allMO.id = LanShouPaEnum.TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, Activity164TaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function Activity164TaskListModel.sortMO(objA, objB)
	local sidxA = Activity164TaskListModel.getSortIndex(objA)
	local sidxB = Activity164TaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity164TaskListModel.getSortIndex(objA)
	if objA.id == LanShouPaEnum.TaskMOAllFinishId then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function Activity164TaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function Activity164TaskListModel:getRankDiff(mo)
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

function Activity164TaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function Activity164TaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == LanShouPaEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= LanShouPaEnum.TaskMOAllFinishId then
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
		local allMO = self:getById(LanShouPaEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, Activity164TaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function Activity164TaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= LanShouPaEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

Activity164TaskListModel.instance = Activity164TaskListModel.New()

return Activity164TaskListModel
