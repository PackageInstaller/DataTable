-- chunkname: @modules/logic/scene/room/fsm/RoomEditStateBackConfirm.lua

local RoomEditStateBackConfirm = class("RoomEditStateBackConfirm", SimpleFSMBaseState)

function RoomEditStateBackConfirm:start()
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomEditStateBackConfirm:onEnter()
	RoomEditStateBackConfirm.super.onEnter(self)
end

function RoomEditStateBackConfirm:onLeave()
	RoomEditStateBackConfirm.super.onLeave(self)
end

function RoomEditStateBackConfirm:stop()
	return
end

function RoomEditStateBackConfirm:clear()
	return
end

return RoomEditStateBackConfirm
