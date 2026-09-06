-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetInnerEvolve.lua

module("logic.extensions.task.model.target.TaskTargetInnerEvolve", package.seeall)

local TaskTargetInnerEvolve = class("TaskTargetInnerEvolve", TaskTargetBase)

function TaskTargetInnerEvolve:ctor(taskStep, target)
	TaskTargetInnerEvolve.super.ctor(self, taskStep, target)

	self.finishedPerformed = {
		animName = "storyconfig/animations/petevolve.txt",
		performedType = TaskConst.PERFORMED_FINISHED,
		method = TaskConst.PM_EVOLVE,
		formPetId = self.target.petIds[1],
		toPetId = self.target.petIds[2]
	}
	self.finishedPerformed.taskStep = self.taskStep
	self.finishedPerformed.target = self
	self.selectPetId = nil
end

function TaskTargetInnerEvolve:getTargetsExtraData()
	if self:isCompeleted() then
		return "{\"f\":1}"
	else
		return "{\"petId\":" .. self.selectPetId .. "}"
	end
end

return TaskTargetInnerEvolve
