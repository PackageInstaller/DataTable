-- chunkname: @modules/logic/task/model/TaskActivityMo.lua

module("modules.logic.task.model.TaskActivityMo", package.seeall)

local TaskActivityMo = pureTable("TaskActivityMo")

function TaskActivityMo:ctor()
	self.typeId = 0
	self.defineId = 0
	self.value = 0
	self.gainValue = 0
	self.expiryTime = 0
	self.config = nil
end

function TaskActivityMo:init(info, config)
	self:update(info)

	self.config = config
end

function TaskActivityMo:update(info)
	self.typeId = info.typeId
	self.defineId = info.defineId
	self.value = info.value
	self.gainValue = info.gainValue
	self.expiryTime = info.expiryTime
end

function TaskActivityMo:getbonus(typeId, defineId)
	if typeId == self.typeId then
		self.defineId = defineId
		self.gainValue = self.gainValue + self.config.needActivity
	end
end

return TaskActivityMo
