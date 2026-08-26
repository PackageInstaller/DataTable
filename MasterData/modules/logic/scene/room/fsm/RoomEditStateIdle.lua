-- chunkname: @modules/logic/scene/room/fsm/RoomEditStateIdle.lua

module("modules.logic.scene.room.fsm.RoomEditStateIdle", package.seeall)

local RoomEditStateIdle = class("RoomEditStateIdle", SimpleFSMBaseState)

function RoomEditStateIdle:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomEditStateIdle:onEnter()
	RoomEditStateIdle.super.onEnter(self)
end

function RoomEditStateIdle:onLeave()
	RoomEditStateIdle.super.onLeave(self)
end

function RoomEditStateIdle:stop()
	return
end

function RoomEditStateIdle:clear()
	return
end

return RoomEditStateIdle
