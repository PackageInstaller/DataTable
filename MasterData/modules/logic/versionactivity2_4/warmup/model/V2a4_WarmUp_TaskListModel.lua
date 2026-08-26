-- chunkname: @modules/logic/versionactivity2_4/warmup/model/V2a4_WarmUp_TaskListModel.lua

module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUp_TaskListModel", package.seeall)

local V2a4_WarmUp_TaskListModel = class("V2a4_WarmUp_TaskListModel", ListScrollModel)

function V2a4_WarmUp_TaskListModel:setTaskList()
	self._taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, V2a4_WarmUpConfig.instance:actId())

	table.sort(self._taskMoList, function(a, b)
		local a_sorting = a.config.sorting
		local b_sorting = b.config.sorting
		local a_hasFinished = a.hasFinished and 1 or 0
		local b_hasFinished = b.hasFinished and 1 or 0

		if a_hasFinished ~= b_hasFinished then
			return b_hasFinished < a_hasFinished
		end

		local a_isClaimed = a:isClaimed() and 1 or 0
		local b_isClaimed = b:isClaimed() and 1 or 0

		if a_isClaimed ~= b_isClaimed then
			return a_isClaimed < b_isClaimed
		end

		if a_sorting ~= b_sorting then
			return a_sorting < b_sorting
		end

		return a.id < b.id
	end)
	self:setList(self._taskMoList)
end

function V2a4_WarmUp_TaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if false and finishTaskCount > 1 then
		local moList = tabletool.copy(self._taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self._taskMoList)
	end
end

function V2a4_WarmUp_TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + 1
		end
	end

	return count
end

function V2a4_WarmUp_TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function V2a4_WarmUp_TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo:isClaimed() then
			count = count + 1
		end
	end

	return count
end

V2a4_WarmUp_TaskListModel.instance = V2a4_WarmUp_TaskListModel.New()

return V2a4_WarmUp_TaskListModel
