-- chunkname: @modules/logic/versionactivity1_8/weila/model/ActWeilaTaskListModel.lua

module("modules.logic.versionactivity1_8.weila.model.ActWeilaTaskListModel", package.seeall)

local ActWeilaTaskListModel = class("ActWeilaTaskListModel", ListScrollModel)

function ActWeilaTaskListModel:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, self.refreshData, self)
end

function ActWeilaTaskListModel:refreshData()
	local taskList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.RoleActivity, VersionActivity1_8Enum.ActivityId.Weila)
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

	table.sort(dataList, ActWeilaTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function ActWeilaTaskListModel.sortMO(objA, objB)
	local sidxA = ActWeilaTaskListModel.getSortIndex(objA)
	local sidxB = ActWeilaTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function ActWeilaTaskListModel.getSortIndex(mo)
	if mo.id == 0 then
		return 1
	elseif mo.finishCount > 0 or mo.preFinish then
		return 100
	elseif mo.hasFinished then
		return 2
	end

	return 50
end

function ActWeilaTaskListModel:getRankDiff(mo)
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

function ActWeilaTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function ActWeilaTaskListModel:preFinish(mo)
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

		table.sort(taskMOList, ActWeilaTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function ActWeilaTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO.hasFinished then
			count = count + 1
		end
	end

	return count
end

ActWeilaTaskListModel.instance = ActWeilaTaskListModel.New()

return ActWeilaTaskListModel
