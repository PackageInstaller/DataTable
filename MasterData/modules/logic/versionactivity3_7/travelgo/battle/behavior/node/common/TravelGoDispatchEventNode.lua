-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/common/TravelGoDispatchEventNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.common.TravelGoDispatchEventNode", package.seeall)

local TravelGoDispatchEventNode = class("TravelGoDispatchEventNode", TravelGoBehaviorNode)

function TravelGoDispatchEventNode:onSetData(data)
	self.controller = data.controller
	self.event = data.event
	self.param = data.param
end

function TravelGoDispatchEventNode:onEnable()
	if self.param then
		self.controller:dispatchEvent(self.event, unpack(self.param))
	else
		self.controller:dispatchEvent(self.event)
	end

	self:done()
end

function TravelGoDispatchEventNode:onDisable()
	return
end

return TravelGoDispatchEventNode
