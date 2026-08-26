-- chunkname: @modules/logic/scene/room/compwork/RoomSceneWaitEventCompWork.lua

module("modules.logic.scene.room.compwork.RoomSceneWaitEventCompWork", package.seeall)

local RoomSceneWaitEventCompWork = class("RoomSceneWaitEventCompWork", BaseWork)

function RoomSceneWaitEventCompWork:ctor(comp, event)
	self._comp = comp
	self._event = event
end

function RoomSceneWaitEventCompWork:onStart(context)
	local sceneId = context.sceneId
	local levelId = context.levelId

	if not self._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")
		self:onDone(true)

		return
	end

	if self._comp.init then
		self._comp:registerCallback(self._event, self._onEvent, self)
		self._comp:init(sceneId, levelId)
	else
		logError(string.format("%s: 没有init", self._comp.__cname))
		self:onDone(true)
	end
end

function RoomSceneWaitEventCompWork:_onEvent()
	if not self._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	self._comp:unregisterCallback(self._event, self._onEvent, self)
	self:onDone(true)
end

function RoomSceneWaitEventCompWork:onDestroy()
	RoomSceneWaitEventCompWork.super.onDestroy(self)

	if not self._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	self._comp:unregisterCallback(self._event, self._onEvent, self)
end

return RoomSceneWaitEventCompWork
