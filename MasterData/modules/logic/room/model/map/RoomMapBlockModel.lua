-- chunkname: @modules/logic/room/model/map/RoomMapBlockModel.lua

module("modules.logic.room.model.map.RoomMapBlockModel", package.seeall)

local RoomMapBlockModel = class("RoomMapBlockModel", BaseModel)

function RoomMapBlockModel:onInit()
	self:_clearData()
end

function RoomMapBlockModel:reInit()
	self:_clearData()
end

function RoomMapBlockModel:clear()
	RoomMapBlockModel.super.clear(self)
	self:_clearData()
end

function RoomMapBlockModel:_clearData()
	self._mapBlockMOList = {}
	self._mapBlockMODict = {}

	if self._emptyBlockModel then
		self._emptyBlockModel:clear()
	end

	self._emptyBlockModel = BaseModel.New()

	if self._fullBlockModel then
		self._fullBlockModel:clear()
	end

	self._fullBlockModel = BaseModel.New()
	self._tempBlockMO = nil
	self._emptyId = -1000
	self._convexHull = nil
	self._convexHexPointDict = nil
	self._isBackMore = false

	if self._backBlockModel then
		self._backBlockModel:clear()
	end

	self._backBlockModel = BaseModel.New()
end

function RoomMapBlockModel:getBackBlockModel()
	return self._backBlockModel
end

function RoomMapBlockModel:isCanBackBlock()
	if self._backBlockModel:getCount() < 1 then
		return false
	end

	if RoomEnum.IsBlockNeedConnInit then
		local blockMOList = self:getFullListNoTempBlockMO()
		local backBlockMOList = self._backBlockModel:getList()

		if RoomBackBlockHelper.isCanBack(blockMOList, backBlockMOList) then
			return true
		end

		return false
	end

	if RoomBackBlockHelper.isHasInitBlock(self._backBlockModel:getList()) then
		return false
	end

	return true
end

function RoomMapBlockModel:getFullListNoTempBlockMO()
	if not self:getTempBlockMO() then
		return self._fullBlockModel:getList()
	end

	local backBlockMOList = {}

	tabletool.addValues(backBlockMOList, self._fullBlockModel:getList())
	tabletool.removeValue(backBlockMOList, self:getTempBlockMO())

	return backBlockMOList
end

function RoomMapBlockModel:backBlockById(blockId)
	local blockMO = self:getFullBlockMOById(blockId)

	if blockMO then
		blockMO:setOpState(RoomBlockEnum.OpState.Normal)
		self:_removeBlockMO(blockMO)
		self._backBlockModel:remove(blockMO)
		self:_placeOneEmptyBlock(blockMO.hexPoint)

		return blockMO
	end
end

function RoomMapBlockModel:isBackMore()
	return self._isBackMore
end

function RoomMapBlockModel:setBackMore(isBackMore)
	self._isBackMore = isBackMore == true
end

function RoomMapBlockModel:initMap(infos)
	self:clear()

	if not infos or #infos <= 0 then
		return
	end

	for i, info in ipairs(infos) do
		if info.use ~= false then
			local blockInfo = RoomInfoHelper.serverInfoToBlockInfo(info)
			local blockMO = RoomBlockMO.New()

			blockMO:init(blockInfo)
			self:_addBlockMO(blockMO)
		end
	end

	self:_refreshEmpty()
	self:_refreshConvexHull()
end

function RoomMapBlockModel:_refreshEmpty()
	local emptyDict = {}
	local fullBlockMOList = self._fullBlockModel:getList()

	for _, fullMO in ipairs(fullBlockMOList) do
		local hexPoint = fullMO.hexPoint

		for distance = 1, RoomBlockEnum.EmptyBlockDistanceStyleCount do
			local ranges = hexPoint:getOnRanges(distance)
			local distanceStyle = distance

			for _, range in ipairs(ranges) do
				emptyDict[range.x] = emptyDict[range.x] or {}
				emptyDict[range.x][range.y] = math.min(emptyDict[range.x][range.y] or RoomBlockEnum.EmptyBlockDistanceStyleCount, distanceStyle)
			end
		end
	end

	local count = 0

	for x, dict in pairs(emptyDict) do
		for y, distanceStyle in pairs(dict) do
			local emptyMO = self:getBlockMO(x, y)

			count = count + 1

			if emptyMO then
				self:_refreshEmptyMO(emptyMO, distanceStyle)
			else
				self:_placeOneEmptyBlock(HexPoint(x, y), distanceStyle)
			end
		end
	end
end

function RoomMapBlockModel:_placeEmptyBlock(blockMO)
	local hexPoint = blockMO.hexPoint
	local neighbors = hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for _, neighbor in ipairs(neighbors) do
		local neighborMO = self:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO then
			self:_refreshEmptyMO(neighborMO)
		else
			self:_placeOneEmptyBlock(neighbor)
		end
	end
end

function RoomMapBlockModel:_placeOneEmptyBlock(hexPoint, distanceStyle)
	local emptyId = self:_getEmptyGUID(hexPoint.x, hexPoint.y)
	local emptyMO = self._emptyBlockModel:getById(emptyId)

	if emptyMO then
		emptyMO.distanceStyle = distanceStyle

		self:_addBlockMOToMapDict(emptyMO)
	else
		emptyMO = RoomBlockMO.New()

		local emptyInfo = RoomInfoHelper.generateEmptyMapBlockInfo(emptyId, hexPoint.x, hexPoint.y, distanceStyle)

		emptyMO:init(emptyInfo)
		self:_addBlockMO(emptyMO)
	end

	self:_refreshEmptyMO(emptyMO, distanceStyle)
end

function RoomMapBlockModel:_addBlockMOToMapDict(mo)
	local hexPoint = mo.hexPoint

	self._mapBlockMODict[hexPoint.x] = self._mapBlockMODict[hexPoint.x] or {}
	self._mapBlockMODict[hexPoint.x][hexPoint.y] = mo

	table.insert(self._mapBlockMOList, mo)
end

function RoomMapBlockModel:_addBlockMO(mo)
	self:_addBlockMOToMapDict(mo)

	if mo.blockState == RoomBlockEnum.BlockState.Water then
		self._emptyBlockModel:addAtLast(mo)
	else
		self._fullBlockModel:addAtLast(mo)
	end
end

function RoomMapBlockModel:_removeBlockMO(mo)
	local hexPoint = mo.hexPoint

	if self._mapBlockMODict[hexPoint.x] then
		self._mapBlockMODict[hexPoint.x][hexPoint.y] = nil
	end

	local index = tabletool.indexOf(self._mapBlockMOList, mo)

	if index then
		table.remove(self._mapBlockMOList, index)
	end

	if mo.blockState == RoomBlockEnum.BlockState.Water then
		self._emptyBlockModel:remove(mo)
	else
		self._fullBlockModel:remove(mo)
	end
end

function RoomMapBlockModel:addTempBlockMO(inventoryBlockMO, hexPoint)
	if self._tempBlockMO then
		logError("暂不支持两个临时地块")

		return
	end

	local originalMO = self:getBlockMO(hexPoint.x, hexPoint.y)

	if originalMO then
		self:_removeBlockMO(originalMO)
	end

	local inventoryInfo = RoomInfoHelper.blockMOToBlockInfo(inventoryBlockMO)

	self._tempBlockMO = RoomBlockMO.New()
	inventoryInfo.blockState = RoomBlockEnum.BlockState.Temp
	inventoryInfo.x = hexPoint.x
	inventoryInfo.y = hexPoint.y

	self._tempBlockMO:init(inventoryInfo)
	self:_addBlockMO(self._tempBlockMO)

	return self._tempBlockMO
end

function RoomMapBlockModel:getTempBlockMO()
	return self._tempBlockMO
end

function RoomMapBlockModel:changeTempBlockMO(hexPoint, rotate)
	if not self._tempBlockMO then
		return
	end

	self._tempBlockMO.rotate = rotate

	if self._tempBlockMO.hexPoint ~= hexPoint then
		local previousHexPoint = HexPoint(self._tempBlockMO.hexPoint.x, self._tempBlockMO.hexPoint.y)
		local originalMO = self:getBlockMO(hexPoint.x, hexPoint.y)

		if originalMO then
			self:_removeBlockMO(originalMO)
		end

		self:_removeBlockMO(self._tempBlockMO)

		self._tempBlockMO.hexPoint = hexPoint

		self:_addBlockMO(self._tempBlockMO)
		self:_placeOneEmptyBlock(previousHexPoint)
	end
end

function RoomMapBlockModel:removeTempBlockMO()
	if not self._tempBlockMO then
		return
	end

	local hexPoint = self._tempBlockMO.hexPoint

	self:_removeBlockMO(self._tempBlockMO)
	self:_placeOneEmptyBlock(hexPoint)

	self._tempBlockMO = nil
end

function RoomMapBlockModel:placeTempBlockMO(info)
	if not self._tempBlockMO then
		return
	end

	local blockMO = RoomBlockMO.New()
	local blockInfo = RoomInfoHelper.serverInfoToBlockInfo(info)

	blockMO:init(blockInfo)

	local blockColor = RoomWaterReformModel.instance:getBlockPermanentInfo(self._tempBlockMO.blockId)

	if blockColor and blockColor ~= RoomWaterReformModel.InitBlockColor then
		self._tempBlockMO:setBlockColorType(blockColor)
	end

	self._tempBlockMO.rotate = blockMO.rotate
	self._tempBlockMO.blockState = RoomBlockEnum.BlockState.Map

	self:_placeEmptyBlock(self._tempBlockMO)

	self._tempBlockMO = nil

	self:_refreshConvexHull()
end

function RoomMapBlockModel:getBlockMO(x, y)
	return self._mapBlockMODict[x] and self._mapBlockMODict[x][y]
end

function RoomMapBlockModel:getBlockMOList()
	return self._mapBlockMOList
end

function RoomMapBlockModel:getBlockMODict()
	return self._mapBlockMODict
end

function RoomMapBlockModel:getEmptyBlockMOList()
	return self._emptyBlockModel:getList()
end

function RoomMapBlockModel:getFullBlockMOList()
	return self._fullBlockModel:getList()
end

function RoomMapBlockModel:getEmptyBlockMOById(id)
	return self._emptyBlockModel:getById(id)
end

function RoomMapBlockModel:getFullBlockMOById(id)
	return self._fullBlockModel:getById(id)
end

function RoomMapBlockModel:getFullBlockCount()
	local count = self._fullBlockModel:getCount()

	if self._tempBlockMO then
		count = count - 1
	end

	return count
end

function RoomMapBlockModel:getConfirmBlockCount()
	local count = 0
	local blockMOList = self._fullBlockModel:getList()

	for i, blockMO in ipairs(blockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map and blockMO.blockId > 0 then
			count = count + 1
		end
	end

	return count
end

function RoomMapBlockModel:getMaxBlockCount(roomLevel)
	if not roomLevel then
		::label_32_0::

		local roomLevel = RoomMapModel.instance:getRoomLevel()
		local roomLevelConfig = RoomConfig.instance:getRoomLevelConfig(roomLevel)

		roomLevelConfig = roomLevelConfig or RoomConfig.instance:getRoomLevelConfig(RoomConfig.instance:getMaxRoomLevel())

		if roomLevelConfig then
			if not roomLevelConfig.maxBlockCount then
				local count = 0

				count = count + self:getTradeBlockCount()

				return count
			end
		end
	end
end

function RoomMapBlockModel:getTradeBlockCount()
	local tradeLevel = ManufactureModel.instance:getTradeLevel()
	local trandLevelCfg = ManufactureConfig.instance:getTradeLevelCfg(tradeLevel, false)

	return (trandLevelCfg or nil) and (trandLevelCfg.addBlockMax or 0)
end

function RoomMapBlockModel:_refreshConvexHull()
	self._convexHull = {}

	local blockMOList = self._fullBlockModel:getList()
	local points = {}

	for _, blockMO in ipairs(blockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map then
			local hexPoint = blockMO.hexPoint
			local position = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)
			local area = RoomBlockEnum.BlockSize * 3

			table.insert(points, position + Vector2(1.1546 * area, 0))
			table.insert(points, position + Vector2(0.5773 * area, -area))
			table.insert(points, position + Vector2(-0.5773 * area, -area))
			table.insert(points, position + Vector2(-1.1546 * area, 0))
			table.insert(points, position + Vector2(-0.5773 * area, area))
			table.insert(points, position + Vector2(0.5773 * area, area))
		end
	end

	self._convexHull = RoomCameraHelper.getConvexHull(points)

	local expandConvexHull = RoomCameraHelper.expandConvexHull(self._convexHull, RoomBlockEnum.BlockSize * 10)

	self._convexHexPointDict = RoomCameraHelper.getConvexHexPointDict(expandConvexHull)
end

function RoomMapBlockModel:getConvexHull()
	if not self._convexHull then
		self:_refreshConvexHull()
	end

	return self._convexHull
end

function RoomMapBlockModel:getConvexHexPointDict()
	if not self._convexHexPointDict then
		self:_refreshConvexHull()
	end

	return self._convexHexPointDict
end

function RoomMapBlockModel:_getEmptyGUID(x, y)
	local mapMaxRadius = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)
	local radius = mapMaxRadius + 1
	local index = (x + radius) * 2 * radius + y + radius

	return self._emptyId - index
end

function RoomMapBlockModel:refreshNearRiver(hexPoint, range)
	local nears = hexPoint:getInRanges(range)

	for _, near in ipairs(nears) do
		local nearMO = self:getBlockMO(near.x, near.y)

		if nearMO and nearMO.blockState ~= RoomBlockEnum.BlockState.Water then
			nearMO:refreshRiver()
		end
	end
end

function RoomMapBlockModel:refreshNearRiverByHexPointList(hexPointList, range)
	local dict = {}

	for _, hexPoint in ipairs(hexPointList) do
		local nears = hexPoint:getInRanges(range)

		for _, near in ipairs(nears) do
			local nearMO = self:getBlockMO(near.x, near.y)
			local blockId = nearMO.blockId

			if nearMO and nearMO.blockState ~= RoomBlockEnum.BlockState.Water and not dict[blockId] then
				dict[blockId] = nearMO
			end
		end
	end

	for _, nearMO in pairs(dict) do
		nearMO:refreshRiver()
	end
end

function RoomMapBlockModel:_refreshEmptyMO(emptyMO, distanceStyle)
	return
end

function RoomMapBlockModel:debugConfirmPlaceBlock(hexPoint, info)
	local blockMO = RoomBlockMO.New()

	blockMO:init(info)

	local emptyMO = self:getBlockMO(hexPoint.x, hexPoint.y)

	if emptyMO then
		self:_removeBlockMO(emptyMO)
	end

	self:_addBlockMO(blockMO)
	self:_placeEmptyBlock(blockMO)
	self:_refreshConvexHull()

	return blockMO, emptyMO
end

function RoomMapBlockModel:debugRootOutBlock(hexPoint)
	local blockMO = self:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO then
		self:_removeBlockMO(blockMO)
	end

	local neighbors = hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)
	local emptyMOList = {}

	for _, neighbor in ipairs(neighbors) do
		local flag = false
		local neighborMO = self:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Water then
			local flag2 = false
			local neighbors2 = neighbor:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

			for _, neighbor2 in ipairs(neighbors2) do
				local neighbor2MO = self:getBlockMO(neighbor2.x, neighbor2.y)

				if neighbor2MO and neighbor2MO.blockState == RoomBlockEnum.BlockState.Map then
					flag2 = true

					break
				end
			end

			if flag2 then
				self:_refreshEmptyMO(neighborMO)
			else
				self:_removeBlockMO(neighborMO)
				table.insert(emptyMOList, neighborMO)
			end
		elseif neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Map then
			flag = true
		end

		if flag then
			self:_placeOneEmptyBlock(hexPoint)
		end
	end

	self:_refreshConvexHull()

	return emptyMOList
end

function RoomMapBlockModel:debugMoveAllBlock(offsetX, offsetY)
	if not self._mapBlockMOList then
		return
	end

	for _, blockMO in ipairs(self._mapBlockMOList) do
		local x = blockMO.hexPoint.x
		local y = blockMO.hexPoint.y
		local newX = x + offsetX
		local newY = y + offsetY

		blockMO.hexPoint = HexPoint(newX, newY)
		self._mapBlockMODict[x][y] = nil
		self._mapBlockMODict[newX] = self._mapBlockMODict[newX] or {}
		self._mapBlockMODict[newX][newY] = blockMO
	end
end

function RoomMapBlockModel:getFullMapSizeAndCenter()
	local max_x, max_y, min_x, min_y = 0, 0, 0, 0

	for _, blockMo in ipairs(self._mapBlockMOList) do
		local hexPoint = blockMo.hexPoint
		local v2 = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

		max_x = math.max(max_x, v2.x)
		max_y = math.max(max_y, v2.y)
		min_x = math.min(min_x, v2.x)
		min_y = math.min(min_y, v2.y)
	end

	local wight = math.floor((max_x - min_x) * RoomEnum.WorldPosToAStarMeshWidth)
	local height = math.floor((max_y - min_y) * RoomEnum.WorldPosToAStarMeshDepth)
	local offsetX, offsetY = 0, 0

	wight = math.min(wight, RoomEnum.AStarMeshMaxWidthOrDepth)
	height = math.min(height, RoomEnum.AStarMeshMaxWidthOrDepth)

	return wight, height, (max_x + min_x) * 0.5, (max_y + min_y) * 0.5
end

RoomMapBlockModel.instance = RoomMapBlockModel.New()

return RoomMapBlockModel
