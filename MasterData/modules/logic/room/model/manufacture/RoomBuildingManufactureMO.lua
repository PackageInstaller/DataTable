-- chunkname: @modules/logic/room/model/manufacture/RoomBuildingManufactureMO.lua

module("modules.logic.room.model.manufacture.RoomBuildingManufactureMO", package.seeall)

local RoomBuildingManufactureMO = pureTable("RoomBuildingManufactureMO")

local function _sortByPriority(aSlotMO, bSlotMO)
	local aPriority = aSlotMO:getSlotPriority()
	local bPriority = bSlotMO:getSlotPriority()

	return aPriority < bPriority
end

function RoomBuildingManufactureMO:init(manufactureInfo)
	self.id = manufactureInfo.buildingUid
	self.uid = self.id

	self:setSlotInfos(manufactureInfo.slotInfos)
	self:setWorkCritterInfoList(manufactureInfo.critterInfos, true)
end

function RoomBuildingManufactureMO:setSlotInfos(slotInfoList)
	self.slotMODict = {}
	self.slotMOList = {}

	if slotInfoList then
		for _, slotInfo in ipairs(slotInfoList) do
			local slotId = slotInfo.slotId
			local slotMO = ManufactureSlotMO.New()

			slotMO:init(slotInfo)

			self.slotMODict[slotId] = slotMO
			self.slotMOList[#self.slotMOList + 1] = slotMO
		end

		table.sort(self.slotMOList, _sortByPriority)
	end

	self:setNeedMatDict()
end

function RoomBuildingManufactureMO:setWorkCritterInfoList(critterInfoList, isClearAll)
	if isClearAll then
		self:clearAllWorkCritterInfo()
	end

	if critterInfoList then
		for _, critterInfo in ipairs(critterInfoList) do
			self:setWorkCritterInfo(critterInfo)
		end
	end
end

function RoomBuildingManufactureMO:setWorkCritterInfo(critterInfo)
	if not self._critterWorkInfo then
		self:clearAllWorkCritterInfo()
	end

	local critterUid = critterInfo.critterUid
	local critterSlotId = critterInfo.critterSlotId

	if critterUid and critterUid ~= CritterEnum.InvalidCritterUid then
		self._critterWorkInfo.slotDict[critterSlotId] = critterUid
		self._critterWorkInfo.critterDict[critterUid] = critterSlotId
	else
		self:removeWorkCritterInfo(critterSlotId)
	end
end

function RoomBuildingManufactureMO:removeWorkCritterInfo(critterSlotId)
	if not self._critterWorkInfo or not critterSlotId then
		return
	end

	local oldCritterUid = self._critterWorkInfo.slotDict[critterSlotId]

	self._critterWorkInfo.slotDict[critterSlotId] = nil

	if oldCritterUid then
		self._critterWorkInfo.critterDict[oldCritterUid] = nil
	end
end

function RoomBuildingManufactureMO:clearAllWorkCritterInfo()
	self._critterWorkInfo = {
		slotDict = {},
		critterDict = {}
	}
end

function RoomBuildingManufactureMO:setNeedMatDict()
	self._needMatDict = {}

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.id)
	local buildingType = RoomConfig.instance:getBuildingType(buildingMO and buildingMO.buildingId)

	if buildingType == RoomBuildingEnum.BuildingType.Process or buildingType == RoomBuildingEnum.BuildingType.Manufacture then
		for _, slotMO in pairs(self.slotMODict) do
			local manufactureItemId = slotMO:getSlotManufactureItemId()

			if manufactureItemId and manufactureItemId ~= 0 then
				local matList = ManufactureConfig.instance:getNeedMatItemList(manufactureItemId)

				for _, matData in ipairs(matList) do
					local matManuItemId = matData.id
					local itemId = ManufactureConfig.instance:getItemId(matManuItemId)
					local needQuantity = matData.quantity

					self._needMatDict[itemId] = needQuantity + (self._needMatDict[itemId] or 0)
				end
			end
		end
	end
end

function RoomBuildingManufactureMO:getBuildingUid()
	return self.uid
end

function RoomBuildingManufactureMO:getManufactureState()
	local result = RoomManufactureEnum.ManufactureState.Wait

	for _, slotMO in pairs(self.slotMODict) do
		local slotState = slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.Running then
			result = RoomManufactureEnum.ManufactureState.Running

			break
		end

		if slotState == RoomManufactureEnum.SlotState.Stop then
			result = RoomManufactureEnum.ManufactureState.Stop
		end
	end

	return result
end

function RoomBuildingManufactureMO:getManufactureProgress()
	local totalNeedTime = 0
	local totalElapsedTime = 0
	local totalRemainSecTime = 0

	for _, slotMO in pairs(self.slotMODict) do
		local elapsedTime = slotMO:getElapsedTime()

		totalElapsedTime = totalElapsedTime + elapsedTime

		local manufactureItemId = slotMO:getSlotManufactureItemId()

		totalNeedTime = totalNeedTime + ((manufactureItemId and manufactureItemId ~= 0 or nil) and ManufactureConfig.instance:getNeedTime(manufactureItemId))

		local remainSecTime = slotMO:getSlotRemainSecTime()

		totalRemainSecTime = totalRemainSecTime + remainSecTime
	end

	local progress = totalElapsedTime / totalNeedTime
	local strRemainTime = TimeUtil.second2TimeString(totalRemainSecTime, true)

	return progress, strRemainTime
end

function RoomBuildingManufactureMO:getSlotMO(slotId, nilError)
	local result = self.slotMODict[slotId]

	if not result and nilError then
		logError(string.format("RoomBuildingManufactureMO:getSlotMO error, slotId:%s", slotId))
	end

	return result
end

function RoomBuildingManufactureMO:getAllUnlockedSlotMOList()
	return self.slotMOList or {}
end

function RoomBuildingManufactureMO:getAllUnlockedSlotIdList()
	local result = {}
	local allSlotMOList = self:getAllUnlockedSlotMOList()

	for i, slotMO in ipairs(allSlotMOList) do
		result[i] = slotMO:getSlotId()
	end

	return result
end

function RoomBuildingManufactureMO:getOccupySlotCount(notComplete)
	local result = 0

	for _, slotMO in pairs(self.slotMODict) do
		local manufactureItemId = slotMO:getSlotManufactureItemId()

		if manufactureItemId and manufactureItemId ~= 0 then
			if notComplete then
				local slotState = slotMO:getSlotState()
				local isComplete = slotState == RoomManufactureEnum.SlotState.Complete

				if not isComplete then
					result = result + 1
				end
			else
				result = result + 1
			end
		end
	end

	return result
end

function RoomBuildingManufactureMO:getSlotIdInProgress()
	local result

	for _, slotMO in pairs(self.slotMODict) do
		local slotState = slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.Running then
			result = slotMO:getSlotId()

			break
		end
	end

	return result
end

function RoomBuildingManufactureMO:getCanChangeMaxPriority()
	local result

	if self.slotMODict then
		for _, slotMO in pairs(self.slotMODict) do
			local slotState = slotMO:getSlotState()

			if slotState == RoomManufactureEnum.SlotState.Running or slotState == RoomManufactureEnum.SlotState.Stop or slotState == RoomManufactureEnum.SlotState.Wait then
				local priority = slotMO:getSlotPriority()

				if not result or result < priority then
					result = priority
				end
			end
		end
	end

	return result
end

function RoomBuildingManufactureMO:isHasCompletedProduction()
	local result = false

	for _, slotMO in pairs(self.slotMODict) do
		local slotState = slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.Complete then
			result = true

			break
		end
	end

	return result
end

function RoomBuildingManufactureMO:getNewerCompleteManufactureItem()
	local result, maxPriority

	for _, slotMO in pairs(self.slotMODict) do
		local slotState = slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.Complete then
			local priority = slotMO:getSlotPriority()

			if not maxPriority or maxPriority < priority then
				maxPriority = priority
				result = slotMO:getSlotManufactureItemId()
			end
		end
	end

	return result
end

function RoomBuildingManufactureMO:getManufactureItemFinishCount(manufactureItemId, checkComplete, getSameItemCount)
	local result = 0
	local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

	for _, slotMO in pairs(self.slotMODict) do
		local isTargetManufactureItem = false
		local slotManufactureItemId = slotMO:getSlotManufactureItemId()

		if getSameItemCount then
			if slotManufactureItemId and slotManufactureItemId ~= 0 then
				local slotItemId = ManufactureConfig.instance:getItemId(slotManufactureItemId)

				isTargetManufactureItem = itemId == slotItemId
			end
		else
			isTargetManufactureItem = slotManufactureItemId == manufactureItemId
		end

		if isTargetManufactureItem then
			local slotState = slotMO:getSlotState()
			local isCanAddCount = not checkComplete or slotState == RoomManufactureEnum.SlotState.Complete

			if isCanAddCount then
				local finishCount = slotMO:getFinishCount()

				result = result + finishCount
			end

			if not getSameItemCount then
				break
			end
		end
	end

	return result
end

function RoomBuildingManufactureMO:getWorkingCritter(critterSlotId)
	local result

	return (self._critterWorkInfo and self._critterWorkInfo.slotDict or nil) and self._critterWorkInfo.slotDict[critterSlotId]
end

function RoomBuildingManufactureMO:getCritterWorkSlot(critterUid)
	local result

	return (self._critterWorkInfo and self._critterWorkInfo.critterDict or nil) and self._critterWorkInfo.critterDict[critterUid]
end

function RoomBuildingManufactureMO:getSlot2CritterDict()
	local result

	return (self._critterWorkInfo and self._critterWorkInfo.slotDict or nil) and tabletool.copy(self._critterWorkInfo.slotDict)
end

function RoomBuildingManufactureMO:getEmptySlotIdList()
	local result = {}
	local allSlotMOList = self:getAllUnlockedSlotMOList()

	for _, slotMO in ipairs(allSlotMOList) do
		local slotState = slotMO and slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.None then
			result[#result + 1] = slotMO:getSlotId()
		end
	end

	return result
end

function RoomBuildingManufactureMO:getNextEmptySlot()
	local result
	local allSlotMOList = self:getAllUnlockedSlotMOList()

	for _, slotMO in ipairs(allSlotMOList) do
		local slotState = slotMO and slotMO:getSlotState()

		if slotState == RoomManufactureEnum.SlotState.None then
			result = slotMO:getSlotId()

			break
		end
	end

	return result
end

function RoomBuildingManufactureMO:getNextEmptyCritterSlot()
	local result
	local tradeLevel = ManufactureModel.instance:getTradeLevel()
	local canPlaceCritterCount = 0
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self.id)

	if buildingMO then
		canPlaceCritterCount = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(buildingMO.buildingId, tradeLevel)
	end

	if canPlaceCritterCount > 0 then
		for critterSlotId = 0, canPlaceCritterCount - 1 do
			local critterUid = self:getWorkingCritter(critterSlotId)

			if not critterUid then
				result = critterSlotId

				break
			end
		end
	end

	return result
end

function RoomBuildingManufactureMO:getNeedMatDict()
	return self._needMatDict or {}
end

return RoomBuildingManufactureMO
