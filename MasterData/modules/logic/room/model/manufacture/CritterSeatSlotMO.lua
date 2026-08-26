-- chunkname: @modules/logic/room/model/manufacture/CritterSeatSlotMO.lua

module("modules.logic.room.model.manufacture.CritterSeatSlotMO", package.seeall)

local CritterSeatSlotMO = pureTable("CritterSeatSlotMO")

function CritterSeatSlotMO:init(seatSlotInfo)
	self._id = seatSlotInfo.critterSlotId
	self._critterUid = seatSlotInfo.critterUid
end

function CritterSeatSlotMO:getSeatSlotId()
	return self._id
end

function CritterSeatSlotMO:getRestingCritter()
	local isEmpty = self:isEmpty()

	if not isEmpty then
		return self._critterUid
	end
end

function CritterSeatSlotMO:isEmpty()
	return (self._critterUid and self._critterUid ~= CritterEnum.InvalidCritterUid and self._critterUid ~= tonumber(CritterEnum.InvalidCritterUid) or nil) and false
end

function CritterSeatSlotMO:removeCritter()
	self._critterUid = CritterEnum.InvalidCritterUid
end

return CritterSeatSlotMO
