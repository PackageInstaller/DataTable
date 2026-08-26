-- chunkname: @modules/logic/task/model/TaskMo.lua

module("modules.logic.task.model.TaskMo", package.seeall)

local TaskMo = pureTable("TaskMo")

function TaskMo:ctor()
	self.id = 0
	self.progress = 0
	self.hasFinished = false
	self.finishCount = 0
	self.config = nil
	self.type = 0
	self.expiryTime = 0
end

function TaskMo:init(info, config)
	self.config = config

	self:update(info)
end

function TaskMo:update(info)
	self.id = info.id
	self.progress = info.progress
	self.hasFinished = info.hasFinished
	self.finishCount = info.finishCount
	self.type = info.type
	self.expiryTime = info.expiryTime
end

function TaskMo:finishTask(id, finishCount)
	if id == self.id then
		self.finishCount = finishCount
		self.hasFinished = true
	end
end

function TaskMo:getMaxFinishCount()
	return (self.config or nil) and (self.config.maxFinishCount or 1)
end

function TaskMo:isClaimed()
	return self.finishCount >= self:getMaxFinishCount()
end

function TaskMo:isClaimable()
	return not self:isClaimed() and self.hasFinished
end

function TaskMo:isFinished()
	return self.hasFinished or self:isClaimed()
end

function TaskMo:isUnfinished()
	return not self:isClaimed() and not self:isClaimable()
end

return TaskMo
