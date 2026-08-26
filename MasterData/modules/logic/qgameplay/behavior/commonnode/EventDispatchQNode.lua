-- chunkname: @modules/logic/qgameplay/behavior/commonnode/EventDispatchQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.EventDispatchQNode", package.seeall)

local EventDispatchQNode = class("EventDispatchQNode", BehaviorQNode)

function EventDispatchQNode:onSetData(controller, event, ...)
	self.controller = controller
	self.event = event
	self.params = {
		...
	}
end

function EventDispatchQNode:onExecute()
	self.controller:dispatchEvent(self.event, unpack(self.params))
	self:done()
end

return EventDispatchQNode
