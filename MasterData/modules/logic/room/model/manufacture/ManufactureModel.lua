-- chunkname: @modules/logic/room/model/manufacture/ManufactureModel.lua

module("modules.logic.room.model.manufacture.ManufactureModel", package.seeall)

local ManufactureModel = class("ManufactureModel", BaseModel)
local PLAY_FLAG = 1
local NOT_PLAY_FLAG = 0

function ManufactureModel:onInit()
	self:clear()
	self:clearData()
end

function ManufactureModel:reInit()
	self:clearData()
end

function ManufactureModel:clearData()
	self:setSelectedSlot()
	self:setSelectedCritterSlot()
	self:setSelectedCritterSeatSlot()
	self:setSelectedTransportPath()
	self:setNewRestCritter()
	self:setIsJump2ManufactureBuildingList()
	self:setTradeLevel()
	self:clearCritterBuildingData()
	self:setCameraRecord()

	self._frozenMatDict = nil
	self._needMatDict = nil
	self._isPlayManufactureUnlock = nil
	self._isExpandManufacture = nil
	self._readFormulaDict = nil
	self._recordOneKeyType = nil
end

function ManufactureModel:resetDataBeforeSetInfo()
	self:setTradeLevel()
	self:clearCritterBuildingData()
	self:clear()
end

function ManufactureModel:clearCritterBuildingData()
	self._buildingCritterMOList = {}
	self._buildingCritterMODict = {}
end

function ManufactureModel:initNewManufactureFormulaCacheData()
	if self._readFormulaDict then
		return
	end

	local strReadFormulaData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, "")

	if not string.nilorempty(strReadFormulaData) then
		self._readFormulaDict = cjson.decode(strReadFormulaData)
	end

	self._readFormulaDict = self._readFormulaDict or {}
end

function ManufactureModel:setManufactureInfo(manufactureInfo)
	if not manufactureInfo then
		return
	end

	self:setTradeLevel(manufactureInfo.tradeLevel)
	self:setManuBuildingInfoList(manufactureInfo.manuBuildingInfos)
	self:setCritterBuildingInfoList(manufactureInfo.restBuildingInfos)
	self:setFrozenItemDict(manufactureInfo.frozenItems2Count)
end

function ManufactureModel:setTradeLevel(tradeLevel)
	self._tradeLevel = tradeLevel
end

function ManufactureModel:setManuBuildingInfoList(manuBuildingInfos)
	if not manuBuildingInfos then
		return
	end

	for _, manufactureInfo in ipairs(manuBuildingInfos) do
		self:setManuBuildingInfo(manufactureInfo)
	end

	self:refreshAllNeedMat()
end

function ManufactureModel:setManuBuildingInfo(manuBuildingInfo, refreshAllNeedDict)
	if not manuBuildingInfo then
		return
	end

	local isNewInfo = false
	local manufactureMO = self:getManufactureMOById(manuBuildingInfo.buildingUid)

	if not manufactureMO then
		manufactureMO = RoomBuildingManufactureMO.New()
		isNewInfo = true
	end

	manufactureMO:init(manuBuildingInfo)

	if isNewInfo then
		self:addAtLast(manufactureMO)
	end

	if refreshAllNeedDict then
		self:refreshAllNeedMat()
	end
end

function ManufactureModel:setFrozenItemDict(frozenItemInfo)
	self._frozenMatDict = {}

	if frozenItemInfo then
		for _, itemData in ipairs(frozenItemInfo) do
			self._frozenMatDict[itemData.materialId] = itemData.quantity + (self._frozenMatDict[itemData.materialId] or 0)
		end
	end
end

function ManufactureModel:_isCanFrozenItem(itemId, changeCount)
	local manufactureItemIdList = ManufactureConfig.instance:getManufactureItemListByItemId(itemId)
	local manufactureItemId = manufactureItemIdList[1]

	if not manufactureItemId then
		return false
	end

	local backpackCount = self:getManufactureItemCount(manufactureItemId)

	if backpackCount < changeCount then
		return false
	end

	local oldFrozenCount = self:getFrozenManufactureItemCount(manufactureItemId)
	local newCount = oldFrozenCount + changeCount

	if newCount < 0 then
		return false
	end

	return true
end

function ManufactureModel:clientCalAllFrozenItemDict()
	self._frozenMatDict = {}

	local allPlacedManufactureBuildingList = self:getAllPlacedManufactureBuilding()

	for _, buildingMO in ipairs(allPlacedManufactureBuildingList) do
		local unlockSlotList = buildingMO:getAllUnlockedSlotIdList()

		for _, slotId in ipairs(unlockSlotList) do
			local slotState = buildingMO:getSlotState(slotId, true)

			if slotState == RoomManufactureEnum.SlotState.Wait then
				local tmpItemDict = {}
				local manufactureItemId = buildingMO:getSlotManufactureItemId(slotId)
				local matList = ManufactureConfig.instance:getNeedMatItemList(manufactureItemId)

				for _, matData in ipairs(matList) do
					local matItemId = ManufactureConfig.instance:getItemId(matData.id)
					local needQuantity = matData.quantity
					local isCanFrozen = self:_isCanFrozenItem(matItemId, needQuantity)

					if isCanFrozen then
						tmpItemDict[matItemId] = needQuantity
					else
						tmpItemDict = {}

						break
					end
				end

				for itemId, changeCount in pairs(tmpItemDict) do
					self._frozenMatDict[itemId] = (self._frozenMatDict[itemId] or 0) + changeCount
				end
			end
		end
	end
end

function ManufactureModel:refreshAllNeedMat()
	self._needMatDict = {}

	local allManufactureMOList = self:getList()

	for _, manufactureMO in ipairs(allManufactureMOList) do
		local needMatDict = manufactureMO:getNeedMatDict()

		for itemId, count in pairs(needMatDict) do
			self._needMatDict[itemId] = count + (self._needMatDict[itemId] or 0)
		end
	end
end

function ManufactureModel:setWorkCritterInfo(buildingUid, critterInfo)
	local manufactureMO = self:getManufactureMOById(buildingUid)

	if manufactureMO then
		manufactureMO:setWorkCritterInfo(critterInfo)
	end
end

function ManufactureModel:setCritterBuildingInfoList(critterBuildingInfos)
	if not critterBuildingInfos then
		return
	end

	for _, critterInfo in ipairs(critterBuildingInfos) do
		self:setCritterBuildingInfo(critterInfo)
	end
end

function ManufactureModel:setCritterBuildingInfo(critterBuildingInfo)
	if not critterBuildingInfo then
		return
	end

	local isNewInfo = false
	local buildingUid = critterBuildingInfo.buildingUid
	local critterBuildingMO = self:getCritterBuildingMOById(buildingUid)

	if not critterBuildingMO then
		critterBuildingMO = RoomBuildingCritterMO.New()
		isNewInfo = true
	end

	critterBuildingMO:init(critterBuildingInfo)

	if isNewInfo then
		table.insert(self._buildingCritterMOList, critterBuildingMO)

		self._buildingCritterMODict[buildingUid] = critterBuildingMO
	end
end

function ManufactureModel:setPlayManufactureUnlock(isOn)
	if isOn then
		self._isPlayManufactureUnlock = PLAY_FLAG or NOT_PLAY_FLAG
	end

	local key = self:getManufacturePlayUnlockKey()

	PlayerPrefsHelper.setNumber(key, self._isPlayManufactureUnlock)
end

function ManufactureModel:setExpandManufactureBtn(isExpand)
	if self._isExpandManufacture == isExpand then
		return
	end

	self._isExpandManufacture = isExpand

	if isExpand then
		if not PLAY_FLAG then
			local newFlag = NOT_PLAY_FLAG

			GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, newFlag)
		end
	end
end

function ManufactureModel:setReadNewManufactureFormula(buildingUid)
	self:initNewManufactureFormulaCacheData()

	local readFormulaDict = self._readFormulaDict[buildingUid]

	if not readFormulaDict then
		readFormulaDict = {}
		self._readFormulaDict[buildingUid] = readFormulaDict
	end

	local canProduceFormulaDict = self:getCanProduceManufactureItemDict(buildingUid)

	for manufactureItemId, _ in pairs(canProduceFormulaDict) do
		local strManufactureItemId = tostring(manufactureItemId)

		readFormulaDict[strManufactureItemId] = true
	end

	local strData = cjson.encode(self._readFormulaDict) or ""

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureReadFormula, strData)
end

function ManufactureModel:setRecordOneKeyType(recordOneKeyType)
	local isOneKeyType = LuaUtil.tableContains(RoomManufactureEnum.OneKeyType, recordOneKeyType)

	if not isOneKeyType or self._recordOneKeyType == recordOneKeyType then
		return
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, recordOneKeyType)

	self._recordOneKeyType = recordOneKeyType
end

function ManufactureModel:setSelectedSlot(buildingUid, slotId)
	self._selectedSlotBuildingUid = buildingUid
	self._selectedSlotId = slotId
end

function ManufactureModel:setSelectedCritterSlot(buildingUid, critterSlotId)
	self._selectedCritterSlotBuildingUid = buildingUid
	self._selectedCritterSlotId = critterSlotId
end

function ManufactureModel:setSelectedCritterSeatSlot(buildingUid, critterSeatSlotId)
	self._selectedCritterSeatSlotBuildingUid = buildingUid
	self._selectedCritterSeatSlotId = critterSeatSlotId
end

function ManufactureModel:setSelectedTransportPath(pathId)
	self._selectedTransportPathId = pathId
end

function ManufactureModel:setNewRestCritter(critterUid)
	self._newRestCritter = critterUid
end

function ManufactureModel:setIsJump2ManufactureBuildingList(isJump)
	self._isJumpManuBuildingList = isJump
end

function ManufactureModel:setCameraRecord(cameraState, cameraParam)
	self._recordCameraState = cameraState
	self._recordCameraParam = cameraParam
end

function ManufactureModel:getTradeLevel()
	return self._tradeLevel or 0
end

function ManufactureModel:getCritterWorkingBuilding(critterUid)
	if not critterUid then
		return
	end

	local result
	local allManufactureMoList = self:getList()

	for _, manufactureMo in ipairs(allManufactureMoList) do
		local critterSlotId = manufactureMo:getCritterWorkSlot(critterUid)

		if critterSlotId then
			result = manufactureMo.uid

			break
		end
	end

	return result
end

function ManufactureModel:getCritterRestingBuilding(critterUid)
	if not critterUid then
		return
	end

	local result
	local allCritterBuildingMOList = ManufactureModel.instance:getAllCritterBuildingMOList()

	for _, critterBuildingMO in ipairs(allCritterBuildingMOList) do
		local seatSlotId = critterBuildingMO:isCritterInSeatSlot(critterUid)

		if seatSlotId then
			result = critterBuildingMO.uid

			break
		end
	end

	return result
end

function ManufactureModel:getManufactureItemCount(manufactureItemId, getInSlotCount, getSameItemCount, includeFrozenCount)
	local hasQuantity, inSlotCount = 0, 0
	local type = MaterialEnum.MaterialType.Item
	local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

	if itemId then
		local backpackQuantity = ItemModel.instance:getItemQuantity(type, itemId)
		local frozenCount = self:getFrozenManufactureItemCount(manufactureItemId)

		hasQuantity = includeFrozenCount and backpackQuantity or backpackQuantity - frozenCount
	end

	return hasQuantity, (getInSlotCount or nil) and self:getManufactureItemCountInSlotQueue(manufactureItemId, false, getSameItemCount)
end

function ManufactureModel:getManufactureItemCountInSlotQueue(manufactureItemId, checkComplete, getSameItemCount)
	local result = 0
	local allManufactureMoList = self:getList()

	for _, manufactureMo in ipairs(allManufactureMoList) do
		local finishCount = manufactureMo:getManufactureItemFinishCount(manufactureItemId, checkComplete, getSameItemCount)

		result = result + finishCount
	end

	return result
end

function ManufactureModel:isManufactureUnlock(isToast)
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoomManufacture)

	if not isUnlock and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.RoomManufacture) then
		isUnlock = true
	end

	if not isUnlock and isToast then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.RoomManufacture))
	end

	return isUnlock
end

function ManufactureModel:getManufacturePlayUnlockKey()
	local userId = PlayerModel.instance:getPlayinfo().userId

	return string.format("%s_%s", PlayerPrefsKey.RoomManufactureEntrancePlayUnlockAnim, userId)
end

function ManufactureModel:getPlayManufactureUnlock()
	if self._isPlayManufactureUnlock == nil then
		local key = self:getManufacturePlayUnlockKey()

		self._isPlayManufactureUnlock = PlayerPrefsHelper.getNumber(key, NOT_PLAY_FLAG)
	end

	return self._isPlayManufactureUnlock == PLAY_FLAG
end

function ManufactureModel:getExpandManufactureBtn()
	if not self._isExpandManufacture then
		local flag = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomExpandManufacture, NOT_PLAY_FLAG)

		self._isExpandManufacture = flag == PLAY_FLAG
	end

	return self._isExpandManufacture
end

function ManufactureModel:getRecordOneKeyType()
	local defaultType = RoomManufactureEnum.OneKeyType.ShortTime

	self._recordOneKeyType = self._recordOneKeyType or GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.RoomManufactureOneKeyType, defaultType)

	if self._recordOneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		local selectedItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

		if not selectedItem then
			self._recordOneKeyType = defaultType
		end
	end

	return self._recordOneKeyType or defaultType
end

function ManufactureModel:getManufactureMOById(buildingUid)
	return self:getById(buildingUid)
end

function ManufactureModel:getAllManufactureMOList()
	return self:getList()
end

local function _sortBuildingMOList(aBuildingMO, bBuildingMO)
	local aBuildingType = aBuildingMO.config.buildingType
	local bBuildingType = bBuildingMO.config.buildingType

	if aBuildingType ~= bBuildingType then
		return aBuildingType < bBuildingType
	end

	local aBuildingId = aBuildingMO.buildingId
	local bBuildingId = bBuildingMO.buildingId

	if aBuildingId ~= bBuildingId then
		return aBuildingId < bBuildingId
	end

	local aBuildingUid = aBuildingMO.uid
	local bBuildingUid = bBuildingMO.uid

	return aBuildingUid < bBuildingUid
end

function ManufactureModel:getAllPlacedManufactureBuilding()
	local result = {}
	local tmpBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Collect)

	tabletool.addValues(result, tmpBuildingList)

	tmpBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Process)

	tabletool.addValues(result, tmpBuildingList)

	tmpBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Manufacture)

	tabletool.addValues(result, tmpBuildingList)
	table.sort(result, _sortBuildingMOList)

	return result
end

function ManufactureModel:getAllBuildingCanClaimProducts()
	local result = {}
	local allPlacedManufactureBuildingList = self:getAllPlacedManufactureBuilding()

	for _, buildingMO in ipairs(allPlacedManufactureBuildingList) do
		if buildingMO:isCanClaimProduction() then
			result[#result + 1] = buildingMO
		end
	end

	return result
end

function ManufactureModel:isMaxLevel(buildingUid)
	local result = true
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		local maxLevel = ManufactureConfig.instance:getBuildingMaxLevel(buildingMO.buildingId)

		result = maxLevel <= buildingMO.level
	end

	return result
end

function ManufactureModel:getManufactureLevelUpParam(buildingUid)
	local viewParam = {
		buildingUid = buildingUid,
		extraCheckFunc = ManufactureController.checkTradeLevelCondition,
		extraCheckFuncObj = ManufactureController.instance
	}
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local buildingId = buildingMO.buildingId
	local upgradeGroup = ManufactureConfig.instance:getBuildingUpgradeGroup(buildingId)

	if not upgradeGroup or upgradeGroup == 0 then
		return viewParam
	end

	local curLevel = buildingMO.level
	local nextLevel = curLevel + 1

	viewParam.levelUpInfoList = {}

	local levelDesc = {
		desc = luaLang("room_building_level_up_tip"),
		currentDesc = formatLuaLang("v1a5_aizila_level", curLevel),
		nextDesc = formatLuaLang("v1a5_aizila_level", nextLevel)
	}

	table.insert(viewParam.levelUpInfoList, levelDesc)

	local oldSlotCount = ManufactureConfig.instance:getBuildingSlotCount(buildingId, curLevel)
	local newSlotCount = ManufactureConfig.instance:getBuildingSlotCount(buildingId, nextLevel)

	if oldSlotCount ~= newSlotCount then
		local slotDesc = {
			desc = luaLang("room_manufacture_building_add_slot"),
			currentDesc = oldSlotCount,
			nextDesc = newSlotCount
		}

		table.insert(viewParam.levelUpInfoList, slotDesc)
	end

	local newItemInfoList = {}
	local checkRepeatDict = {}
	local newManufactureItemList = ManufactureConfig.instance:getNewManufactureItemList(upgradeGroup, nextLevel)

	for _, manufactureItemId in ipairs(newManufactureItemList) do
		local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

		if not checkRepeatDict[itemId] then
			newItemInfoList[#newItemInfoList + 1] = {
				type = MaterialEnum.MaterialType.Item,
				id = itemId
			}
			checkRepeatDict[itemId] = true
		end
	end

	local newItemInfo = {
		desc = luaLang("room_new_manufacture_item"),
		newItemInfoList = newItemInfoList
	}

	table.insert(viewParam.levelUpInfoList, newItemInfo)

	return viewParam
end

function ManufactureModel:isAreaHasManufactureRunning(buildingType)
	local result = false
	local areaMo = RoomMapBuildingAreaModel.instance:getAreaMOByBType(buildingType)
	local buildingMOList = areaMo and areaMo:getBuildingMOList(true)

	if buildingMOList then
		for _, buildingMO in ipairs(buildingMOList) do
			local manufactureState = buildingMO:getManufactureState()

			if manufactureState == RoomManufactureEnum.ManufactureState.Running then
				result = true

				break
			end
		end
	end

	return result
end

function ManufactureModel:getCanProduceManufactureItemDict(buildingUid)
	local result = {}
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		local buildingId = buildingMO.buildingId
		local buildingLevel = buildingMO:getLevel()
		local allManufactureItemList = ManufactureConfig.instance:getAllManufactureItems(buildingId)

		for _, manufactureItemId in ipairs(allManufactureItemList) do
			local needLevel = ManufactureConfig.instance:getManufactureItemNeedLevel(buildingId, manufactureItemId)

			if needLevel <= buildingLevel then
				result[manufactureItemId] = true
			end
		end
	end

	return result
end

function ManufactureModel:hasNewManufactureFormula(buildingUid)
	local result = false

	self:initNewManufactureFormulaCacheData()

	local readFormulaDict = self._readFormulaDict[buildingUid]
	local canProduceFormulaDict = self:getCanProduceManufactureItemDict(buildingUid)

	for manufactureItemId, _ in pairs(canProduceFormulaDict) do
		local strManufactureItemId = tostring(manufactureItemId)

		if not readFormulaDict or not readFormulaDict[strManufactureItemId] then
			result = true

			break
		end
	end

	return result
end

function ManufactureModel:hasPathLinkedToThisBuildingType(manufactureItemId, targetBuildingType)
	local result = false
	local manufactureBuildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(manufactureItemId)

	if manufactureBuildingType and targetBuildingType then
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(manufactureBuildingType, targetBuildingType)

		if pathMO then
			local isLinkFinish = pathMO:isLinkFinish()
			local hasCritterWork = pathMO:hasCritterWorking()

			result = isLinkFinish and hasCritterWork
		end
	end

	return result
end

function ManufactureModel:getMaxCanProductCount(manufactureItemId)
	local noEmptySlot = true

	if not manufactureItemId then
		return OneKeyAddPopListModel.MINI_COUNT, noEmptySlot
	end

	local result = 0
	local maxUnitCount, minUnitCount = ManufactureConfig.instance:getManufactureItemUnitCountRange(manufactureItemId)
	local max2PerMin = maxUnitCount / minUnitCount
	local manufactureBuildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(manufactureItemId)
	local placedManufactureBuildingList = RoomMapBuildingModel.instance:getBuildingListByType(manufactureBuildingType)

	if placedManufactureBuildingList and #placedManufactureBuildingList > 0 then
		for _, buildingMO in ipairs(placedManufactureBuildingList) do
			local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingMO.buildingId, manufactureItemId)

			if isBelong then
				local emptySlotIdList = buildingMO:getEmptySlotIdList()

				result = result + ((#emptySlotIdList > 0 or nil) and #emptySlotIdList * max2PerMin)
			end
		end
	end

	noEmptySlot = result == 0

	return math.max(result, OneKeyAddPopListModel.MINI_COUNT), noEmptySlot
end

function ManufactureModel:getManufactureWrongType(buildingUid, slotId)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local slotState = buildingMO and buildingMO:getSlotState(slotId)

	if slotState ~= RoomManufactureEnum.SlotState.Stop then
		return
	end

	local result
	local manufactureItemId = buildingMO:getSlotManufactureItemId(slotId)
	local matList = ManufactureConfig.instance:getNeedMatItemList(manufactureItemId)
	local buildingType = buildingMO.config.buildingType

	for _, matData in ipairs(matList) do
		local matManuItemId = matData.id
		local needQuantity = matData.quantity
		local hasQuantity, inSlotCount = self:getManufactureItemCount(matManuItemId, true, true, true)

		if hasQuantity < needQuantity then
			if needQuantity <= hasQuantity + inSlotCount then
				local canUsePreBuildingItem = self:hasPathLinkedToThisBuildingType(matManuItemId, buildingType)

				result = canUsePreBuildingItem and RoomManufactureEnum.ManufactureWrongType.WaitPreMat or RoomManufactureEnum.ManufactureWrongType.NoLinkPath
			else
				result = RoomManufactureEnum.ManufactureWrongType.LackPreMat
			end
		end

		if result and result ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			break
		end
	end

	if not result then
		local critterDict = buildingMO:getSlot2CritterDict()

		if not next(critterDict) then
			result = RoomManufactureEnum.ManufactureWrongType.NoCritter
		end
	end

	return result
end

function ManufactureModel:getManufactureWrongTipItemList(buildingUid)
	local result = {}
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if not buildingMO then
		return result
	end

	local tmpDict = {}
	local slotIdList = buildingMO:getAllUnlockedSlotIdList()

	for _, slotId in ipairs(slotIdList) do
		local wrongType = self:getManufactureWrongType(buildingUid, slotId)

		if wrongType and wrongType ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			local manufactureItemId = buildingMO:getSlotManufactureItemId(slotId)
			local wrongSlotIdList = tmpDict[manufactureItemId]

			if not wrongSlotIdList then
				wrongSlotIdList = {}
				tmpDict[manufactureItemId] = wrongSlotIdList
			end

			wrongSlotIdList[#wrongSlotIdList + 1] = slotId
		end
	end

	for manufactureItemId, wrongSlotIdList in pairs(tmpDict) do
		result[#result + 1] = {
			manufactureItemId = manufactureItemId,
			wrongSlotIdList = wrongSlotIdList
		}
	end

	return result
end

function ManufactureModel:getAllWrongManufactureItemList(buildingUid, manufactureItemId, count)
	local wrongItemList = {}
	local wrongTypeList = {}
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if not buildingMO then
		return wrongItemList, wrongTypeList
	end

	local wrongTypeDict = {}
	local buildingType = buildingMO.config.buildingType
	local matList = ManufactureConfig.instance:getNeedMatItemList(manufactureItemId)

	for _, matData in ipairs(matList) do
		local matBuildingLevelNotEnough = true
		local matManuItemId = matData.id
		local needQuantity = matData.quantity * count
		local wrongType
		local matBuildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(matManuItemId)
		local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(matBuildingType)

		if buildingList and #buildingList > 0 then
			for _, checkBuildingMO in ipairs(buildingList) do
				local buildingId = checkBuildingMO.buildingId
				local isBelong = ManufactureConfig.instance:isManufactureItemBelongBuilding(buildingId, matManuItemId)

				if isBelong then
					local matBuildingLevel = checkBuildingMO:getLevel()
					local matNeedLevel = ManufactureConfig.instance:getManufactureItemNeedLevel(buildingId, matManuItemId)

					if matNeedLevel and matNeedLevel <= matBuildingLevel then
						matBuildingLevelNotEnough = false

						break
					end
				end
			end
		end

		if matBuildingLevelNotEnough then
			wrongType = RoomManufactureEnum.ManufactureWrongType.PreMatNotUnlock
		else
			local hasQuantity, inSlotCount = self:getManufactureItemCount(matManuItemId, true, true)

			if hasQuantity < needQuantity then
				local canUsePreBuildingItem = self:hasPathLinkedToThisBuildingType(matManuItemId, buildingType)

				if needQuantity <= hasQuantity + inSlotCount then
					if not canUsePreBuildingItem then
						wrongType = RoomManufactureEnum.ManufactureWrongType.NoLinkPath
					end
				else
					wrongType = RoomManufactureEnum.ManufactureWrongType.LackPreMat
				end
			end
		end

		if wrongType then
			local wrongDataList = wrongTypeDict[wrongType]

			if not wrongDataList then
				wrongDataList = {}
				wrongTypeDict[wrongType] = wrongDataList
			end

			local wrongData = {}

			wrongData.manufactureItemId = matManuItemId
			wrongData.buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(matManuItemId)
			wrongData.needQuantity = needQuantity
			wrongDataList[#wrongDataList + 1] = wrongData
		end
	end

	local checkNoLinkPathRepeat = {}

	for wrongType, wrongDataList in pairs(wrongTypeDict) do
		for _, wrongData in ipairs(wrongDataList) do
			if wrongType ~= RoomManufactureEnum.ManufactureWrongType.NoLinkPath or not checkNoLinkPathRepeat[wrongData.buildingType] then
				wrongItemList[#wrongItemList + 1] = {
					manufactureItemId = wrongData.manufactureItemId,
					wrongType = wrongType,
					buildingType = wrongData.buildingType,
					needQuantity = wrongData.needQuantity
				}

				if wrongType == RoomManufactureEnum.ManufactureWrongType.NoLinkPath then
					checkNoLinkPathRepeat[wrongData.buildingType] = true
				end
			end
		end

		wrongTypeList[#wrongTypeList + 1] = wrongType
	end

	local critterDict = buildingMO:getSlot2CritterDict()

	if not next(critterDict) then
		wrongTypeList[#wrongTypeList + 1] = RoomManufactureEnum.ManufactureWrongType.NoCritter
	end

	return wrongItemList, wrongTypeList
end

function ManufactureModel:getFrozenManufactureItemCount(manufactureItem)
	local itemId = ManufactureConfig.instance:getItemId(manufactureItem)

	if self._frozenMatDict then
		if not self._frozenMatDict[itemId] then
			return 0
		end
	end
end

function ManufactureModel:getLackMatCount(manufactureItem)
	local hasQuantity, inSlotCount = self:getManufactureItemCount(manufactureItem, true, true, true)
	local totalHasQuantity = hasQuantity + inSlotCount
	local isTraceLack = true
	local traceCount, traceCountBeChild = RoomTradeModel.instance:getTracedGoodsCount(manufactureItem)
	local result = math.max(0, traceCount + traceCountBeChild - totalHasQuantity)

	if result <= 0 then
		isTraceLack = false

		local needCountBeMat = self:getNeedMatCount(manufactureItem)

		result = math.max(0, needCountBeMat + traceCount - totalHasQuantity)
	end

	local itemId = ManufactureConfig.instance:getItemId(manufactureItem)
	local allPlacedManufactureBuildingList = self:getAllPlacedManufactureBuilding()

	for _, buildingMO in ipairs(allPlacedManufactureBuildingList) do
		local slotId = buildingMO:getSlotIdInProgress()
		local manufactureItemId = buildingMO:getSlotManufactureItemId(slotId)

		if manufactureItemId then
			local matList = ManufactureConfig.instance:getNeedMatItemList(manufactureItemId)

			for _, matData in ipairs(matList) do
				local matItemId = ManufactureConfig.instance:getItemId(matData.id)

				if matItemId == itemId then
					result = result - matData.quantity
				end
			end
		end
	end

	result = math.max(0, result)

	return result, isTraceLack
end

function ManufactureModel:getNeedMatCount(manufactureItem)
	local itemId = ManufactureConfig.instance:getItemId(manufactureItem)

	if self._needMatDict then
		if not self._needMatDict[itemId] then
			return 0
		end
	end
end

function ManufactureModel:getCritterBuildingMOById(buildingUid)
	return self._buildingCritterMODict[buildingUid]
end

function ManufactureModel:getAllCritterBuildingMOList()
	return self._buildingCritterMOList
end

function ManufactureModel:getCritterBuildingListInOrder()
	return (RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Rest, true))
end

function ManufactureModel:getSelectedSlot()
	return self._selectedSlotBuildingUid, self._selectedSlotId
end

function ManufactureModel:getSelectedCritterSlot()
	return self._selectedCritterSlotBuildingUid, self._selectedCritterSlotId
end

function ManufactureModel:getSelectedCritterSeatSlot()
	return self._selectedCritterSeatSlotBuildingUid, self._selectedCritterSeatSlotId
end

function ManufactureModel:getSelectedTransportPath()
	return self._selectedTransportPathId
end

function ManufactureModel:getNewRestCritter()
	return self._newRestCritter
end

function ManufactureModel:getIsJump2ManufactureBuildingList()
	return self._isJumpManuBuildingList
end

function ManufactureModel:getCameraRecord()
	return self._recordCameraState, self._recordCameraParam
end

function ManufactureModel:getTradeBuildingListInOrder()
	return (RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Trade, true))
end

ManufactureModel.instance = ManufactureModel.New()

return ManufactureModel
