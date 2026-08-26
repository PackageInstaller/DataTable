-- chunkname: @modules/logic/room/controller/RoomSkinEvent.lua

module("modules.logic.room.controller.RoomSkinEvent", package.seeall)

local RoomSkinEvent = _M

RoomSkinEvent.SkinListViewShowChange = 1
RoomSkinEvent.ChangePreviewRoomSkin = 2
RoomSkinEvent.ChangeEquipRoomSkin = 3
RoomSkinEvent.RoomSkinMarkUpdate = 4

return RoomSkinEvent
