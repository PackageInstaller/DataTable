-- chunkname: @modules/logic/room/controller/RoomBlockGiftEvent.lua

module("modules.logic.room.controller.RoomBlockGiftEvent", package.seeall)

local RoomBlockGiftEvent = _M

RoomBlockGiftEvent.OnSelect = 1
RoomBlockGiftEvent.OnSortTheme = 2
RoomBlockGiftEvent.OnStartDragItem = 3
RoomBlockGiftEvent.OnDragingItem = 4
RoomBlockGiftEvent.OnEndDragItem = 5

return RoomBlockGiftEvent
