-- chunkname: @modules/logic/survival/model/map/SurvivalFollowTaskMo.lua

module("modules.logic.survival.model.map.SurvivalFollowTaskMo", package.seeall)

local SurvivalFollowTaskMo = pureTable("SurvivalFollowTaskMo")

function SurvivalFollowTaskMo:ctor()
	self.type = 1
	self.moduleId = 0
	self.taskId = 0
	self.followUnitUid = 0
end

function SurvivalFollowTaskMo:init(data)
	self.type = data.moduleId == SurvivalEnum.TaskModule.MapMainTarget and 1 or 2
	self.moduleId = data.moduleId
	self.taskId = data.taskId
	self.followUnitUid = data.followUnitUid
end

return SurvivalFollowTaskMo
