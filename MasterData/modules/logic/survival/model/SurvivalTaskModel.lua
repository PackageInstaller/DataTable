-- chunkname: @modules/logic/survival/model/SurvivalTaskModel.lua

module("modules.logic.survival.model.SurvivalTaskModel", package.seeall)

local SurvivalTaskModel = class("SurvivalTaskModel", BaseModel)

function SurvivalTaskModel:initViewParam(moduleId, taskId)
	self.selectTaskType = moduleId or SurvivalEnum.TaskModule.MainTask
	self.selectTaskId = taskId or 0
end

function SurvivalTaskModel:setSelectType(type)
	if type == self.selectTaskType then
		return
	end

	self.selectTaskType = type

	return true
end

function SurvivalTaskModel:getSelectType()
	return self.selectTaskType
end

function SurvivalTaskModel:getTaskFinishedNum(type)
	local list = self:getTaskList(type)
	local num = 0
	local finishNum = 0

	for _, v in pairs(list) do
		if type == SurvivalEnum.TaskModule.SubTask or type == SurvivalEnum.TaskModule.MapMainTarget then
			if v:isFinish() then
				finishNum = finishNum + 1
			end
		elseif not v:isUnFinish() then
			finishNum = finishNum + 1
		end

		num = num + 1
	end

	return finishNum, num
end

function SurvivalTaskModel:getTaskList(type)
	local list = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		local taskBox = weekInfo.taskPanel:getTaskBoxMo(type)

		for _, v in pairs(taskBox.tasks) do
			if not v:isFail() then
				table.insert(list, v)
			end
		end

		if type == SurvivalEnum.TaskModule.MainTask then
			local dict = {}
			local taskIdDict = {}

			for _, v in pairs(list) do
				taskIdDict[v.id] = true

				if v.co then
					dict[v.co.group] = true
				end
			end

			for i, v in ipairs(lua_survival_maintask.configList) do
				if dict[v.group] and not taskIdDict[v.id] then
					local taskMo = SurvivalTaskMo.Create(type, v.id)

					table.insert(list, taskMo)
				end
			end
		end

		if #list > 1 then
			if type == SurvivalEnum.TaskModule.SubTask then
				table.sort(list, SortUtil.tableKeyLower({
					"id",
					"type"
				}))
			elseif type == SurvivalEnum.TaskModule.MainTask then
				table.sort(list, SortUtil.tableKeyLower({
					"group",
					"step",
					"id"
				}))
			elseif type == SurvivalEnum.TaskModule.NormalTask then
				table.sort(list, SortUtil.tableKeyLower({
					"status",
					"id"
				}))
			else
				table.sort(list, SortUtil.keyUpper("id"))
			end
		end
	end

	return list
end

SurvivalTaskModel.instance = SurvivalTaskModel.New()

return SurvivalTaskModel
