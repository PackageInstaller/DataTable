-- chunkname: @modules/logic/scene/room/fsm/RoomEditStatePlaceConfirm.lua

module("modules.logic.scene.room.fsm.RoomEditStatePlaceConfirm", package.seeall)

local RoomEditStatePlaceConfirm = class("RoomEditStatePlaceConfirm", SimpleFSMBaseState)

function RoomEditStatePlaceConfirm:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomEditStatePlaceConfirm:onEnter()
	RoomEditStatePlaceConfirm.super.onEnter(self)
end

function RoomEditStatePlaceConfirm:onLeave()
	RoomEditStatePlaceConfirm.super.onLeave(self)
end

function RoomEditStatePlaceConfirm:stop()
	return
end

function RoomEditStatePlaceConfirm:clear()
	return
end

return RoomEditStatePlaceConfirm
