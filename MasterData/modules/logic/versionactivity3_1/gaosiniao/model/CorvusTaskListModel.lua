-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/CorvusTaskListModel.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.CorvusTaskListModel", package.seeall)

local CorvusTaskListModel = class("CorvusTaskListModel", ListScrollModel)

function CorvusTaskListModel:_getTaskMoList(taskType, actId)
	assert(taskType)
	assert(actId)

	local taskMoList = TaskModel.instance:getTaskMoList(taskType, actId)

	table.sort(taskMoList, function(a, b)
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

	return taskMoList
end

function CorvusTaskListModel:setTaskList(taskType, actId)
	self._taskMoList = self:_getTaskMoList(taskType, actId)

	self:setList(self._taskMoList)

	self._hasGetAllFlag = false
end

function CorvusTaskListModel:setTaskListWithGetAll(taskType, actId)
	self._taskMoList = self:_getTaskMoList(taskType, actId)

	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		table.insert(self._taskMoList, 1, {
			getAll = true
		})
	end

	self:setList(self._taskMoList)

	self._hasGetAllFlag = true
end

function CorvusTaskListModel:refreshList(hasGetAll)
	if hasGetAll == nil then
		hasGetAll = self._hasGetAllFlag
	end

	local finishTaskCount = self:getFinishTaskCount()

	if hasGetAll and finishTaskCount > 1 then
		local moList = tabletool.copy(self._taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self._taskMoList)
	end
end

function CorvusTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + 1
		end
	end

	return count
end

function CorvusTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function CorvusTaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo:isClaimed() then
			count = count + 1
		end
	end

	return count
end

CorvusTaskListModel.instance = CorvusTaskListModel.New()

return CorvusTaskListModel
