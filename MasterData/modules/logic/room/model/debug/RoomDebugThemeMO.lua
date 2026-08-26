-- chunkname: @modules/logic/room/model/debug/RoomDebugThemeMO.lua

module("modules.logic.room.model.debug.RoomDebugThemeMO", package.seeall)

local RoomDebugThemeMO = pureTable("RoomDebugThemeMO")

function RoomDebugThemeMO:init(_id, cfg)
	self.id = _id
	self.config = cfg or RoomConfig.instance:getThemeConfig(_id)
end

return RoomDebugThemeMO
