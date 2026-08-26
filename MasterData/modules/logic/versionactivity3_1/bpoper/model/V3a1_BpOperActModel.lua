-- chunkname: @modules/logic/versionactivity3_1/bpoper/model/V3a1_BpOperActModel.lua

module("modules.logic.versionactivity3_1.bpoper.model.V3a1_BpOperActModel", package.seeall)

local V3a1_BpOperActModel = class("V3a1_BpOperActModel", BaseModel)

function V3a1_BpOperActModel:onInit()
	self:reInit()
end

function V3a1_BpOperActModel:reInit()
	return
end

function V3a1_BpOperActModel:isTaskFinished(taskId)
	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.finishCount > 0
end

function V3a1_BpOperActModel:isAllTaskFinihshed()
	local taskIds = self:getAllShowTask()

	for _, taskId in pairs(taskIds) do
		local isFinished = self:isTaskFinished(taskId)

		if not isFinished then
			return false
		end
	end

	return true
end

function V3a1_BpOperActModel:getNextTaskId(taskId)
	local taskCos = V3a1_BpOperActConfig.instance:getTaskCos()

	for _, taskCo in pairs(taskCos) do
		if not LuaUtil.isEmptyStr(taskCo.prepose) and taskId == tonumber(taskCo.prepose) then
			return taskCo.id
		end
	end

	return 0
end

function V3a1_BpOperActModel:getAllShowTask()
	local taskList = {}
	local taskMos = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.BpOperAct)

	for _, taskMo in pairs(taskMos) do
		local curActId = BpModel.instance:getCurVersionOperActId()
		local taskCo = V3a1_BpOperActConfig.instance:getTaskCO(taskMo.id)

		if taskCo and taskCo.activityId == curActId then
			local isFinished = self:isTaskFinished(taskMo.id)

			if isFinished then
				table.insert(taskList, taskMo.id)
			elseif LuaUtil.isEmptyStr(taskCo.prepose) then
				table.insert(taskList, taskMo.id)
			else
				local isPreFinished = self:isTaskFinished(tonumber(taskCo.prepose))

				if isPreFinished then
					table.insert(taskList, taskMo.id)
				end
			end
		end
	end

	if #taskList < 2 then
		return taskList
	end

	table.sort(taskList, function(a, b)
		local aTaskMo = TaskModel.instance:getTaskById(a)
		local bTaskMo = TaskModel.instance:getTaskById(b)
		local aCo = V3a1_BpOperActConfig.instance:getTaskCO(a)
		local bCo = V3a1_BpOperActConfig.instance:getTaskCO(b)
		local aValue = aTaskMo.finishCount > 0 and 3 or aTaskMo.progress >= aCo.maxProgress and 1 or 2
		local bValue = bTaskMo.finishCount > 0 and 3 or bTaskMo.progress >= bCo.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		elseif aCo.sortId ~= bCo.sortId then
			return aCo.sortId < bCo.sortId
		else
			return aCo.id < bCo.id
		end
	end)

	return taskList
end

V3a1_BpOperActModel.instance = V3a1_BpOperActModel.New()

return V3a1_BpOperActModel
