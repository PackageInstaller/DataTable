-- chunkname: @modules/logic/activity/model/ActivityType101SpInfoMo.lua

module("modules.logic.activity.model.ActivityType101SpInfoMo", package.seeall)

local ActivityType101SpInfoMo = pureTable("ActivityType101SpInfoMo")
local kState_None = 0
local kState_Available = 1
local kState_Received = 2

function ActivityType101SpInfoMo:ctor()
	self.id = 0
	self.state = kState_None
end

function ActivityType101SpInfoMo:init(act101SpInfo)
	self.id = act101SpInfo.id
	self.state = act101SpInfo.state
end

function ActivityType101SpInfoMo:isNotCompleted()
	return self.state == kState_None
end

function ActivityType101SpInfoMo:isAvailable()
	return self.state == kState_Available
end

function ActivityType101SpInfoMo:isReceived()
	return self.state == kState_Received
end

function ActivityType101SpInfoMo:isNone()
	return self.state == kState_None
end

function ActivityType101SpInfoMo:setState_Received()
	self.state = kState_Received
end

return ActivityType101SpInfoMo
