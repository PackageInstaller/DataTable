-- chunkname: @modules/logic/room/model/map/RoomBuildingMO.lua

module("modules.logic.room.model.map.RoomBuildingMO", package.seeall)

local RoomBuildingMO = pureTable("RoomBuildingMO")

function RoomBuildingMO:init(info)
	self:setUid(info.uid)

	self.buildingId = info.buildingId or info.defineId
	self.rotate = info.rotate or 0
	self.buildingState = info.buildingState
	self.use = info.use
	self.level = info.level or 0

	if self:isInMap() then
		self.hexPoint = HexPoint(info.x, info.y)
		self.resAreaDirection = info.resAreaDirection
	end

	self:refreshCfg()

	self._currentInteractionId = nil

	self:setBelongUserId(info.belongUserId)
end

function RoomBuildingMO:setUid(uid)
	self.id = uid
	self.uid = uid
	self.buildingUid = uid
end

function RoomBuildingMO:refreshCfg()
	self.config = RoomConfig.instance:getBuildingConfig(self.buildingId)

	if not self.config then
		logError("找不到建筑id: " .. tostring(self.buildingId))
	elseif self.config.canLevelUp then
		local levelConfig = RoomConfig.instance:getLevelGroupConfig(self.buildingId, self.level)

		if levelConfig then
			self.config = RoomHelper.mergeCfg(self.config, levelConfig)
		end
	end
end

function RoomBuildingMO:isInMap()
	return self.buildingState == RoomBuildingEnum.BuildingState.Map or self.buildingState == RoomBuildingEnum.BuildingState.Temp or self.buildingState == RoomBuildingEnum.BuildingState.Revert
end

function RoomBuildingMO:setBelongUserId(userId)
	self._belongUserId = userId
end

function RoomBuildingMO:updateBuildingLevels()
	return
end

function RoomBuildingMO:setCurrentInteractionId(interactionId)
	self._currentInteractionId = interactionId
end

function RoomBuildingMO:getCurrentInteractionId()
	return self._currentInteractionId
end

function RoomBuildingMO:getInteractMO()
	if self:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		if not self._interactMO then
			self._interactMO = RoomInteractBuildingMO.New()

			self._interactMO:init(self)
		end

		return self._interactMO
	end

	return nil
end

function RoomBuildingMO:getPlaceAudioId(isSelf)
	if self.config and self.config.placeAudio and self.config.placeAudio ~= 0 then
		return self.config.placeAudio
	end

	if isSelf then
		return 0
	end

	return AudioEnum.Room.play_ui_home_board_lay
end

function RoomBuildingMO:getLevel()
	return self.level
end

function RoomBuildingMO:getIcon()
	if self.config then
		if self.config.canLevelUp and self.levelConfig and not string.nilorempty(self.levelConfig.icon) then
			return self.levelConfig.icon
		end

		return self.config.icon
	end
end

function RoomBuildingMO:getLevelUpIcon()
	local result

	return (self.config and self.config.canLevelUp or nil) and self.config.levelUpIcon
end

function RoomBuildingMO:getBelongUserId()
	return self._belongUserId
end

function RoomBuildingMO:_getCfgParam()
	return
end

function RoomBuildingMO:getCanPlaceCritterCount()
	local tradeLevel = ManufactureModel.instance:getTradeLevel()

	return (ManufactureConfig.instance:getBuildingCanPlaceCritterCount(self.buildingId, tradeLevel))
end

function RoomBuildingMO:getWorkingCritter(critterSlotId)
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getWorkingCritter(critterSlotId)
end

function RoomBuildingMO:getCritterWorkSlot(critterUid)
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getCritterWorkSlot(critterUid)
end

function RoomBuildingMO:getSeatSlotMO(seatSlotId, nilError)
	local result
	local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(self.id)

	return (critterBuildingInfo or nil) and critterBuildingInfo:getSeatSlotMO(seatSlotId, nilError)
end

function RoomBuildingMO:getRestingCritter(seatSlotId)
	local result
	local slotMO = self:getSeatSlotMO(seatSlotId)

	return (slotMO or nil) and slotMO:getRestingCritter()
end

function RoomBuildingMO:isSeatSlotEmpty(seatSlotId)
	local slotMO = self:getSeatSlotMO(seatSlotId)

	return (slotMO or nil) and slotMO:isEmpty()
end

function RoomBuildingMO:isCritterInSeatSlot(critterUid)
	local result
	local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(self.id)

	return (critterBuildingInfo or nil) and critterBuildingInfo:isCritterInSeatSlot(critterUid)
end

function RoomBuildingMO:getNextEmptyCritterSeatSlot()
	local result
	local critterBuildingInfo = ManufactureModel.instance:getCritterBuildingMOById(self.id)

	return (critterBuildingInfo or nil) and critterBuildingInfo:getNextEmptyCritterSeatSlot()
end

function RoomBuildingMO:isCanClaimProduction()
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:isHasCompletedProduction()
end

function RoomBuildingMO:getNewerCompleteManufactureItem()
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getNewerCompleteManufactureItem()
end

function RoomBuildingMO:getAllUnlockedSlotIdList()
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getAllUnlockedSlotIdList()
end

function RoomBuildingMO:getManufactureState()
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getManufactureState()
end

function RoomBuildingMO:getManufactureProgress()
	local progress = 0
	local strRemainTime = ""
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	if manufactureInfo then
		progress, strRemainTime = manufactureInfo:getManufactureProgress()
	end

	return progress, strRemainTime
end

function RoomBuildingMO:getOccupySlotCount(notComplete)
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getOccupySlotCount(notComplete)
end

function RoomBuildingMO:getEmptySlotIdList()
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getEmptySlotIdList()
end

function RoomBuildingMO:getSlotIdInProgress()
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getSlotIdInProgress()
end

function RoomBuildingMO:getCanChangeMaxPriority()
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getCanChangeMaxPriority()
end

function RoomBuildingMO:getSlotMO(slotId, nilError)
	local result
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getSlotMO(slotId, nilError)
end

function RoomBuildingMO:getSlotState(slotId, getRealState)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotState(getRealState)
end

function RoomBuildingMO:getSlotProgress(slotId)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotProgress()
end

function RoomBuildingMO:getSlotRemainStrTime(slotId, useEn)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotRemainStrTime(useEn)
end

function RoomBuildingMO:getSlotRemainSecTime(slotId)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotRemainSecTime()
end

function RoomBuildingMO:getAccelerateEff(slotId, accItemId)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotAccelerateEff(accItemId)
end

function RoomBuildingMO:getSlotManufactureItemId(slotId)
	local result
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotManufactureItemId()
end

function RoomBuildingMO:getSlotFinishCount(slotId)
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getFinishCount()
end

function RoomBuildingMO:getSlotPriority(slotId)
	local result
	local slotMO = self:getSlotMO(slotId)

	return (slotMO or nil) and slotMO:getSlotPriority()
end

function RoomBuildingMO:checkSameType(buildingType)
	if self.config and self.config.buildingType == buildingType then
		return true
	end

	return false
end

function RoomBuildingMO:getSlot2CritterDict()
	local manufactureInfo = ManufactureModel.instance:getManufactureMOById(self.id)

	return (manufactureInfo or nil) and manufactureInfo:getSlot2CritterDict()
end

function RoomBuildingMO:isBuildingArea()
	if self.config and RoomBuildingEnum.BuildingArea[self.config.buildingType] then
		return true
	end

	return false
end

function RoomBuildingMO:isAreaMainBuilding()
	if self.config and self.config.isAreaMainBuilding then
		return true
	end

	return false
end

return RoomBuildingMO
