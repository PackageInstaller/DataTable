-- chunkname: @modules/logic/activity/model/ActivityType101InfoMo.lua

module("modules.logic.activity.model.ActivityType101InfoMo", package.seeall)

local ActivityType101InfoMo = pureTable("ActivityType101InfoMo")

function ActivityType101InfoMo:ctor()
	self.id = 0
	self.state = 0
end

function ActivityType101InfoMo:init(info)
	self.id = info.id
	self.state = info.state
end

return ActivityType101InfoMo
