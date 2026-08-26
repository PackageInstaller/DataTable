-- chunkname: @modules/logic/room/controller/RoomHandBookEvent.lua

module("modules.logic.room.controller.RoomHandBookEvent", package.seeall)

local RoomHandBookEvent = _M
local _get = GameUtil.getUniqueTb()

RoomHandBookEvent.onClickHandBookItem = _get()
RoomHandBookEvent.refreshBack = _get()
RoomHandBookEvent.reverseIcon = _get()
RoomHandBookEvent.showMutate = _get()

return RoomHandBookEvent
