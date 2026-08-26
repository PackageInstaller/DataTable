-- chunkname: @modules/logic/scene/room/fsm/action/RoomBaseFsmAction.lua

module("modules.logic.scene.room.fsm.action.RoomBaseFsmAction", package.seeall)

local RoomBaseFsmAction = class("RoomBaseFsmAction")

function RoomBaseFsmAction:ctor(fsmTransition)
	self.fsmTransition = fsmTransition
end

function RoomBaseFsmAction:start(param)
	self._scene = GameSceneMgr.instance:getCurScene()

	self:onStart(param)
end

function RoomBaseFsmAction:onStart(param)
	return
end

function RoomBaseFsmAction:stop()
	return
end

function RoomBaseFsmAction:clear()
	return
end

return RoomBaseFsmAction
