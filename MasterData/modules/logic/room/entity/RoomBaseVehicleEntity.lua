-- chunkname: @modules/logic/room/entity/RoomBaseVehicleEntity.lua

module("modules.logic.room.entity.RoomBaseVehicleEntity", package.seeall)

local RoomBaseVehicleEntity = class("RoomBaseVehicleEntity", RoomBaseEntity)

function RoomBaseVehicleEntity:ctor(entityId)
	RoomBaseVehicleEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
	self._pathfindingEnabled = false
end

return RoomBaseVehicleEntity
