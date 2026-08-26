-- chunkname: @modules/logic/room/model/common/RoomThemeMO.lua

module("modules.logic.room.model.common.RoomThemeMO", package.seeall)

local RoomThemeMO = pureTable("RoomThemeMO")

function RoomThemeMO:init(_id, cfg)
	self.id = _id
	self.config = cfg or RoomConfig.instance:getThemeConfig(_id)
end

return RoomThemeMO
