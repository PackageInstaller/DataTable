-- chunkname: @modules/logic/room/model/debug/RoomDebugBuildingMO.lua

module("modules.logic.room.model.debug.RoomDebugBuildingMO", package.seeall)

local RoomDebugBuildingMO = pureTable("RoomDebugBuildingMO")

function RoomDebugBuildingMO:init(info)
	self.id = info.id
	self.buildingId = info.id
	self.config = RoomConfig.instance:getBuildingConfig(self.buildingId)
end

return RoomDebugBuildingMO
