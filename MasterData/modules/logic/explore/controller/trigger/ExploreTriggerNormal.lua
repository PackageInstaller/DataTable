-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerNormal.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerNormal", package.seeall)

local ExploreTriggerNormal = class("ExploreTriggerNormal", ExploreTriggerBase)

function ExploreTriggerNormal:handle(id, unit)
	self:sendTriggerRequest()
end

function ExploreTriggerNormal:onReply(cmd, resultCode, msg)
	self:onDone(true)
end

return ExploreTriggerNormal
