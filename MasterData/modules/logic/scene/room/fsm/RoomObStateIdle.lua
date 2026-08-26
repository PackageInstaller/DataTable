-- chunkname: @modules/logic/scene/room/fsm/RoomObStateIdle.lua

module("modules.logic.scene.room.fsm.RoomObStateIdle", package.seeall)

local RoomObStateIdle = class("RoomObStateIdle", SimpleFSMBaseState)

function RoomObStateIdle:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomObStateIdle:onEnter()
	RoomObStateIdle.super.onEnter(self)
end

function RoomObStateIdle:onLeave()
	RoomObStateIdle.super.onLeave(self)
end

function RoomObStateIdle:stop()
	return
end

function RoomObStateIdle:clear()
	return
end

return RoomObStateIdle
