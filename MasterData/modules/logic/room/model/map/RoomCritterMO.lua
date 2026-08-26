-- chunkname: @modules/logic/room/model/map/RoomCritterMO.lua

module("modules.logic.room.model.map.RoomCritterMO", package.seeall)

local RoomCritterMO = pureTable("RoomCritterMO")

function RoomCritterMO:init(info)
	self.id = info.uid
	self.uid = info.uid
	self.critterId = info.critterId or info.defineId
	self.skinId = info.skinId
	self.currentPosition = info.currentPosition
	self.heroId = info.heroId or nil
	self.characterId = info.characterId or nil
end

function RoomCritterMO:initWithBuildingValue(critterUid, stayBuildingUid, stayBuildingSlotId)
	self.id = critterUid
	self.uid = critterUid

	local critterMO = CritterModel.instance:getCritterMOByUid(self.id)

	self.critterId = critterMO and critterMO.defineId
	self.skinId = critterMO and critterMO:getSkinId()
	self.stayBuildingUid = stayBuildingUid
	self.stayBuildingSlotId = stayBuildingSlotId
end

function RoomCritterMO:setIsRestCritter(isRest)
	self._isRestCritter = isRest
end

function RoomCritterMO:getId()
	return self.id
end

function RoomCritterMO:getSkinId()
	local result = self.skinId

	if not result then
		local critterUid = self:getId()

		result = CritterModel.instance:getCritterSkinId(critterUid)
	end

	return result
end

function RoomCritterMO:getCurrentPosition()
	return self.currentPosition
end

function RoomCritterMO:getStayBuilding()
	return self.stayBuildingUid, self.stayBuildingSlotId
end

function RoomCritterMO:isRestingCritter()
	local result = false
	local seatSlotId

	if self._isRestCritter then
		result = true
	else
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.stayBuildingUid)

		seatSlotId = buildingMO and buildingMO:isCritterInSeatSlot(self.uid)
		result = not not seatSlotId
	end

	return result, seatSlotId
end

function RoomCritterMO:getSpecialRate()
	local rate = CritterConfig.instance:getCritterSpecialRate(self.critterId)

	return rate / 1000
end

return RoomCritterMO
