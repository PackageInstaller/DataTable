-- chunkname: @modules/logic/college/model/CollegeTaskListModel.lua

module("modules.logic.college.model.CollegeTaskListModel", package.seeall)

local CollegeTaskListModel = class("CollegeTaskListModel", MixScrollModel)
local curStageIndex

function CollegeTaskListModel:initTaskList()
	self._itemStartAnimTime = nil

	local sceneMo = CollegeModel.instance:getSceneMo()
	local taskBox = sceneMo.taskBox
	local taskList = taskBox and taskBox:getTaskList()
	local prop = sceneMo and sceneMo.prop
	local curStage = prop and prop.stage

	curStageIndex = CollegeConfig.instance:getStageSortIndex(curStage)

	self:setList(taskList)
	self:sort(self._sortFunc)
end

function CollegeTaskListModel._sortFunc(aTaskMo, bTaskMo)
	local aTaskCo = aTaskMo and aTaskMo.co
	local bTaskCo = bTaskMo and bTaskMo.co
	local aStageIndex = CollegeConfig.instance:getStageSortIndex(aTaskCo.stageId)
	local bStageIndex = CollegeConfig.instance:getStageSortIndex(bTaskCo.stageId)

	if aStageIndex >= curStageIndex ~= (bStageIndex >= curStageIndex) then
		return aStageIndex >= curStageIndex
	end

	if aStageIndex ~= bStageIndex then
		return aStageIndex < bStageIndex
	end

	local aFinish = aTaskMo.state == CollegeEnum.TaskState.Reward
	local bFinish = bTaskMo.state == CollegeEnum.TaskState.Reward

	if aFinish ~= bFinish then
		return not aFinish
	end

	return aTaskMo.id < bTaskMo.id
end

function CollegeTaskListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local preTaskMo

	for _, mo in ipairs(self:getList()) do
		local type = CollegeEnum.TaskMixType.Other

		if not preTaskMo or mo.co.stageId ~= preTaskMo.co.stageId then
			type = CollegeEnum.TaskMixType.First
		end

		local lineHeight = self:_getTaskItemHeight(scrollGO, type)
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineHeight, nil)

		table.insert(mixCellInfos, mixCellInfo)

		preTaskMo = mo
	end

	return mixCellInfos
end

function CollegeTaskListModel:_getTaskItemHeight(scrollGO, type)
	if gohelper.isNil(scrollGO) then
		return 100
	end

	local taskItemHeight = 100

	if type == CollegeEnum.TaskMixType.First then
		if not self._taskItemHeight then
			local goTag = gohelper.findChild(scrollGO, "Viewport/Content/#go_TaskItem")

			self._taskItemHeight = recthelper.getHeight(goTag.transform)
		end

		taskItemHeight = self._taskItemHeight
	elseif type == CollegeEnum.TaskMixType.Other then
		if not self._taskContentHeight then
			local goTask = gohelper.findChild(scrollGO, "Viewport/Content/#go_TaskItem/#go_normal")

			self._taskContentHeight = recthelper.getHeight(goTask.transform)
		end

		taskItemHeight = self._taskContentHeight
	end

	return taskItemHeight
end

function CollegeTaskListModel:getDelayPlayTime(index)
	if not index or index > 6 then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime
	end

	local delayTime = index * 0.06
	local passTime = curTime - self._itemStartAnimTime

	if delayTime < passTime then
		return -1
	else
		return delayTime - passTime
	end
end

CollegeTaskListModel.instance = CollegeTaskListModel.New()

return CollegeTaskListModel
