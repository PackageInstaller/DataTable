-- chunkname: @modules/logic/room/model/map/RoomResourceModel.lua

module("modules.logic.room.model.map.RoomResourceModel", package.seeall)

local RoomResourceModel = class("RoomResourceModel", BaseModel)

function RoomResourceModel:ctor()
	RoomResourceModel.super.ctor(self)

	self._allResourcePointDic = {}
	self._allResourcePointList = {}
	self._blockPointDic = {}
	self._mapMaxRadius = 400
end

function RoomResourceModel:onInit()
	self:_clearData()
end

function RoomResourceModel:reInit()
	self:_clearData()
end

function RoomResourceModel:clear()
	RoomResourceModel.super.clear(self)
	self:_clearData()
end

function RoomResourceModel:_clearData()
	self._resourceAreaList = nil
	self._resourcePointToAreaIndex = nil
	self._lightResourcePointDict = nil
	self._blockPointDic = {}

	if self._resourcePointAreaModel then
		self._resourcePointAreaModel:clear()
	end
end

function RoomResourceModel:init()
	self:clear()

	self._resourcePointAreaModel = self._resourcePointAreaModel or BaseModel.New()

	local cfgMax = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)

	if cfgMax then
		self._mapMaxRadius = math.max(cfgMax, self._mapMaxRadius)
	end

	self:_initLigheResourcePoint()
end

function RoomResourceModel:_initLigheResourcePoint()
	local tempMapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO then
		if not tempBuildingMO.id then
			local tempBlockId

			for x, dict in pairs(tempMapBlockMODict) do
				for y, blockMO in pairs(dict) do
					if tempBlockId ~= blockMO.id then
						self:_addBlockMO(blockMO)
					end
				end
			end
		end
	end
end

function RoomResourceModel:_addBlockMO(blockMO)
	local tRoomConfig = RoomConfig.instance

	for direction = 0, 6 do
		local resourceId = blockMO:getResourceId(direction)

		if tRoomConfig:isLightByResourceId(resourceId) then
			local areaMO = self._resourcePointAreaModel:getById(resourceId)

			if not areaMO then
				areaMO = RoomMapResorcePointAreaMO.New()

				areaMO:init(resourceId, resourceId)
				self._resourcePointAreaModel:addAtLast(areaMO)
			end

			local resourcePoint = self:getResourcePoint(blockMO.hexPoint.x, blockMO.hexPoint.y, direction)

			areaMO:addResPoint(resourcePoint)

			self._blockPointDic[blockMO.id] = self._blockPointDic[blockMO.id] or resourcePoint
		end
	end
end

function RoomResourceModel:_removeBlockMO(blockMO)
	local resPoint = self._blockPointDic[blockMO.id]

	if resPoint then
		self._blockPointDic[blockMO.id] = nil

		local list = self._resourcePointAreaModel:getList()

		for _, areaMap in ipairs(list) do
			areaMap:removeByXY(resPoint.x, resPoint.y)
		end
	end
end

function RoomResourceModel:unUseBlockList(blockMOList)
	for i, blockMO in ipairs(blockMOList) do
		self:_removeBlockMO(blockMO)
	end
end

function RoomResourceModel:useBlock(blockMO)
	self:_removeBlockMO(blockMO)
	self:_addBlockMO(blockMO)
end

function RoomResourceModel:getIndexByXYD(x, y, direction)
	local radius = self._mapMaxRadius + 1
	local index = (x + radius) * 2 * radius + y + radius

	return index * 100 + direction
end

function RoomResourceModel:getIndexByXY(x, y)
	return self:getIndexByXYD(x, y, 0)
end

function RoomResourceModel:getResourcePoint(x, y, direction)
	local index = self:getIndexByXYD(x, y, direction)
	local resPoint = self._allResourcePointDic[index]

	if not resPoint then
		resPoint = ResourcePoint(HexPoint(x, y), direction)
		self._allResourcePointDic[index] = resPoint

		table.insert(self._allResourcePointList, resPoint)
	end

	return resPoint
end

function RoomResourceModel:_refreshResourceAreaList()
	self._resourceAreaList = {}
	self._resourcePointToAreaIndex = {}
end

function RoomResourceModel:getResourceAreaList()
	if not self._resourceAreaList or not self._resourcePointToAreaIndex then
		self:_refreshResourceAreaList()
	end

	return self._resourceAreaList
end

function RoomResourceModel:getResourceAreaById(index)
	if not self._resourceAreaList or not self._resourcePointToAreaIndex then
		self:_refreshResourceAreaList()
	end

	return self._resourceAreaList[index]
end

function RoomResourceModel:getResourceArea(resourcePoint)
	if not self._resourceAreaList or not self._resourcePointToAreaIndex then
		self:_refreshResourceAreaList()
	end

	for i, resourceArea in ipairs(self._resourceAreaList) do
		if resourceArea.resourcePointDict[resourcePoint.x] and resourceArea.resourcePointDict[resourcePoint.x][resourcePoint.y] and resourceArea.resourcePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction] then
			return resourceArea
		end
	end

	return nil
end

function RoomResourceModel:getResourcePointToAreaIndex(resourcePoint)
	if not self._resourceAreaList or not self._resourcePointToAreaIndex then
		self:_refreshResourceAreaList()
	end

	return self._resourcePointToAreaIndex[tostring(resourcePoint)]
end

function RoomResourceModel:clearResourceAreaList()
	self._resourceAreaList = nil
end

function RoomResourceModel:_refreshBuildingLightResourcePoint()
	self._lightResourcePointDict = {}

	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return
	end

	local occupyDict = RoomBuildingHelper.getOccupyDict(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate, tempBuildingMO.buildingUid)

	for x, dict in pairs(occupyDict) do
		for y, buildingParam in pairs(dict) do
			local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)
			local isJudge = blockMO and RoomBuildingHelper.isJudge(blockMO.hexPoint, blockMO.id)

			if blockMO and isJudge then
				local replaceDefineId = blockMO.replaceDefineId
				local replaceRotate = blockMO.replaceRotate

				blockMO.replaceDefineId = buildingParam.blockDefineId
				blockMO.replaceRotate = buildingParam.blockDefineId and buildingParam.blockRotate

				local costResource = RoomBuildingHelper.getCostResource(tempBuildingMO.buildingId)
				local blockRotate = blockMO:getRotate()

				for i = 1, 6 do
					local resourceId = blockMO:getResourceId(i)

					if resourceId ~= RoomResourceEnum.ResourceId.None and resourceId ~= RoomResourceEnum.ResourceId.Empty and RoomBuildingHelper.checkCostResource(costResource, resourceId) then
						local direction = RoomRotateHelper.rotateDirection(i, blockRotate)
						local index = self:getIndexByXYD(blockMO.hexPoint.x, blockMO.hexPoint.y, direction)

						self._lightResourcePointDict[index] = true
					end
				end

				blockMO.replaceDefineId = replaceDefineId
				blockMO.replaceRotate = replaceRotate
			end
		end
	end
end

function RoomResourceModel:_refreshLightResourcePoint()
	self._lightResourcePointDict = {}

	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if not tempBlockMO or not tempBlockMO:isHasLight() then
		return
	end

	local tRoomConfig = RoomConfig.instance
	local blockMO = tempBlockMO
	local hexPoint = blockMO.hexPoint
	local resAreaDic = {}

	for direction = 1, 6 do
		local resourceId = blockMO:getResourceId(direction)
		local areaMO = self._resourcePointAreaModel:getById(resourceId)

		if tRoomConfig:isLightByResourceId(resourceId) and areaMO then
			resAreaDic[resourceId] = resAreaDic[resourceId] or {}

			local resourcePoint = self:getResourcePoint(hexPoint.x, hexPoint.y, direction)
			local connectPoints = areaMO:getConnectsAll(direction)
			local isLight = false

			for _, connectPoint in ipairs(connectPoints) do
				if connectPoint.x ~= 0 or connectPoint.y ~= 0 then
					local tx = connectPoint.x + resourcePoint.x
					local ty = connectPoint.y + resourcePoint.y
					local areaId = areaMO:getAreaIdByXYD(tx, ty, connectPoint.direction)

					if areaId then
						isLight = true
					end

					if areaId and not resAreaDic[resourceId][areaId] then
						resAreaDic[resourceId][areaId] = true

						local list = areaMO:getResorcePiontListByXYD(tx, ty, connectPoint.direction)

						for __, _tempPoint in ipairs(list) do
							local index = self:getIndexByXYD(_tempPoint.x, _tempPoint.y, _tempPoint.direction)

							self._lightResourcePointDict[index] = resourceId
						end
					end
				end
			end

			if isLight then
				local index = self:getIndexByXYD(resourcePoint.x, resourcePoint.y, resourcePoint.direction)

				self._lightResourcePointDict[index] = resourceId

				for _, connectPoint in ipairs(connectPoints) do
					if connectPoint.x == 0 or connectPoint.y == 0 then
						local connResId = blockMO:getResourceId(connectPoint.direction)

						if resourceId == connResId then
							local tx = connectPoint.x + resourcePoint.x
							local ty = connectPoint.y + resourcePoint.y
							local index = self:getIndexByXYD(tx, ty, connectPoint.direction)

							self._lightResourcePointDict[index] = resourceId
						end
					end
				end
			end
		end
	end
end

function RoomResourceModel:_refreshWaterReformLightResourcePoint()
	local resourceId = RoomResourceEnum.ResourceId.River

	self._lightResourcePointDict = {}

	local areaMO = self._resourcePointAreaModel:getById(resourceId)

	if not areaMO then
		return
	end

	local selectAreaId = RoomWaterReformModel.instance:getSelectAreaId()
	local tempAreaList = areaMO:findeArea()

	for areaId, area in ipairs(tempAreaList) do
		if areaId ~= selectAreaId then
			for _, tmpPoint in ipairs(area) do
				local index = self:getIndexByXYD(tmpPoint.x, tmpPoint.y, tmpPoint.direction)

				self._lightResourcePointDict[index] = resourceId
			end
		end
	end
end

function RoomResourceModel:isLightResourcePoint(x, y, direction)
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not self._lightResourcePointDict then
		if RoomBuildingController.instance:isBuildingListShow() then
			return false
		elseif isWaterReform then
			return false
		else
			self:_refreshLightResourcePoint()
		end
	end

	local index = self:getIndexByXYD(x, y, direction)

	return self._lightResourcePointDict[index]
end

function RoomResourceModel:clearLightResourcePoint()
	self._lightResourcePointDict = nil
end

RoomResourceModel.instance = RoomResourceModel.New()

return RoomResourceModel
