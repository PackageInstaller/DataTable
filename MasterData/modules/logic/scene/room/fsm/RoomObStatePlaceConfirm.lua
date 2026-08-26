-- chunkname: @modules/logic/scene/room/fsm/RoomObStatePlaceConfirm.lua

module("modules.logic.scene.room.fsm.RoomObStatePlaceConfirm", package.seeall)

local RoomObStatePlaceConfirm = class("RoomObStatePlaceConfirm", SimpleFSMBaseState)

function RoomObStatePlaceConfirm:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomObStatePlaceConfirm:onEnter()
	RoomObStatePlaceConfirm.super.onEnter(self)
end

function RoomObStatePlaceConfirm:onLeave()
	RoomObStatePlaceConfirm.super.onLeave(self)
end

function RoomObStatePlaceConfirm:stop()
	return
end

function RoomObStatePlaceConfirm:clear()
	return
end

return RoomObStatePlaceConfirm
