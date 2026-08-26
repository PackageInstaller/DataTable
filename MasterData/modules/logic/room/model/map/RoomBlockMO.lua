-- chunkname: @modules/logic/room/model/map/RoomBlockMO.lua

module("modules.logic.room.model.map.RoomBlockMO", package.seeall)

local RoomBlockMO = pureTable("RoomBlockMO")

function RoomBlockMO:init(info)
	if info.fishingBlockId then
		self.id = info.fishingBlockId
		self.blockId = info.fishingBlockId
		self.isFishingBlock = true
	else
		self.id = info.blockId
		self.blockId = info.blockId
		self.isFishingBlock = false
	end

	self.defineId = info.defineId
	self.packageId = info.packageId
	self.packageOrder = info.packageOrder
	self.mainRes = info.mainRes
	self.rotate = info.rotate or 0
	self.blockState = info.blockState or RoomBlockEnum.BlockState.Inventory
	self.ownType = info.ownType or RoomBlockEnum.OwnType.Package
	self.useState = info.useState or RoomBlockEnum.UseState.Normal
	self.blockCleanType = info.blockCleanType or 0

	if self:isInMap() then
		self.hexPoint = HexPoint(info.x or 0, info.y or 0)
	end

	if self.blockState == RoomBlockEnum.BlockState.Water then
		self.distanceStyle = info.distanceStyle
	end

	self._riverTypeDict = nil
	self.replaceDefineId = nil
	self.replaceRotate = nil

	self:setWaterType(info.waterType or RoomWaterReformModel.InitWaterType)
	self:setTempWaterType()

	self._defineWaterType = info.defineWaterType

	self:setBlockColorType(info.blockColor or RoomWaterReformModel.InitBlockColor)
	self:setTempBlockColorType()

	self._resourceListDic = {}
	self._isHasLightDic = {}
end

function RoomBlockMO:getMainRes()
	return self.mainRes
end

function RoomBlockMO:getBlockDefineCfg(isSelf)
	local defineId = self:getDefineId(isSelf)

	if not self._blockDefineCfg or self._blockDefineCfg.defineId ~= defineId then
		self._blockDefineCfg = RoomConfig.instance:getBlockDefineConfig(defineId)
	end

	return self._blockDefineCfg
end

function RoomBlockMO:getDefineBlockType(isSelf)
	if self:isInMapBlock() then
		local tempBlockColorType = self:getTempBlockColorType()

		if tempBlockColorType and tempBlockColorType ~= RoomWaterReformModel.InitBlockColor then
			return tempBlockColorType
		elseif tempBlockColorType == RoomWaterReformModel.InitBlockColor then
			local blockDefineConfig = self:getBlockDefineCfg(isSelf)

			return (blockDefineConfig or nil) and (blockDefineConfig.blockType or 0)
		end
	end

	return (self:getOriginalBlockType(isSelf))
end

function RoomBlockMO:getOriginalBlockType(isSelf)
	local blockColorType = self:getBlockColorType()

	if blockColorType then
		return blockColorType
	end

	local blockDefineConfig = self:getBlockDefineCfg(isSelf)

	return (blockDefineConfig or nil) and (blockDefineConfig.blockType or 0)
end

function RoomBlockMO:getTempBlockColorType()
	return self.tempBlockColor
end

function RoomBlockMO:getBlockColorType()
	if self.blockState == RoomBlockEnum.BlockState.Inventory or self.blockState == RoomBlockEnum.BlockState.Temp then
		local blockColor = RoomWaterReformModel.instance:getBlockPermanentInfo(self.blockId)

		if blockColor and blockColor ~= RoomWaterReformModel.InitBlockColor then
			return blockColor
		end
	end

	if self.blockColor == RoomWaterReformModel.InitBlockColor then
		return
	end

	return self.blockColor
end

function RoomBlockMO:getDefineId(isSelf)
	return (isSelf or nil) and (self.defineId or self.replaceDefineId or self.defineId)
end

function RoomBlockMO:getRotate(isSelf)
	local var_9_0

	if isSelf then
		var_9_0 = self.rotate

		if not self.rotate then
			if self.replaceDefineId then
				var_9_0 = self.replaceRotate or self.rotate
			end
		end
	end

	return var_9_0
end

function RoomBlockMO:getDefineWaterType(isCfg, isSelf)
	if not isCfg and not isSelf and self:isInMapBlock() then
		local tempWaterType = self:getTempWaterType()

		if tempWaterType and tempWaterType ~= RoomWaterReformModel.InitWaterType then
			return tempWaterType
		end
	end

	return (self:getOriginalWaterType(isSelf))
end

function RoomBlockMO:getOriginalWaterType(isSelf)
	if not isSelf and self:isInMapBlock() then
		local waterType = self:getWaterType()

		if waterType and waterType ~= RoomWaterReformModel.InitWaterType then
			return waterType
		end
	end

	local defineWaterType = self._defineWaterType

	if not defineWaterType then
		local blockDefineConfig = self:getBlockDefineCfg(isSelf)

		defineWaterType = blockDefineConfig and blockDefineConfig.waterType or 0
	end

	return defineWaterType
end

function RoomBlockMO:getTempWaterType()
	return self.tempWaterType
end

function RoomBlockMO:getWaterType()
	return self.waterType
end

function RoomBlockMO:getDefineWaterAreaType(isSelf)
	local blockDefineConfig = self:getBlockDefineCfg(isSelf)

	return (blockDefineConfig or nil) and (blockDefineConfig.waterAreaType or 0)
end

function RoomBlockMO:isFullWater(isSelf)
	local riveCount = self:getRiverCount(isSelf)

	if riveCount < 1 and self:getResourceCenter(isSelf) ~= RoomResourceEnum.ResourceId.River then
		return false
	end

	if riveCount >= 6 then
		return true
	end

	return self:isHalfLakeWater(isSelf)
end

function RoomBlockMO:isHalfLakeWater(isSelf)
	return self:getDefineWaterAreaType(isSelf) == 1
end

function RoomBlockMO:getResourceList(isSelf)
	local blockDefineConfig = self:getBlockDefineCfg(isSelf)

	if not blockDefineConfig then
		local defineId = -1000

		self._isHasLightDic[defineId] = false

		return RoomResourceEnum.Block.NoneList
	end

	if not self._resourceListDic[self._blockDefineCfg.defineId] then
		local resourceList = {}
		local isHasLight = false

		for i = 1, 6 do
			local resourceId = blockDefineConfig.resourceIds[i + 1]

			table.insert(resourceList, resourceId)

			if not isHasLight and RoomConfig.instance:isLightByResourceId(resourceId) then
				isHasLight = true
			end
		end

		self._isHasLightDic[self._blockDefineCfg.defineId] = isHasLight
		self._resourceListDic[self._blockDefineCfg.defineId] = resourceList
	end

	if self:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if blockDefineConfig.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.Block.RiverList
		end

		return RoomResourceEnum.Block.NoneList
	end

	return self._resourceListDic[self._blockDefineCfg.defineId]
end

function RoomBlockMO:isHasLight(isSelf)
	local isLight = self._isHasLightDic[self:getDefineId(isSelf)]

	if isLight == nil then
		self:getResourceList(isSelf)

		return self._isHasLightDic[self:getDefineId(isSelf)]
	end

	return isLight
end

function RoomBlockMO:getResourceCenter(isSelf)
	local blockDefineConfig = self:getBlockDefineCfg(isSelf)

	if not blockDefineConfig then
		return RoomResourceEnum.ResourceId.None
	end

	if self:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if blockDefineConfig.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.ResourceId.River
		end

		return RoomResourceEnum.ResourceId.None
	end

	return blockDefineConfig.resourceIds[1]
end

function RoomBlockMO:isInMap()
	return self.blockState == RoomBlockEnum.BlockState.Map or self.blockState == RoomBlockEnum.BlockState.Water or self.blockState == RoomBlockEnum.BlockState.Temp
end

function RoomBlockMO:isInMapBlock()
	return self.blockState == RoomBlockEnum.BlockState.Map or self.blockState == RoomBlockEnum.BlockState.Temp
end

function RoomBlockMO:canPlace()
	if self.blockState ~= RoomBlockEnum.BlockState.Water then
		return false
	end

	if not RoomEnum.IsBlockNeedConnInit then
		return true
	end

	local neighbors = self.hexPoint:getNeighbors()

	for i, neighbor in ipairs(neighbors) do
		local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO and neighborMO.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function RoomBlockMO:resetOpState()
	self._opState = RoomBlockEnum.OpState.Normal
end

function RoomBlockMO:getOpState()
	return self._opState or RoomBlockEnum.OpState.Normal
end

function RoomBlockMO:getOpStateParam()
	return self._opStateParamDic and self._opStateParamDic[self._opState]
end

function RoomBlockMO:setOpState(opState, param)
	self._opState = opState
	self._opStateParamDic = self._opStateParamDic or {}
	self._opStateParamDic[opState] = param
end

function RoomBlockMO:setUseState(useState)
	self.useState = useState
end

function RoomBlockMO:getUseState()
	return self.useState or RoomBlockEnum.UseState.Normal
end

function RoomBlockMO:setCleanType(cleanType)
	self.blockCleanType = cleanType or RoomBlockEnum.CleanType.Normal
end

function RoomBlockMO:getCleanType()
	return self.blockCleanType or RoomBlockEnum.CleanType.Normal
end

function RoomBlockMO:setWaterType(waterType)
	self.waterType = waterType
end

function RoomBlockMO:setTempWaterType(waterType)
	self.tempWaterType = waterType
end

function RoomBlockMO:setBlockColorType(blockType)
	self.blockColor = blockType
end

function RoomBlockMO:setTempBlockColorType(blockType)
	self.tempBlockColor = blockType
end

function RoomBlockMO:isWaterGradient()
	local waterType = self:getWaterType()
	local tempWaterType = self:getTempWaterType()

	return (waterType and waterType ~= RoomWaterReformModel.InitWaterType or tempWaterType and tempWaterType ~= RoomWaterReformModel.InitWaterType or nil) and false
end

function RoomBlockMO:getResourceId(direction, withoutRotate, onlyShow)
	if self.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if self.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	local resourceId = RoomResourceEnum.ResourceId.None

	if direction == 0 then
		resourceId = self:getResourceCenter()
	else
		direction = withoutRotate and direction or RoomRotateHelper.rotateDirection(direction, -self:getRotate())

		local resourceList = self:getResourceList()

		resourceId = resourceList[direction]
	end

	return resourceId
end

function RoomBlockMO:getResourceTypeRiver(direction, withoutRotate)
	if self.blockState == RoomBlockEnum.BlockState.Water or self.blockState == RoomBlockEnum.BlockState.Fake then
		return nil
	end

	if direction == 0 then
		return nil
	end

	if not self._riverTypeDict then
		self:refreshRiver()
	end

	direction = withoutRotate and RoomRotateHelper.rotateDirection(direction, self:getRotate()) or direction

	if self._riverTypeDict then
		local riverType = self._riverTypeDict[direction]

		if self._neighborBlockTypeDict then
			local blockType = self._neighborBlockTypeDict[direction]

			if self._neighborBlockBTypeDict then
				local blockBtype = self._neighborBlockBTypeDict[direction]

				return riverType, blockType, blockBtype
			end
		end
	end
end

function RoomBlockMO:refreshRiver()
	local riveCount = self:getRiverCount()

	if riveCount < 1 then
		return
	end

	local isFullWater = self:isFullWater()

	if not self.replaceDefineId then
		if not isFullWater and self._lastRefreshRiverDefineId == self.replaceDefineId then
			return
		end

		self._lastRefreshRiverDefineId = self.replaceDefineId
		self._riverTypeDict, self._neighborBlockTypeDict, self._neighborBlockBTypeDict = RoomRiverHelper.getRiverTypeDictByMO(self)
	end
end

function RoomBlockMO:hasRiver(isSelf)
	return self:getResourceCenter(isSelf) == RoomResourceEnum.ResourceId.River or self:getRiverCount(isSelf) > 0
end

function RoomBlockMO:getRiverCount(isSelf)
	local list = self:getResourceList(isSelf)
	local count = 0

	for _, resourceId in ipairs(list) do
		if resourceId == RoomResourceEnum.ResourceId.River then
			count = count + 1
		end
	end

	return count
end

function RoomBlockMO:getNeighborBlockLinkResourceId(direction, withoutRotate)
	if not direction or direction == 0 or direction > 6 then
		return nil
	end

	if self:isInMap() then
		if withoutRotate then
			direction = RoomRotateHelper.rotateDirection(direction, self:getRotate())
		end

		local neighbor = self.hexPoint:getNeighbor(direction)
		local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x, neighbor.y)

		if neighborMO then
			local oppositeDirection = (direction - 1 + 3) % 6 + 1
			local neighborLinkDirection = RoomRotateHelper.rotateDirection(oppositeDirection, neighborMO:getRotate())

			return neighborMO:getResourceId(neighborLinkDirection, true, true), neighborMO
		end
	end

	return nil
end

function RoomBlockMO:hasNeighborSameBlockType()
	if self:isInMap() then
		local tRoomMapBlockModel = RoomMapBlockModel.instance
		local blockType = self:getDefineBlockType()

		for i = 1, 6 do
			local tempHexPoint = HexPoint.directions[i]
			local neighborMO = tRoomMapBlockModel:getBlockMO(self.hexPoint.x + tempHexPoint.x, self.hexPoint.y + tempHexPoint.y)

			if neighborMO and blockType == neighborMO:getDefineBlockType() then
				return true
			end
		end
	end

	return false
end

return RoomBlockMO
