-- chunkname: @modules/logic/qgameplay/behavior/commonnode/EventRegisterQNode.lua

module("modules.logic.qgameplay.behavior.commonnode.EventRegisterQNode", package.seeall)

local EventRegisterQNode = class("EventRegisterQNode", BehaviorQNode)

function EventRegisterQNode:onSetData(controller, event)
	self.controller = controller
	self.event = event
end

function EventRegisterQNode:onExecute()
	self.addEventCb(self, self.controller, self.event, self.onEvent, self)
end

function EventRegisterQNode:onEvent()
	self:done()
end

return EventRegisterQNode
