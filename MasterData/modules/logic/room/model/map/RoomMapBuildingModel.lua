-- chunkname: @modules/logic/room/model/map/RoomMapBuildingModel.lua

module("modules.logic.room.model.map.RoomMapBuildingModel", package.seeall)

local RoomMapBuildingModel = class("RoomMapBuildingModel", BaseModel)

function RoomMapBuildingModel:onInit()
	self:_clearData()
end

function RoomMapBuildingModel:reInit()
	self:_clearData()
end

function RoomMapBuildingModel:clear()
	RoomMapBuildingModel.super.clear(self)
	self:_clearData()
end

function RoomMapBuildingModel:_clearData()
	self._mapBuildingMODict = {}
	self._type2BuildingDict = {}
	self._tempBuildingMO = nil
	self._allOccupyDict = nil
	self._canConfirmPlaceDict = nil
	self._revertHexPoint = nil
	self._revertRotate = nil
	self._tempOccupyDict = nil
	self._lightResourcePointDict = nil
	self._isHasCritterDict = nil
end

function RoomMapBuildingModel:initMap(infos)
	self:clear()

	if not infos or #infos <= 0 then
		return
	end

	for i, info in ipairs(infos) do
		if info.use then
			local buildingInfo = RoomInfoHelper.serverInfoToBuildingInfo(info)
			local buildingMO = RoomBuildingMO.New()

			buildingMO:init(buildingInfo)

			if buildingMO.config then
				self:_addBuildingMO(buildingMO)
			end
		end
	end
end

function RoomMapBuildingModel:_addBuildingMO(mo)
	local hexPoint = mo.hexPoint

	self._mapBuildingMODict[hexPoint.x] = self._mapBuildingMODict[hexPoint.x] or {}
	self._mapBuildingMODict[hexPoint.x][hexPoint.y] = mo

	local buildingType = mo.config.buildingType

	self._type2BuildingDict[buildingType] = self._type2BuildingDict[buildingType] or {}

	table.insert(self._type2BuildingDict[buildingType], mo)
	self:addAtLast(mo)
end

function RoomMapBuildingModel:_removeBuildingMO(mo)
	local hexPoint = mo.hexPoint

	if self._mapBuildingMODict[hexPoint.x] then
		self._mapBuildingMODict[hexPoint.x][hexPoint.y] = nil
	end

	local buildingType = mo.config.buildingType

	if self._type2BuildingDict[buildingType] then
		tabletool.removeValue(self._type2BuildingDict[buildingType], mo)
	end

	self:remove(mo)
end

function RoomMapBuildingModel:removeBuildingMO(mo)
	self:_removeBuildingMO(mo)
end

function RoomMapBuildingModel:addTempBuildingMO(inventoryBuildingMO, hexPoint)
	if self._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	local inventoryInfo = RoomInfoHelper.buildingMOToBuildingInfo(inventoryBuildingMO)

	self._tempBuildingMO = RoomBuildingMO.New()
	inventoryInfo.buildingState = RoomBuildingEnum.BuildingState.Temp
	inventoryInfo.x = hexPoint.x
	inventoryInfo.y = hexPoint.y

	self._tempBuildingMO:init(inventoryInfo)
	self:_addBuildingMO(self._tempBuildingMO)
	RoomResourceModel.instance:clearResourceAreaList()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()

	return self._tempBuildingMO
end

function RoomMapBuildingModel:getTempBuildingMO()
	return self._tempBuildingMO
end

function RoomMapBuildingModel:changeTempBuildingMOUid(uid, buildingId)
	if self._tempBuildingMO and tonumber(self._tempBuildingMO.id) < 1 and self._tempBuildingMO.buildingId == buildingId then
		local oldId = self._tempBuildingMO.id

		if oldId ~= uid then
			self:_removeBuildingMO(self._tempBuildingMO)
			self._tempBuildingMO:setUid(uid)
			self:_addBuildingMO(self._tempBuildingMO)
		end

		return true, oldId
	end
end

function RoomMapBuildingModel:changeTempBuildingMO(hexPoint, rotate)
	if not self._tempBuildingMO then
		return
	end

	self._tempBuildingMO.rotate = rotate

	if self._tempBuildingMO.hexPoint ~= hexPoint then
		self:_removeBuildingMO(self._tempBuildingMO)

		self._tempBuildingMO.hexPoint = hexPoint

		self:_addBuildingMO(self._tempBuildingMO)
	end

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()
end

function RoomMapBuildingModel:removeTempBuildingMO()
	if not self._tempBuildingMO then
		return
	end

	self:_removeBuildingMO(self._tempBuildingMO)

	self._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()
end

function RoomMapBuildingModel:placeTempBuildingMO(info)
	if not self._tempBuildingMO then
		return
	end

	local buildingMO = RoomBuildingMO.New()
	local buildingInfo = RoomInfoHelper.serverInfoToBuildingInfo(info)

	buildingMO:init(buildingInfo)

	self._tempBuildingMO.uid = buildingMO.uid
	self._tempBuildingMO.buildingId = buildingMO.buildingId
	self._tempBuildingMO.rotate = buildingMO.rotate
	self._tempBuildingMO.levels = buildingMO.levels
	self._tempBuildingMO.resAreaDirection = buildingMO.resAreaDirection
	self._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	self._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearAllOccupyDict()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()
end

function RoomMapBuildingModel:revertTempBuildingMO(buildingUid)
	if self._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	self._tempBuildingMO = self:getBuildingMOById(buildingUid)

	if not self._tempBuildingMO then
		return
	end

	self._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Revert
	self._revertHexPoint = HexPoint(self._tempBuildingMO.hexPoint.x, self._tempBuildingMO.hexPoint.y)
	self._revertRotate = self._tempBuildingMO.rotate

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearAllOccupyDict()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()

	return self._tempBuildingMO
end

function RoomMapBuildingModel:removeRevertBuildingMO()
	if not self._tempBuildingMO then
		return
	end

	local buildingId = self._tempBuildingMO.buildingId

	self._tempBuildingMO.hexPoint = self._revertHexPoint
	self._tempBuildingMO.rotate = self._revertRotate
	self._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	self._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearAllOccupyDict()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()

	return buildingId, self._revertHexPoint, self._revertRotate
end

function RoomMapBuildingModel:unUseRevertBuildingMO()
	if not self._tempBuildingMO then
		return
	end

	self:_removeBuildingMO(self._tempBuildingMO)

	self._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	self:clearCanConfirmPlaceDict()
	self:clearTempOccupyDict()
	self:clearLightResourcePoint()
end

function RoomMapBuildingModel:updateBuildingLevels(buildingUid, levels)
	local buildingMO = self:getBuildingMOById(buildingUid)

	buildingMO:updateBuildingLevels(levels)
end

function RoomMapBuildingModel:getBuildingMO(x, y)
	return self._mapBuildingMODict[x] and self._mapBuildingMODict[x][y]
end

function RoomMapBuildingModel:getBuildingMOList()
	return self:getList()
end

function RoomMapBuildingModel:getBuildingMODict()
	return self._mapBuildingMODict
end

function RoomMapBuildingModel:getBuildingMOById(uid)
	return self:getById(uid)
end

function RoomMapBuildingModel:getCount()
	local count = self:getCount()

	if self._tempBuildingMO then
		count = count - 1
	end

	return count
end

function RoomMapBuildingModel:refreshAllOccupyDict()
	self._allOccupyDict = RoomBuildingHelper.getAllOccupyDict()
end

function RoomMapBuildingModel:getAllOccupyDict()
	if not self._allOccupyDict then
		self:refreshAllOccupyDict()
	end

	return self._allOccupyDict
end

function RoomMapBuildingModel:clearAllOccupyDict()
	self._allOccupyDict = nil
end

function RoomMapBuildingModel:getBuildingParam(x, y)
	if not self._allOccupyDict then
		self:refreshAllOccupyDict()
	end

	return self._allOccupyDict[x] and self._allOccupyDict[x][y]
end

function RoomMapBuildingModel:isHasBuilding(x, y)
	if not self._allOccupyDict then
		self:refreshAllOccupyDict()
	end

	if self._allOccupyDict[x] and self._allOccupyDict[x][y] then
		return true
	end

	return false
end

function RoomMapBuildingModel:refreshCanConfirmPlaceDict()
	self._canConfirmPlaceDict = not self._tempBuildingMO and {} or RoomBuildingHelper.getCanConfirmPlaceDict(self._tempBuildingMO.buildingId, nil, nil, false, self._tempBuildingMO.levels)
end

function RoomMapBuildingModel:isCanConfirm(hexPoint)
	if not self._canConfirmPlaceDict then
		self:refreshCanConfirmPlaceDict()
	end

	return self._canConfirmPlaceDict[hexPoint.x] and self._canConfirmPlaceDict[hexPoint.x][hexPoint.y]
end

function RoomMapBuildingModel:getCanConfirmPlaceDict()
	if not self._canConfirmPlaceDict then
		self:refreshCanConfirmPlaceDict()
	end

	return self._canConfirmPlaceDict
end

function RoomMapBuildingModel:clearCanConfirmPlaceDict()
	self._canConfirmPlaceDict = nil
end

function RoomMapBuildingModel:refreshTempOccupyDict()
	if self._tempBuildingMO then
		local buildingHexPoint = self._tempBuildingMO.hexPoint
		local pressBuildingUid = RoomBuildingController.instance:isPressBuilding()

		if pressBuildingUid and pressBuildingUid == self._tempBuildingMO.id then
			local pressBuildingHexPoint = RoomBuildingController.instance:getPressBuildingHexPoint()

			buildingHexPoint = pressBuildingHexPoint or buildingHexPoint
		end

		self._tempOccupyIndexDict = {}
		self._tempOccupyDict = RoomBuildingHelper.getOccupyDict(self._tempBuildingMO.buildingId, buildingHexPoint, self._tempBuildingMO.rotate)

		local success = RoomBuildingAreaHelper.checkBuildingArea(self._tempBuildingMO.buildingId, buildingHexPoint, self._tempBuildingMO.rotate)

		for x, dict in pairs(self._tempOccupyDict) do
			for y, param in pairs(dict) do
				self._tempOccupyIndexDict[param.index] = param
				param.checkBuildingAreaSuccess = success
			end
		end
	else
		self._tempOccupyDict = {}
		self._tempOccupyIndexDict = {}
	end
end

function RoomMapBuildingModel:isTempOccupy(hexPoint)
	if self:getTempBuildingParam(hexPoint.x, hexPoint.y) then
		return true
	end

	return false
end

function RoomMapBuildingModel:getTempBuildingParam(x, y)
	if not self._tempOccupyDict then
		self:refreshTempOccupyDict()
	end

	return self._tempOccupyDict[x] and self._tempOccupyDict[x][y]
end

function RoomMapBuildingModel:getTempBuildingParamByPointIndex(index)
	if not self._tempOccupyDict then
		self:refreshTempOccupyDict()
	end

	return self._tempOccupyIndexDict[index]
end

function RoomMapBuildingModel:clearTempOccupyDict()
	self._tempOccupyDict = nil
	self._tempOccupyIndexDict = nil
end

function RoomMapBuildingModel:_refreshLightResourcePoint()
	self._lightResourcePointDict = {}

	if self._tempBuildingMO then
		local costResource = RoomBuildingHelper.getCostResource(self._tempBuildingMO.buildingId)
		local resourceAreaList = RoomResourceModel.instance:getResourceAreaList()

		for i, resourceArea in ipairs(resourceAreaList) do
			if RoomBuildingHelper.checkCostResource(costResource, resourceArea.resourceId) then
				local canContain = RoomBuildingHelper.canContain(resourceArea.hexPointDict, self._tempBuildingMO.buildingId)

				if canContain then
					local area = resourceArea.area

					for j, resourcePoint in ipairs(area) do
						self._lightResourcePointDict[tostring(resourcePoint)] = true
					end
				end
			end
		end

		local pressBuildingUid = RoomBuildingController.instance:isPressBuilding()
		local allOccupyDict = RoomMapBuildingModel.instance:getAllOccupyDict()
		local occupyDict = RoomBuildingHelper.getOccupyDict(self._tempBuildingMO.buildingId, self._tempBuildingMO.hexPoint, self._tempBuildingMO.rotate, self._tempBuildingMO.buildingUid)

		for x, dict in pairs(occupyDict) do
			for y, param in pairs(dict) do
				if param.buildingUid ~= pressBuildingUid then
					for direction = 0, 6 do
						local resourcePoint = ResourcePoint(HexPoint(x, y), direction)

						self._lightResourcePointDict[tostring(resourcePoint)] = nil
					end
				end
			end
		end

		for x, dict in pairs(allOccupyDict) do
			for y, param in pairs(dict) do
				if param.buildingUid ~= pressBuildingUid then
					for direction = 0, 6 do
						local resourcePoint = ResourcePoint(HexPoint(x, y), direction)

						self._lightResourcePointDict[tostring(resourcePoint)] = nil
					end
				end
			end
		end
	end
end

function RoomMapBuildingModel:isLightResourcePoint(resourcePoint)
	if not self._lightResourcePointDict then
		self:_refreshLightResourcePoint()
	end

	return self._lightResourcePointDict[tostring(resourcePoint)]
end

function RoomMapBuildingModel:clearLightResourcePoint()
	self._lightResourcePointDict = nil
end

function RoomMapBuildingModel:getTotalReserve(buildingUid)
	local buildingMO = self:getBuildingMOById(buildingUid)

	if not buildingMO then
		return 0
	end

	return buildingMO.config.reserve
end

function RoomMapBuildingModel:debugPlaceBuilding(hexPoint, info)
	local buildingMO = RoomBuildingMO.New()

	buildingMO:init(info)
	self:_addBuildingMO(buildingMO)

	return buildingMO
end

function RoomMapBuildingModel:debugRootOutBuilding(hexPoint)
	local buildingMO = self:getBuildingMO(hexPoint.x, hexPoint.y)

	self:_removeBuildingMO(buildingMO)

	return buildingMO
end

function RoomMapBuildingModel:debugMoveAllBuilding(offsetX, offsetY)
	local list = self:getList()

	if not list then
		return
	end

	for _, buildingMO in ipairs(list) do
		local x = buildingMO.hexPoint.x
		local y = buildingMO.hexPoint.y
		local newX = x + offsetX
		local newY = y + offsetY

		buildingMO.hexPoint = HexPoint(newX, newY)
		self._mapBuildingMODict[x][y] = nil
		self._mapBuildingMODict[newX] = self._mapBuildingMODict[newX] or {}
		self._mapBuildingMODict[newX][newY] = buildingMO
	end

	self:refreshAllOccupyDict()
end

function RoomMapBuildingModel:getRevertHexPoint()
	return self._revertHexPoint
end

function RoomMapBuildingModel:getRevertRotate()
	return self._revertRotate
end

function RoomMapBuildingModel:getBuildingListByType(buildingType, isSort)
	local result = self._type2BuildingDict[buildingType]

	if result and isSort then
		table.sort(result, RoomHelper.sortBuildingById)
	end

	return result
end

function RoomMapBuildingModel:isHasCritterByBuid(buildingUid)
	if not self._isHasCritterDict then
		self._isHasCritterDict = {}

		local critterMOList = CritterModel.instance:getAllCritters()

		for i, critterMO in ipairs(critterMOList) do
			if critterMO.workInfo.buildingUid and critterMO.workInfo.buildingUid ~= 0 then
				self._isHasCritterDict[critterMO.workInfo.buildingUid] = true
			elseif critterMO.restInfo.restBuildingUid and critterMO.restInfo.restBuildingUid ~= 0 then
				self._isHasCritterDict[critterMO.restInfo.restBuildingUid] = true
			end
		end
	end

	return self._isHasCritterDict[buildingUid]
end

function RoomMapBuildingModel:getBuildingMoByBuildingId(buildingId)
	local list = self:getList()

	if list then
		for k, v in pairs(list) do
			if v.buildingId == buildingId then
				return v
			end
		end
	end
end

RoomMapBuildingModel.instance = RoomMapBuildingModel.New()

return RoomMapBuildingModel
