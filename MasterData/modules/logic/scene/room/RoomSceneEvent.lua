-- chunkname: @modules/logic/scene/room/RoomSceneEvent.lua

module("modules.logic.scene.room.RoomSceneEvent", package.seeall)

local RoomSceneEvent = _M

RoomSceneEvent.TryPlaceBlock = 1001
RoomSceneEvent.ConfirmPlaceBlock = 1002
RoomSceneEvent.CancelPlaceBlock = 1003
RoomSceneEvent.TryBackBlock = 1011
RoomSceneEvent.ConfirmBackBlock = 1012
RoomSceneEvent.CancelBackBlock = 1013
RoomSceneEvent.EnterWaterReform = 1015
RoomSceneEvent.CloseWaterReform = 1016
RoomSceneEvent.TryPlaceBuilding = 2001
RoomSceneEvent.ConfirmPlaceBuilding = 2002
RoomSceneEvent.CancelPlaceBuilding = 2003
RoomSceneEvent.UnUseBuilding = 2004
RoomSceneEvent.TryPlaceCharacter = 3001
RoomSceneEvent.ConfirmPlaceCharacter = 3002
RoomSceneEvent.CancelPlaceCharacter = 3003
RoomSceneEvent.UnUseCharacter = 3004
RoomSceneEvent.CharacterBuildingShowTime = 4001

return RoomSceneEvent
