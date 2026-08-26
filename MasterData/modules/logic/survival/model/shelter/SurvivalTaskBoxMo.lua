-- chunkname: @modules/logic/survival/model/shelter/SurvivalTaskBoxMo.lua

module("modules.logic.survival.model.shelter.SurvivalTaskBoxMo", package.seeall)

local SurvivalTaskBoxMo = pureTable("SurvivalTaskBoxMo")

function SurvivalTaskBoxMo:init(data)
	self.moduleId = data.moduleId
	self.tasks = {}

	for _, v in ipairs(data.tasks) do
		local taskMo = SurvivalTaskMo.New()

		taskMo:init(v, self.moduleId)

		self.tasks[taskMo.id] = taskMo
	end
end

function SurvivalTaskBoxMo.Create(moduleId)
	local mo = SurvivalTaskBoxMo.New()

	mo.moduleId = moduleId
	mo.tasks = {}

	return mo
end

function SurvivalTaskBoxMo:addOrUpdateTasks(tasks)
	local newTask = false

	for _, task in ipairs(tasks) do
		newTask = self.tasks[task.id] == nil
		self.tasks[task.id] = self.tasks[task.id] or SurvivalTaskMo.New()

		self.tasks[task.id]:init(task, self.moduleId)

		if newTask then
			SurvivalController.instance:tryShowTaskEventPanel(self.moduleId, task.id)
		end
	end
end

function SurvivalTaskBoxMo:removeTasks(taskIds)
	for _, taskId in ipairs(taskIds) do
		if not self.tasks[taskId] then
			logError("任务不存在" .. self.moduleId .. " >> " .. taskId)
		end

		self.tasks[taskId] = nil
	end
end

function SurvivalTaskBoxMo:getTaskInfo(taskId)
	return self.tasks[taskId]
end

return SurvivalTaskBoxMo
