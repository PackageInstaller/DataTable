-- chunkname: @modules/logic/scene/room/comp/RoomSceneLevelComp.lua

module("modules.logic.scene.room.comp.RoomSceneLevelComp", package.seeall)

local RoomSceneLevelComp = class("RoomSceneLevelComp", CommonSceneLevelComp)

function RoomSceneLevelComp:init(sceneId, levelId)
	self:loadLevel(levelId)
end

function RoomSceneLevelComp:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

return RoomSceneLevelComp
