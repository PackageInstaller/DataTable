-- chunkname: @modules/logic/survival/model/shelter/SurvivalTaskPanelMo.lua

module("modules.logic.survival.model.shelter.SurvivalTaskPanelMo", package.seeall)

local SurvivalTaskPanelMo = pureTable("SurvivalTaskPanelMo")

function SurvivalTaskPanelMo:init(data)
	self.taskBoxs = {}

	for _, v in ipairs(data.boxs) do
		local taskBox = SurvivalTaskBoxMo.New()

		taskBox:init(v)

		self.taskBoxs[taskBox.moduleId] = taskBox
	end
end

function SurvivalTaskPanelMo:getTaskBoxMo(moduleId)
	self.taskBoxs[moduleId] = self.taskBoxs[moduleId] or SurvivalTaskBoxMo.Create(moduleId)

	return self.taskBoxs[moduleId]
end

function SurvivalTaskPanelMo:addOrUpdateTasks(taskBoxs)
	for _, v in ipairs(taskBoxs) do
		local taskBox = self:getTaskBoxMo(v.moduleId)

		taskBox:addOrUpdateTasks(v.tasks)
	end
end

function SurvivalTaskPanelMo:removeTasks(removes)
	for _, v in ipairs(removes) do
		local taskBox = self:getTaskBoxMo(v.moduleId)

		taskBox:removeTasks(v.taskId)
	end
end

return SurvivalTaskPanelMo
