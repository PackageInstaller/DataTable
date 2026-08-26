-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerItem.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerItem", package.seeall)

local ExploreTriggerItem = class("ExploreTriggerItem", ExploreTriggerBase)

function ExploreTriggerItem:handle(param, unit)
	ExploreRpc.instance:sendExploreItemInteractRequest(unit.id, param, self.onRequestCallBack, self)
end

function ExploreTriggerItem:onReply(cmd, resultCode, msg)
	if resultCode == 0 then
		self:onDone(true)
	end
end

return ExploreTriggerItem
