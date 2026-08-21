-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/model/SpecialtrainingModel.lua

module("logic.extensions.specialtraining.model.SpecialtrainingModel", package.seeall)

local M = class("SpecialtrainingModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._trainPlanId = 0
	self._trainStageList = false
	self._allTaskList = false
	self._reqDone = false
end

function M:onLateInit()
	local taskCoList = SpecialtrainingConfig.instance:getTrainTaskAllCfg()

	for i = 1, #taskCoList do
		SpecialtrainingModel.instance:initTaskData(taskCoList[i].id, 0, false)
	end
end

function M:onReset()
	self._trainPlanId = 0
	self._trainStageList = false
	self._allTaskList = false
	self._reqDone = false
end

function M:getReqDone()
	return self._reqDone
end

function M:getPlans()
	return SpecialtrainingConfig.instance:getTrainPlanCfgAll()
end

function M:updateTrainPlanData(data)
	self._reqDone = true
	self._trainPlanId = data.plan
	self._trainStageList = data.stage
end

function M:initTaskData(taskId, count, isFinish)
	if not self._allTaskList then
		self._allTaskList = {}
	end

	local taskCO = SpecialtrainingConfig.instance:getTrainTaskCfg(taskId)

	if not taskCO then
		return
	end

	local stageId = taskCO.stage

	if not self._allTaskList[stageId] then
		self._allTaskList[stageId] = {}
	end

	local isUpdate, dataMo = self:_hasTaskData(stageId, taskId)

	if isUpdate then
		dataMo:updateData(count, isFinish)

		return
	end

	local taskMo = SpecialtrainingTaskMo.New()

	taskMo:initData(taskId, count, isFinish, taskCO)
	table.insert(self._allTaskList[stageId], taskMo)
end

function M:_hasTaskData(stageId, taskId)
	local list = self._allTaskList[stageId]

	for index, taskMo in pairs(list) do
		if taskMo:getTaskId() == taskId then
			return true, taskMo
		end
	end

	return false, nil
end

function M:getTaskMo(taskId)
	for index, list in pairs(self._allTaskList) do
		for i, v in pairs(list) do
			if v:getTaskId() == taskId then
				return v
			end
		end
	end

	return nil
end

function M:getPlanId()
	return self._trainPlanId
end

function M:getCurrentStageIndex()
	if self._trainStageList then
		return #self._trainStageList + 1
	end

	return 1
end

function M:getCurrentStageId()
	if self._trainPlanId == 0 then
		return 101
	end

	local stageIndex = self:getCurrentStageIndex()
	local planCo = SpecialtrainingConfig.instance:getTrainPlanCfg(self._trainPlanId)
	local stageId = planCo.stages[stageIndex]

	if stageId then
		return stageId
	end

	return planCo.stages[#planCo.stages]
end

function M:getTaskMoList(stageId)
	local taskMoList = {}

	if self._allTaskList then
		taskMoList = self._allTaskList[stageId]

		if not taskMoList then
			return {}
		end
	end

	table.sort(taskMoList, self._sortById)

	return taskMoList
end

function M._sortById(moA, moB)
	return moA:getTaskId() < moB:getTaskId()
end

function M:isShowInMainUI()
	local show = true

	if self._trainPlanId then
		local planCo = SpecialtrainingConfig.instance:getTrainPlanCfg(self._trainPlanId)
		local stageIndex = self:getCurrentStageIndex()

		if planCo and stageIndex > #planCo.stages then
			show = false
		end
	end

	return show
end

function M:showStageRedPoint(stageIndex)
	if stageIndex > self:getCurrentStageIndex() then
		return false
	end

	local planCo = SpecialtrainingConfig.instance:getTrainPlanCfg(self._trainPlanId)
	local stageId = planCo.stages[stageIndex]
	local taskMoList = self:getTaskMoList(stageId)
	local isStageFinish = true

	for i, v in ipairs(taskMoList) do
		if self:_preTaskFinishStatus(v:getPreTask()) and v:canGetReward() and not v:getIsFinish() then
			return true
		end

		if not v:getIsFinish() then
			isStageFinish = false
		end
	end

	if isStageFinish and stageIndex == self:getCurrentStageIndex() then
		return true
	end

	return false
end

function M:_preTaskFinishStatus(taskId)
	local preTaskMo = SpecialtrainingModel.instance:getTaskMo(taskId)
	local isFinish = true

	if preTaskMo then
		isFinish = preTaskMo:getIsFinish()
	end

	return isFinish
end

M.instance = M.New()

return M
