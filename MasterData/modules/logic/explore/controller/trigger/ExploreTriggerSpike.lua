-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerSpike.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerSpike", package.seeall)

local ExploreTriggerSpike = class("ExploreTriggerSpike", ExploreTriggerBase)

function ExploreTriggerSpike:handle(id, unit)
	self:sendTriggerRequest()
end

function ExploreTriggerSpike:onReply(cmd, resultCode, msg)
	self:onDone(true)
end

return ExploreTriggerSpike
