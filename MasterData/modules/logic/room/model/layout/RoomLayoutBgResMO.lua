-- chunkname: @modules/logic/room/model/layout/RoomLayoutBgResMO.lua

module("modules.logic.room.model.layout.RoomLayoutBgResMO", package.seeall)

local RoomLayoutBgResMO = pureTable("RoomLayoutBgResMO")

function RoomLayoutBgResMO:init(id, config)
	self.id = id
	self.config = config
end

function RoomLayoutBgResMO:getName()
	return self.config and self.config.name
end

function RoomLayoutBgResMO:getResPath()
	return self.config and self.config.coverResPath
end

return RoomLayoutBgResMO
