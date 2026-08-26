-- chunkname: @modules/logic/room/utils/fsm/SimpleFSMBaseState.lua

module("modules.logic.room.utils.fsm.SimpleFSMBaseState", package.seeall)

local SimpleFSMBaseState = class("SimpleFSMBaseState")

function SimpleFSMBaseState:ctor(name)
	self.name = name
	self.fsm = nil
	self.context = nil
end

function SimpleFSMBaseState:register(fsm, context)
	self.fsm = fsm
	self.context = context
end

function SimpleFSMBaseState:start()
	return
end

function SimpleFSMBaseState:onEnter()
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMEnterState, self.name)
end

function SimpleFSMBaseState:onLeave()
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMLeaveState, self.name)
end

function SimpleFSMBaseState:stop()
	return
end

function SimpleFSMBaseState:clear()
	return
end

return SimpleFSMBaseState
