-- chunkname: @modules/logic/room/model/transport/quicklink/RoomTransportNodeMO.lua

module("modules.logic.room.model.transport.quicklink.RoomTransportNodeMO", package.seeall)

local RoomTransportNodeMO = pureTable("RoomTransportNodeMO")

function RoomTransportNodeMO:init(hexPoint)
	self.hexPoint = hexPoint

	self:resetParam()
end

function RoomTransportNodeMO:resetParam()
	self.isBuilding = false
	self.linkNum = 0
	self.searchIndex = -1
	self.isBlock = false
	self.isSelectPath = false
end

return RoomTransportNodeMO
