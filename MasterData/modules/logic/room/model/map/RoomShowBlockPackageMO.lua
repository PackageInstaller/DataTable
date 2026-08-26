-- chunkname: @modules/logic/room/model/map/RoomShowBlockPackageMO.lua

module("modules.logic.room.model.map.RoomShowBlockPackageMO", package.seeall)

local RoomShowBlockPackageMO = pureTable("RoomShowBlockPackageMO")

function RoomShowBlockPackageMO:init(packageId, num, rare)
	self.id = packageId
	self.packageId = packageId
	self.num = num or 0
	self.rare = rare or 0
end

return RoomShowBlockPackageMO
