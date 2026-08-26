-- chunkname: @modules/logic/room/model/manufacture/RoomBuildingCritterMO.lua

module("modules.logic.room.model.manufacture.RoomBuildingCritterMO", package.seeall)

local RoomBuildingCritterMO = pureTable("RoomBuildingCritterMO")

local function SortById(aSeatSlotMO, bSeatSlotMO)
	local aId = aSeatSlotMO and aSeatSlotMO:getSeatSlotId()
	local bId = bSeatSlotMO and bSeatSlotMO:getSeatSlotId()

	if not aId or not bId then
		return false
	end

	return aId < bId
end

function RoomBuildingCritterMO:init(critterBuildingInfo)
	self.id = critterBuildingInfo.buildingUid
	self.uid = self.id

	self:setSeatSlotInfos(critterBuildingInfo.unlockSlotInfos)
end

function RoomBuildingCritterMO:setSeatSlotInfos(seatSlotInfoList)
	self.seatSlotMODict = {}
	self.seatSlotMOList = {}

	if seatSlotInfoList then
		for _, slotInfo in ipairs(seatSlotInfoList) do
			local slotMO = CritterSeatSlotMO.New()

			slotMO:init(slotInfo)

			self.seatSlotMODict[slotInfo.critterSlotId] = slotMO
			self.seatSlotMOList[#self.seatSlotMOList + 1] = slotMO
		end

		table.sort(self.seatSlotMOList, SortById)
	end
end

function RoomBuildingCritterMO:unlockSeatSlot(seatSlotId)
	if self.seatSlotMODict[seatSlotId] then
		return
	end

	local slotMO = CritterSeatSlotMO.New()
	local slotInfo = {
		critterSlotId = seatSlotId
	}

	slotMO:init(slotInfo)

	self.seatSlotMODict[slotInfo.critterSlotId] = slotMO
	self.seatSlotMOList[#self.seatSlotMOList + 1] = slotMO

	table.sort(self.seatSlotMOList, SortById)
end

function RoomBuildingCritterMO:getBuildingUid()
	return self.uid
end

function RoomBuildingCritterMO:getSeatSlotMO(slotId, nilError)
	local result = self.seatSlotMODict[slotId]

	if not result and nilError then
		logError(string.format("RoomBuildingCritterMO:getSeatSlotMO error, slotId:%s", slotId))
	end

	return result
end

function RoomBuildingCritterMO:getSeatSlot2CritterDict()
	local result = {}

	for seatSlotId, seatSlotMO in pairs(self.seatSlotMODict) do
		local isEmpty = seatSlotMO:isEmpty()

		if not isEmpty then
			result[seatSlotId] = seatSlotMO:getRestingCritter()
		end
	end

	return result
end

function RoomBuildingCritterMO:isCritterInSeatSlot(critterUid)
	local result

	for seatSlotId, seatSlotMO in pairs(self.seatSlotMODict) do
		local restingCritterUid = seatSlotMO:getRestingCritter()

		if restingCritterUid and restingCritterUid == critterUid then
			result = seatSlotId

			break
		end
	end

	return result
end

function RoomBuildingCritterMO:getNextEmptyCritterSeatSlot()
	local result

	for _, seatSlotMO in ipairs(self.seatSlotMOList) do
		local isEmpty = seatSlotMO:isEmpty()

		if isEmpty then
			result = seatSlotMO:getSeatSlotId()

			break
		end
	end

	return result
end

function RoomBuildingCritterMO:removeRestingCritter(critterUid)
	local seatSlotId = self:isCritterInSeatSlot(critterUid)
	local seatSlotMO = self:getSeatSlotMO(seatSlotId)

	if seatSlotMO then
		seatSlotMO:removeCritter()
	end
end

return RoomBuildingCritterMO
