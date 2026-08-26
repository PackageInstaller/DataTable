-- chunkname: @modules/logic/room/model/debug/RoomDebugPackageMO.lua

module("modules.logic.room.model.debug.RoomDebugPackageMO", package.seeall)

local RoomDebugPackageMO = pureTable("RoomDebugPackageMO")

function RoomDebugPackageMO:init(info)
	self.id = info.id
	self.blockId = info.id
	self.packageId = info.packageId
	self.packageOrder = info.packageOrder
	self.defineId = info.defineId
	self.config = RoomConfig.instance:getBlockDefineConfig(self.defineId)
end

return RoomDebugPackageMO
