-- chunkname: @modules/logic/room/utils/RoomBlockHelper.lua

module("modules.logic.room.utils.RoomBlockHelper", package.seeall)

local RoomBlockHelper = {}

function RoomBlockHelper.getNearBlockEntity(isEmpty, hexPoint, range, withoutSelf, isFullRiver)
	local scene = GameSceneMgr.instance:getCurScene()

	if isEmpty then
		if not RoomBlockHelper._getMapEmptyBlockMO then
			-- block empty
		end
	end
end

function RoomBlockHelper.getNearBlockEntityByBuilding(isEmpty, buildingId, hexPoint, rotate)
	local scene = GameSceneMgr.instance:getCurScene()
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)

	if isEmpty then
		if not RoomBlockHelper._getMapEmptyBlockMO then
			-- block empty
		end
	end
end

function RoomBlockHelper.getBlockMOListByPlaceBuilding(buildingId, hexPoint, rotate, blockMOList, blockIndexDict)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)

	if not buildingConfigParam or buildingConfigParam.replaceBlockCount and buildingConfigParam.replaceBlockCount < 1 then
		return blockMOList, blockIndexDict
	end

	blockMOList = blockMOList or {}
	blockIndexDict = {} or {}

	local scene = GameSceneMgr.instance:getCurScene()
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)
end

function RoomBlockHelper.getNearSameBlockTypeEntity(blockMO, repeatDict, resultList)
	if not blockMO then
		return
	end

	repeatDict = repeatDict or {}

	local checkBlockType = blockMO:getDefineBlockType()

	for i = 1, 6 do
		local neighbor = blockMO.hexPoint:getNeighbor(i)
		local x = neighbor.x
		local y = neighbor.y

		if not repeatDict[x] or not repeatDict[x][y] then
			repeatDict[x] = repeatDict[x] or {}
			repeatDict[x][y] = true

			local neighborMO = RoomMapBlockModel.instance:getBlockMO(x, y)
			local blockType = neighborMO and neighborMO:getDefineBlockType()

			if blockType == checkBlockType and neighborMO:isInMap() and neighborMO.blockState == RoomBlockEnum.BlockState.Map then
				local tmpBlockId = neighborMO.blockId
				local hasRiver = neighborMO:hasRiver()
				local isInitBlock = RoomConfig.instance:getInitBlock(tmpBlockId)

				if not hasRiver and not isInitBlock then
					resultList[#resultList + 1] = neighborMO.blockId

					RoomBlockHelper.getNearSameBlockTypeEntity(neighborMO, repeatDict, resultList)
				end
			end
		end
	end
end

function RoomBlockHelper._getMapEmptyBlockMO(x, y)
	local mo = RoomMapBlockModel.instance:getBlockMO(x, y)

	if mo == nil then
		return
	end

	if mo.blockState ~= RoomBlockEnum.BlockState.Water then
		return
	end

	return mo
end

function RoomBlockHelper._getMapBlockMO(x, y, isFullRiver)
	local mo = RoomMapBlockModel.instance:getBlockMO(x, y)

	if mo == nil then
		return
	end

	if mo.blockState == RoomBlockEnum.BlockState.Water then
		return
	end

	if isFullRiver and mo:getRiverCount() < 6 then
		return
	end

	return mo
end

function RoomBlockHelper.refreshBlockEntity(entityList, funcName, paramList)
	if entityList == nil or #entityList < 1 then
		return
	end

	for i, entity in ipairs(entityList) do
		local func = entity[funcName]

		if func then
			if paramList then
				func(entity, unpack(paramList))
			else
				func(entity)
			end
		end
	end
end

function RoomBlockHelper.refreshBlockResourceType(entityList)
	for i, entity in ipairs(entityList) do
		local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(entity.id)

		if blockMO then
			blockMO:refreshRiver()
		end
	end
end

function RoomBlockHelper.getMapResourceId(blockMO)
	if blockMO.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if blockMO.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	local allOccpyDict = RoomMapBuildingModel.instance:getAllOccupyDict()

	if allOccpyDict[blockMO.hexPoint.x] then
		local param = allOccpyDict[blockMO.hexPoint.x][blockMO.hexPoint.y]
		local buildingUid = param and param.buildingUid

		if buildingUid then
			::label_9_0::

			local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
			local costResourceId = buildingMO and RoomBuildingHelper.getCostResourceId(buildingMO.buildingId)

			if costResourceId and costResourceId ~= RoomResourceEnum.ResourceId.None then
				return costResourceId
			end

			local resourceParamDict = {}
			local repeatResourceAreaDict = {}

			for i = 0, 6 do
				local resourcePoint = ResourcePoint(blockMO.hexPoint, i)
				local resourceArea = RoomResourceModel.instance:getResourceArea(resourcePoint)

				if resourceArea and not repeatResourceAreaDict[resourceArea.index] then
					repeatResourceAreaDict[resourceArea.index] = true
					resourceParamDict[resourceArea.resourceId] = resourceParamDict[resourceArea.resourceId] or {}
					resourceParamDict[resourceArea.resourceId].linkOut = resourceParamDict[resourceArea.resourceId].linkOut or resourceArea.linkOut
					resourceParamDict[resourceArea.resourceId].isCenter = resourceParamDict[resourceArea.resourceId].isCenter or i == 0
				end
			end

			local bestResourceId = RoomResourceEnum.ResourceId.None
			local bestParam

			for resourceId, param in pairs(resourceParamDict) do
				if not bestParam then
					bestParam = param
					bestResourceId = resourceId
				elseif not bestParam.linkOut and param.linkOut then
					bestParam = param
					bestResourceId = resourceId
				elseif bestParam.linkOut and not param.linkOut then
					-- block empty
				elseif not bestParam.linkOut and not param.linkOut and param.isCenter then
					bestParam = param
					bestResourceId = resourceId
				end
			end

			return bestResourceId
		end
	end
end

function RoomBlockHelper.getResourcePath(blockMO, direction)
	local resourceId = blockMO:getResourceId(direction, true, true)

	if resourceId == RoomResourceEnum.ResourceId.River then
		local linkType, defineBlockType, defineBlockBType = blockMO:getResourceTypeRiver(direction, true)

		if not linkType then
			return nil
		end

		defineBlockType = defineBlockType or blockMO:getDefineBlockType()

		local defineWaterType = blockMO:getDefineWaterType()
		local blockres, blockresAb = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[linkType], defineWaterType)
		local floorres, floorresAb = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorType[linkType], defineBlockType)
		local floor2res, floor2resAb

		if defineBlockBType and RoomRiverEnum.LakeFloorBType[linkType] then
			floor2res, floor2resAb = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorBType[linkType], defineBlockBType)
		end

		return blockres, floorres, floor2res, blockresAb, floorresAb, floor2resAb
	end

	return nil
end

function RoomBlockHelper.getCenterResourcePoint(resourcePointList)
	if not resourcePointList or #resourcePointList <= 0 then
		return nil
	end

	if #resourcePointList <= 2 then
		return resourcePointList[1]
	end

	local centerHexPoint = HexPoint(0, 0)

	for i, resourcePoint in ipairs(resourcePointList) do
		local hexPoint = HexPoint(resourcePoint.x, resourcePoint.y)

		hexPoint = hexPoint + HexPoint.directions[resourcePoint.direction] * 0.4
		centerHexPoint = centerHexPoint + hexPoint
	end

	local centerX = centerHexPoint.x / #resourcePointList
	local centerY = centerHexPoint.y / #resourcePointList

	centerHexPoint = HexPoint(centerX, centerY)

	local minDistance = 0
	local centerResourcePoint

	for i, resourcePoint in ipairs(resourcePointList) do
		local hexPoint = HexMath.resourcePointToHexPoint(resourcePoint, 0.33)
		local distance = HexPoint.DirectDistance(hexPoint, centerHexPoint)

		if not centerResourcePoint or distance < minDistance then
			centerResourcePoint = resourcePoint
			minDistance = distance
		end
	end

	return centerResourcePoint
end

function RoomBlockHelper.findSelectInvenBlockSameResId()
	local tRoomInventoryBlockModel = RoomInventoryBlockModel.instance
	local resId = tRoomInventoryBlockModel:getSelectResId()

	if not resId then
		return nil
	end

	local packageMO = tRoomInventoryBlockModel:getCurPackageMO()

	if not packageMO then
		return nil
	end

	local blockMO = tRoomInventoryBlockModel:findFristUnUseBlockMO(packageMO.packageId, resId)

	return (blockMO or nil) and (blockMO.id or nil)
end

function RoomBlockHelper.isInBoundary(hexPoint)
	local mapMaxRadius = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)

	return mapMaxRadius >= math.max(math.abs(hexPoint.x), math.abs(hexPoint.y), math.abs(hexPoint.z))
end

function RoomBlockHelper.isCanPlaceBlock()
	if RoomController.instance:isEditMode() then
		local isBackBlockShow = RoomMapBlockModel.instance:isBackMore()
		local isBuildingShow = RoomBuildingController.instance:isBuildingListShow()
		local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
		local isTransportPath = RoomTransportController.instance:isTransportPathShow()

		if not isBackBlockShow and not isBuildingShow and not isWaterReform and not isTransportPath then
			return true
		end
	elseif RoomController.instance:isDebugMode() and RoomDebugController.instance:isDebugPlaceListShow() then
		return true
	end

	return false
end

return RoomBlockHelper
