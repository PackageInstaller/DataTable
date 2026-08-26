-- chunkname: @modules/logic/survival/model/shelter/SurvivalTaskMo.lua

module("modules.logic.survival.model.shelter.SurvivalTaskMo", package.seeall)

local SurvivalTaskMo = pureTable("SurvivalTaskMo")

function SurvivalTaskMo:init(data, moduleId)
	self.id = data.id
	self.status = data.status
	self.progress = data.progress
	self.moduleId = moduleId
	self.co = SurvivalConfig.instance:getTaskCo(self.moduleId, self.id)
end

function SurvivalTaskMo.Create(moduleId, taskId)
	local mo = SurvivalTaskMo.New()

	mo.id = taskId
	mo.moduleId = moduleId
	mo.status = SurvivalEnum.TaskStatus.Doing
	mo.progress = 0
	mo.co = SurvivalConfig.instance:getTaskCo(moduleId, taskId)

	return mo
end

function SurvivalTaskMo:isCangetReward()
	return self.status == SurvivalEnum.TaskStatus.Done
end

function SurvivalTaskMo:isFinish()
	return self.status == SurvivalEnum.TaskStatus.Finish or self.status == SurvivalEnum.TaskStatus.Fail
end

function SurvivalTaskMo:isUnFinish()
	return self.status == SurvivalEnum.TaskStatus.Doing
end

function SurvivalTaskMo:isFail()
	return self.status == SurvivalEnum.TaskStatus.Fail
end

function SurvivalTaskMo:getName()
	return self.co and self.co.desc
end

function SurvivalTaskMo:getDesc()
	return self.co and self.co.desc2
end

function SurvivalTaskMo:setTaskFinish()
	self.status = SurvivalEnum.TaskStatus.Finish
end

return SurvivalTaskMo
