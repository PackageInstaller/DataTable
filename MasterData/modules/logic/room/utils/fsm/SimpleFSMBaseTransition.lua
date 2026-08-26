-- chunkname: @modules/logic/room/utils/fsm/SimpleFSMBaseTransition.lua

module("modules.logic.room.utils.fsm.SimpleFSMBaseTransition", package.seeall)

local SimpleFSMBaseTransition = class("SimpleFSMBaseTransition")

function SimpleFSMBaseTransition:ctor(fromStateName, toStateName, eventId)
	self.name = string.format("%s_to_%s_by_%s", fromStateName, toStateName, eventId)
	self.fromStateName = fromStateName
	self.toStateName = toStateName
	self.eventId = eventId
	self.fsm = nil
	self.context = nil
end

function SimpleFSMBaseTransition:register(fsm, context)
	self.fsm = fsm
	self.context = context
end

function SimpleFSMBaseTransition:onDone()
	self.fsm:endTransition(self.toStateName)
end

function SimpleFSMBaseTransition:start()
	return
end

function SimpleFSMBaseTransition:check()
	return true
end

function SimpleFSMBaseTransition:onStart(param)
	self:onDone()
end

function SimpleFSMBaseTransition:stop()
	return
end

function SimpleFSMBaseTransition:clear()
	return
end

return SimpleFSMBaseTransition
