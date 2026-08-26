-- chunkname: @modules/logic/act189/model/Activity189_TaskListModel.lua

module("modules.logic.act189.model.Activity189_TaskListModel", package.seeall)

local Activity189_TaskListModel = class("Activity189_TaskListModel", ListScrollModel)
local ts = table.sort
local ti = table.insert

function Activity189_TaskListModel:setTaskList(activityId)
	self._taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, activityId)

	local isLimitDict = {}

	for _, v in ipairs(self._taskMoList) do
		local isLimited = false
		local CO = v.config
		local openLimitActId = CO.openLimitActId
		local jumpId = CO.jumpId
		local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

		if openLimitActId > 0 then
			isLimited = ActivityHelper.getActivityStatusAndToast(openLimitActId, true) ~= ActivityEnum.ActivityStatus.Normal
		end

		if jumpConfig and not isLimited then
			local canJump = JumpController.instance:canJumpNew(jumpConfig.param)

			isLimited = not canJump
		end

		isLimitDict[v.id] = isLimited
	end

	ts(self._taskMoList, function(a, b)
		local a_hasFinished = a.hasFinished and 1 or 0
		local b_hasFinished = b.hasFinished and 1 or 0

		if a_hasFinished ~= b_hasFinished then
			return b_hasFinished < a_hasFinished
		end

		local a_isLimited = isLimitDict[a.id] and 1 or 0
		local b_isLimited = isLimitDict[b.id] and 1 or 0

		if a_isLimited ~= b_isLimited then
			return a_isLimited < b_isLimited
		end

		local a_isClaimed = a:isClaimed() and 1 or 0
		local b_isClaimed = b:isClaimed() and 1 or 0

		if a_isClaimed ~= b_isClaimed then
			return a_isClaimed < b_isClaimed
		end

		local a_CO = a.config
		local b_CO = b.config
		local a_sorting = a_CO.sorting
		local b_sorting = b_CO.sorting

		if a_sorting ~= b_sorting then
			return a_sorting < b_sorting
		end

		return a.id < b.id
	end)
	self:setList(self._taskMoList)
end

function Activity189_TaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if false and finishTaskCount > 1 then
		local moList = tabletool.copy(self._taskMoList)

		ti(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self._taskMoList)
	end
end

function Activity189_TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + 1
		end
	end

	return count
end

function Activity189_TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo:getMaxFinishCount() then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function Activity189_TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo:isClaimed() then
			count = count + 1
		end
	end

	return count
end

function Activity189_TaskListModel:getTaskMoListByActivityId(activityId)
	self:setTaskList(activityId)

	return self._taskMoList
end

Activity189_TaskListModel.instance = Activity189_TaskListModel.New()

return Activity189_TaskListModel
