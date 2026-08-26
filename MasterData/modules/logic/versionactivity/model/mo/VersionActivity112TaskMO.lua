-- chunkname: @modules/logic/versionactivity/model/mo/VersionActivity112TaskMO.lua

module("modules.logic.versionactivity.model.mo.VersionActivity112TaskMO", package.seeall)

local VersionActivity112TaskMO = pureTable("VersionActivity112TaskMO")

function VersionActivity112TaskMO:init(config, id)
	self.actId = config.activityId
	self.id = config.taskId
	self.config = config
	self.progress = 0
	self.hasGetBonus = false
end

function VersionActivity112TaskMO:update(taskInfo)
	self.progress = taskInfo.progress
	self.hasGetBonus = taskInfo.hasGetBonus
end

function VersionActivity112TaskMO:canGetBonus()
	return self.hasGetBonus == false and self.config.maxProgress <= self.progress
end

return VersionActivity112TaskMO
