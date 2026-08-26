-- chunkname: @modules/logic/scene/room/comp/RoomSceneTouchComp.lua

module("modules.logic.scene.room.comp.RoomSceneTouchComp", package.seeall)

local RoomSceneTouchComp = class("RoomSceneTouchComp", BaseSceneComp)

function RoomSceneTouchComp:onInit()
	return
end

function RoomSceneTouchComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	local sceneGO = self._scene.go.sceneGO

	self._touchComp = MonoHelper.addLuaComOnceToGo(sceneGO, RoomTouchComp, sceneGO)
end

function RoomSceneTouchComp:setUIDragScreenScroll(isDragStart)
	if self._touchComp then
		self._touchComp:setUIDragScreenScroll(isDragStart)
	end
end

function RoomSceneTouchComp:onSceneClose()
	self._touchComp = nil
end

return RoomSceneTouchComp
