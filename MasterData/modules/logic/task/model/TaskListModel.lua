-- chunkname: @modules/logic/task/model/TaskListModel.lua

module("modules.logic.task.model.TaskListModel", package.seeall)

local TaskListModel = class("TaskListModel", BaseModel)

function TaskListModel:getTaskList(typeId)
	local moList = {}
	local infos = TaskModel.instance:getAllUnlockTasks(typeId)

	if typeId == TaskEnum.TaskType.Novice then
		local lockIds = TaskModel.instance:getCurStageAllLockTaskIds()
		local curStage = TaskModel.instance:getNoviceTaskCurStage()
		local growtasks = {}

		for _, v in pairs(infos) do
			if v.type == TaskEnum.TaskType.Novice then
				if v.config.stage == curStage and v.config.minTypeId == TaskEnum.TaskMinType.Novice and JumpConfig.instance:isOpenJumpId(v.config.jumpId) then
					table.insert(moList, v)
				end

				if v.config.minTypeId == TaskEnum.TaskMinType.GrowBack and JumpConfig.instance:isOpenJumpId(v.config.jumpId) and v.finishCount < v.config.maxFinishCount then
					table.insert(growtasks, v)
				end
			end
		end

		for _, v in ipairs(lockIds) do
			local taskMo = self:fillLockTaskMo(v)

			if JumpConfig.instance:isOpenJumpId(taskMo.config.jumpId) then
				table.insert(moList, taskMo)
			end
		end

		table.sort(moList, function(a, b)
			local aValue = a.finishCount >= a.config.maxFinishCount and 3 or a.hasFinished and 1 or 2
			local bValue = b.finishCount >= b.config.maxFinishCount and 3 or b.hasFinished and 1 or 2

			if aValue ~= bValue then
				return aValue < bValue
			elseif a.config.sortId ~= b.config.sortId then
				return a.config.sortId < b.config.sortId
			else
				return a.config.id < b.config.id
			end
		end)
		table.sort(growtasks, function(a, b)
			return a.config.sortId > b.config.sortId
		end)

		for _, v in ipairs(growtasks) do
			table.insert(moList, 1, v)
		end

		for _, v in ipairs((self:_getCurMainTaskMo(infos))) do
			if JumpConfig.instance:isOpenJumpId(v.config.jumpId) then
				table.insert(moList, 1, v)
			end
		end
	else
		for _, v in pairs(infos) do
			if v.type == typeId then
				local show = true

				if not string.nilorempty(v.config.prepose) then
					local preposes = string.split(v.config.prepose, "#")

					for i, prepose in ipairs(preposes) do
						if not TaskModel.instance:isTaskFinish(v.type, tonumber(prepose)) then
							show = false

							break
						end
					end
				end

				if show then
					table.insert(moList, v)
				end
			end
		end

		table.sort(moList, function(a, b)
			local aValue = a.finishCount >= a.config.maxFinishCount and 3 or a.hasFinished and 1 or 2
			local bValue = b.finishCount >= b.config.maxFinishCount and 3 or b.hasFinished and 1 or 2

			if aValue ~= bValue then
				return aValue < bValue
			elseif a.config.sortId ~= b.config.sortId then
				return a.config.sortId < b.config.sortId
			else
				return a.config.id < b.config.id
			end
		end)
	end

	return moList
end

function TaskListModel:fillLockTaskMo(id)
	local mo = {}

	mo.typeId = 0
	mo.config = TaskConfig.instance:gettaskNoviceConfig(id)
	mo.progress = 0
	mo.hasFinished = false
	mo.finishCount = 0
	mo.type = TaskEnum.TaskType.Novice
	mo.lock = true

	return mo
end

function TaskListModel:_getCurMainTaskMo(infos)
	local mainInfos = {}

	for _, v in pairs(infos) do
		if v.type == TaskEnum.TaskType.Novice and v.config.chapter ~= 0 then
			table.insert(mainInfos, v)
		end
	end

	table.sort(mainInfos, function(a, b)
		return a.config.sortId < b.config.sortId
	end)

	for _, v in ipairs(mainInfos) do
		if not v.config.prepose or v.config.prepose == "" then
			if not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(v.id)) then
				return {
					v
				}
			end
		elseif not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(v.config.id)) and TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(v.config.prepose)) then
			return {
				v
			}
		end
	end

	return {}
end

TaskListModel.instance = TaskListModel.New()

return TaskListModel
