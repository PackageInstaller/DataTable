-- chunkname: @modules/logic/scene/room/work/RoomSceneWaitOneFrameWork.lua

module("modules.logic.scene.room.work.RoomSceneWaitOneFrameWork", package.seeall)

local RoomSceneWaitOneFrameWork = class("RoomSceneWaitOneFrameWork", BaseWork)

function RoomSceneWaitOneFrameWork:ctor(scene)
	self._scene = scene
end

function RoomSceneWaitOneFrameWork:onStart()
	TaskDispatcher.runDelay(self._oneFrame, self, 0)
end

function RoomSceneWaitOneFrameWork:_oneFrame()
	self._scene = nil

	self:onDone(true)
end

function RoomSceneWaitOneFrameWork:clearWork()
	self._scene = nil
end

return RoomSceneWaitOneFrameWork
