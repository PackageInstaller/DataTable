-- chunkname: @modules/logic/room/model/critter/RoomTrainSlotMO.lua

module("modules.logic.room.model.critter.RoomTrainSlotMO", package.seeall)

local RoomTrainSlotMO = pureTable("RoomTrainSlotMO")

function RoomTrainSlotMO:init(info)
	self.id = info.id
	self.isLock = info.isLock
end

function RoomTrainSlotMO:setCritterMO(critterMO)
	self.critterMO = critterMO
end

function RoomTrainSlotMO:setWaitingCritterUid(critterUid)
	self.waitingTrainUid = critterUid
end

function RoomTrainSlotMO:isFree()
	if not self.isLock and self.critterMO == nil then
		return true
	end
end

return RoomTrainSlotMO
