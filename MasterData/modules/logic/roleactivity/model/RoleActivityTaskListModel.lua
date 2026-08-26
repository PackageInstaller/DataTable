-- chunkname: @modules/logic/roleactivity/model/RoleActivityTaskListModel.lua

module("modules.logic.roleactivity.model.RoleActivityTaskListModel", package.seeall)

local RoleActivityTaskListModel = class("RoleActivityTaskListModel", ListScrollModel)

function RoleActivityTaskListModel:init(actId)
	self.actId = actId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, self.refreshData, self)
end

function RoleActivityTaskListModel:refreshData()
	local taskList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.RoleActivity, self.actId)
	local dataList = {}
	local rewardCount = 0

	for _, mo in ipairs(taskList) do
		if mo.hasFinished then
			rewardCount = rewardCount + 1
		end

		table.insert(dataList, mo)
	end

	if rewardCount > 1 then
		table.insert(dataList, TaskMo.New())
	end

	table.sort(dataList, RoleActivityTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function RoleActivityTaskListModel.sortMO(objA, objB)
	local sidxA = RoleActivityTaskListModel.getSortIndex(objA)
	local sidxB = RoleActivityTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function RoleActivityTaskListModel.getSortIndex(mo)
	if mo.id == 0 then
		return 1
	elseif mo.finishCount > 0 or mo.preFinish then
		return 100
	elseif mo.hasFinished then
		return 2
	end

	return 50
end

function RoleActivityTaskListModel:getRankDiff(mo)
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

function RoleActivityTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function RoleActivityTaskListModel:preFinish(mo)
	if not mo then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if mo.id == 0 then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO.hasFinished and tempMO.id ~= 0 then
				tempMO.preFinish = true
				isCanSort = true
				preCount = preCount + 1
			end
		end
	elseif mo.hasFinished then
		mo.preFinish = true
		isCanSort = true
		preCount = preCount + 1
	end

	if isCanSort then
		local allMO = self:getById(0)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, RoleActivityTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function RoleActivityTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO.hasFinished then
			count = count + 1
		end
	end

	return count
end

function RoleActivityTaskListModel:getActivityId()
	return self.actId
end

function RoleActivityTaskListModel:clearData()
	self.actId = nil

	self:clear()
end

RoleActivityTaskListModel.instance = RoleActivityTaskListModel.New()

return RoleActivityTaskListModel
