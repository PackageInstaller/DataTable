-- chunkname: @modules/logic/room/model/map/RoomShowDegreeMO.lua

module("modules.logic.room.model.map.RoomShowDegreeMO", package.seeall)

local RoomShowDegreeMO = pureTable("RoomShowDegreeMO")

function RoomShowDegreeMO:init(id, degreeType, name)
	self.id = id
	self.degreeType = degreeType or 1
	self.degree = 0
	self.count = 0
	self.name = name or ""
end

function RoomShowDegreeMO:getCount()
	return self.count
end

return RoomShowDegreeMO
