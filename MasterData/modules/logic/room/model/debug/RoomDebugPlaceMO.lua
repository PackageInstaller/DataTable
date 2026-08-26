-- chunkname: @modules/logic/room/model/debug/RoomDebugPlaceMO.lua

module("modules.logic.room.model.debug.RoomDebugPlaceMO", package.seeall)

local RoomDebugPlaceMO = pureTable("RoomDebugPlaceMO")

function RoomDebugPlaceMO:init(info)
	self.id = info.id
	self.defineId = info.id
	self.blockId = info.blockId
	self.config = RoomConfig.instance:getBlockDefineConfig(self.defineId)
end

return RoomDebugPlaceMO
