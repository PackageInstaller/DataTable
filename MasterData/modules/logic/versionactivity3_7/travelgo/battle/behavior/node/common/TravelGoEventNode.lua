-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoEventNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoEventNode", package.seeall)

local TravelGoEventNode = class("TravelGoEventNode", TravelGoBehaviorNode)

function TravelGoEventNode:onSetData(data)
	self.controller = data.func
	self.event = data.event
end

function TravelGoEventNode:onEnable()
	self.controller.instance:registerCallback(self.event, self.onEvent, self)
end

function TravelGoEventNode:onEvent()
	self:done()
end

function TravelGoEventNode:onDisable()
	self.controller.instance:unregisterCallback(self.event, self.onEvent, self)
end

return TravelGoEventNode
