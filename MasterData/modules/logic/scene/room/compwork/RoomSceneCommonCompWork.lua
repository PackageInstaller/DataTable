-- chunkname: @modules/logic/scene/room/compwork/RoomSceneCommonCompWork.lua

module("modules.logic.scene.room.compwork.RoomSceneCommonCompWork", package.seeall)

local RoomSceneCommonCompWork = class("RoomSceneCommonCompWork", BaseWork)

function RoomSceneCommonCompWork:ctor(comp)
	self._comp = comp
end

function RoomSceneCommonCompWork:onStart(context)
	local sceneId = context.sceneId
	local levelId = context.levelId

	if not self._comp then
		logError("RoomSceneCommonCompWork: 没有comp")
		self:onDone(true)

		return
	end

	if self._comp.init then
		self._comp:init(sceneId, levelId)
		self:onDone(true)
	else
		logError(string.format("%s: 没有init", self._comp.__cname))
		self:onDone(true)
	end
end

return RoomSceneCommonCompWork
