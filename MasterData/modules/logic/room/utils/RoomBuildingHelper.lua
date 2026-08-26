-- chunkname: @modules/logic/room/utils/RoomBuildingHelper.lua

module("modules.logic.room.utils.RoomBuildingHelper", package.seeall)

local RoomBuildingHelper = {}

function RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate, buildingUid)
	hexPoint = hexPoint or HexPoint(0, 0)
	rotate = rotate or 0

	local occupyDict = {}
	local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)
	local centerPoint = buildingConfigParam.centerPoint
	local pointList = buildingConfigParam.pointList
	local replaceBlockDic = buildingConfigParam.replaceBlockDic
	local replaceResPointDic = buildingConfigParam.crossloadResPointDic
	local canPlaceBlockDic = buildingConfigParam.canPlaceBlockDic
	local isCrossload = buildingConfig.crossload ~= 0

	for i, point in ipairs(pointList) do
		local isCenter = point == centerPoint

		if replaceBlockDic[point.x] then
			local blockDefineId = replaceBlockDic[point.x][point.y]

			if canPlaceBlockDic[point.x] then
				if not canPlaceBlockDic[point.x][point.y] then
					local isCanPlace = false
					local worldPoint = RoomBuildingHelper.getWorldHexPoint(point, centerPoint, hexPoint, rotate)

					occupyDict[worldPoint.x] = occupyDict[worldPoint.x] or {}

					local blockRotate = rotate
					local tempData = {
						buildingId = buildingId,
						buildingUid = buildingUid,
						blockDefineId = blockDefineId,
						isCenter = isCenter,
						rotate = rotate,
						blockRotate = blockRotate,
						isCrossload = isCrossload,
						hexPoint = worldPoint,
						index = i,
						isCanPlace = isCanPlace
					}

					occupyDict[worldPoint.x][worldPoint.y] = tempData

					if isCrossload then
						tempData.replacResPoins = replaceResPointDic[point.x] and replaceResPointDic[point.x][point.y]
					end
				end
			end
		end
	end

	return occupyDict
end

function RoomBuildingHelper.getTopRightHexPoint(buildingId, hexPoint, rotate)
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)
	local offsetList = {}

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			local point = HexPoint(x, y)
			local offset = point:convertToOffsetCoordinates()

			table.insert(offsetList, {
				col = offset.x,
				row = offset.y,
				hexPoint = point
			})
		end
	end

	table.sort(offsetList, function(x, y)
		if x.row ~= y.row then
			return x.row < y.row
		end

		return x.col > y.col
	end)

	return offsetList[1] and offsetList[1].hexPoint
end

function RoomBuildingHelper.getWorldHexPoint(resourceHexPoint, centerPoint, hexPoint, rotate)
	local worldHexPoint = resourceHexPoint - centerPoint

	worldHexPoint = worldHexPoint:Rotate(HexPoint(0, 0), rotate, true)
	worldHexPoint = worldHexPoint + hexPoint

	return worldHexPoint
end

function RoomBuildingHelper.getWorldResourcePoint(resourcePoint, centerPoint, hexPoint, rotate)
	local resourceHexPoint = resourcePoint.hexPoint
	local direction = resourcePoint.direction
	local worldHexPoint = RoomBuildingHelper.getWorldHexPoint(resourceHexPoint, centerPoint, hexPoint, rotate)
	local worldDirection = RoomRotateHelper.rotateDirection(direction, rotate)

	return ResourcePoint(worldHexPoint, worldDirection)
end

function RoomBuildingHelper.getAllOccupyDict(mapBuildingMOList)
	mapBuildingMOList = mapBuildingMOList or RoomMapBuildingModel.instance:getBuildingMOList()

	local allOccupyDict = {}

	for i, buildingMO in ipairs(mapBuildingMOList) do
		if buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map then
			local occupyDict = RoomBuildingHelper.getOccupyDict(buildingMO.config.id, buildingMO.hexPoint, buildingMO.rotate, buildingMO.id)

			for x, dict in pairs(occupyDict) do
				for y, param in pairs(dict) do
					allOccupyDict[x] = allOccupyDict[x] or {}
					allOccupyDict[x][y] = param
				end
			end
		end
	end

	return allOccupyDict
end

function RoomBuildingHelper.isAlreadyOccupy(buildingId, hexPoint, rotate, allOccupyDict, revertBuilding)
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	local revertOccupyDict = {}

	if revertBuilding then
		local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

		if tempBuildingMO and tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert then
			local revertHexPoint = RoomMapBuildingModel.instance:getRevertHexPoint()
			local revertRotate = RoomMapBuildingModel.instance:getRevertRotate()

			revertOccupyDict = RoomBuildingHelper.getOccupyDict(tempBuildingMO.buildingId, revertHexPoint, revertRotate, tempBuildingMO.id)
		end
	end

	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			if RoomBuildingHelper.isInInitBlock(HexPoint(x, y)) then
				return true
			end

			if allOccupyDict[x] and allOccupyDict[x][y] then
				return true
			end

			if revertOccupyDict[x] and revertOccupyDict[x][y] then
				return true
			end
		end
	end

	return false
end

function RoomBuildingHelper.hasNoFoundation(buildingId, hexPoint, rotate, mapBlockMODict, water)
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			if mapBlockMODict[x] then
				if not mapBlockMODict[x] or mapBlockMODict[x].blockState ~= RoomBlockEnum.BlockState.Map and (not water or mapBlockMODict[x].blockState ~= RoomBlockEnum.BlockState.Water) then
					return true
				end
			end
		end
	end

	return false
end

function RoomBuildingHelper.checkResource(buildingId, hexPoint, rotate)
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

			if blockMO and not RoomBuildingHelper.checkBuildResId(buildingId, blockMO:getResourceList(true)) then
				return false
			end
		end
	end

	return true
end

function RoomBuildingHelper.hasEnoughResource(buildingId, hexPoint, rotate, levels, error)
	local errorCode = RoomBuildingHelper.getConfirmPlaceBuildingErrorCode(buildingId, hexPoint, rotate, levels)

	if errorCode then
		return nil, errorCode
	end

	return {
		direction = 0
	}
end

function RoomBuildingHelper.getConfirmPlaceBuildingErrorCode(buildingId, hexPoint, rotate, levels)
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)
	local blockMODict = RoomMapBlockModel.instance:getBlockMODict()
	local errorCode

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			if blockMODict[x] then
				if not blockMODict[x] or not RoomBuildingHelper.checkBuildResId(buildingId, blockMODict[x]:getResourceList(true)) then
					return RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
				end
			end
		end
	end

	return nil
end

function RoomBuildingHelper.getCostResourceId(buildingId)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)

	if not buildingConfigParam.costResource or #buildingConfigParam.costResource < 1 then
		return RoomResourceEnum.ResourceId.None
	end

	return buildingConfigParam.costResource[1]
end

function RoomBuildingHelper.getCostResource(buildingId)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)

	return buildingConfigParam.costResource
end

function RoomBuildingHelper.checkBuildResId(buildingId, resIds)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)
	local costResource = buildingConfigParam.costResource

	resIds = resIds or {}

	local tRoomConfig = RoomConfig.instance

	for _, resId in ipairs(resIds) do
		local resCfg = tRoomConfig:getResourceConfig(resId)

		if resCfg and resCfg.occupied == 1 then
			local resParam = tRoomConfig:getResourceParam(resId)

			if not resParam or not resParam.placeBuilding or not tabletool.indexOf(resParam.placeBuilding, buildingId) then
				return false
			end
		end
	end

	if costResource and #costResource > 0 then
		for _, resId in ipairs(resIds) do
			if tabletool.indexOf(costResource, resId) then
				return true
			end
		end

		return false
	end

	return true
end

function RoomBuildingHelper.checkCostResource(costResource, resId)
	if costResource and #costResource > 0 and not tabletool.indexOf(costResource, resId) then
		return false
	end

	return true
end

function RoomBuildingHelper.getCanConfirmPlaceDict(buildingId, mapBlockMODict, allOccupyDict, revertBuilding, levels)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	local canConfirmPlaceDict = {}

	for x, dict in pairs(mapBlockMODict) do
		for y, blockMO in pairs(dict) do
			if not RoomBuildingHelper.isInInitBlock(blockMO.hexPoint) then
				for rotate = 1, 6 do
					local param = RoomBuildingHelper.canConfirmPlace(buildingId, blockMO.hexPoint, rotate, mapBlockMODict, allOccupyDict, revertBuilding, levels)

					if param then
						canConfirmPlaceDict[x] = canConfirmPlaceDict[x] or {}
						canConfirmPlaceDict[x][y] = canConfirmPlaceDict[x][y] or {}
						canConfirmPlaceDict[x][y][rotate] = param
					end
				end
			end
		end
	end

	return canConfirmPlaceDict
end

function RoomBuildingHelper.canTryPlace(buildingId, hexPoint, rotate, mapBlockMODict, allOccupyDict, revertBuilding)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	if RoomBuildingHelper.isAlreadyOccupy(buildingId, hexPoint, rotate, allOccupyDict, revertBuilding) then
		return false
	end

	if RoomBuildingHelper.hasNoFoundation(buildingId, hexPoint, rotate, mapBlockMODict) then
		return false
	end

	return true
end

function RoomBuildingHelper.canConfirmPlace(buildingId, hexPoint, rotate, mapBlockMODict, allOccupyDict, revertBuilding, levels, error)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	local success, errorCode = RoomBuildingAreaHelper.checkBuildingArea(buildingId, hexPoint, rotate)

	if success ~= true then
		return nil, errorCode
	end

	if RoomBuildingHelper.isAlreadyOccupy(buildingId, hexPoint, rotate, allOccupyDict, revertBuilding) then
		return nil
	end

	if RoomBuildingHelper.hasNoFoundation(buildingId, hexPoint, rotate, mapBlockMODict) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation
	end

	if not RoomBuildingHelper.checkResource(buildingId, hexPoint, rotate, mapBlockMODict) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
	end

	if RoomTransportHelper.checkBuildingInLoad(buildingId, hexPoint, rotate) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath
	end

	return RoomBuildingHelper.hasEnoughResource(buildingId, hexPoint, rotate, levels, error)
end

function RoomBuildingHelper.getRecommendHexPoint(buildingId, mapBlockMODict, allOccupyDict, levels, nearRotate)
	nearRotate = nearRotate or 0
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	local canConfirmPlaceDict = RoomBuildingHelper.getCanConfirmPlaceDict(buildingId, mapBlockMODict, allOccupyDict, true, levels)
	local scene = GameSceneMgr.instance:getCurScene()
	local cameraParam = scene.camera:getCameraParam()
	local cameraPos = Vector2(cameraParam.focusX, cameraParam.focusY)
	local bestParam
	local count = 0

	for x, dict1 in pairs(canConfirmPlaceDict) do
		for y, dict2 in pairs(dict1) do
			count = count + 1

			for rotate, param in pairs(dict2) do
				param.hexPoint = HexPoint(x, y)
				param.rotate = rotate
				param.rotateDistance = math.abs(RoomRotateHelper.getMod(rotate, 6) - RoomRotateHelper.getMod(nearRotate, 6))
				param.distance = Vector2.Distance(HexMath.hexToPosition(param.hexPoint, RoomBlockEnum.BlockSize), cameraPos)
				bestParam = not bestParam and param or RoomBuildingHelper._compareParams(bestParam, param)
			end
		end
	end

	return bestParam
end

function RoomBuildingHelper._compareParams(paramA, paramB)
	if paramA.rotateDistance < paramB.rotateDistance then
		return paramA
	elseif paramA.rotateDistance > paramB.rotateDistance then
		return paramB
	end

	if paramA.distance < paramB.distance then
		return paramA
	elseif paramA.distance > paramB.distance then
		return paramB
	end

	return paramA
end

function RoomBuildingHelper.canLevelUp(buildingUid, newLevels, isLevelUp)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingMO.buildingId)
	local originalLevels = tabletool.copy(buildingMO.levels)
	local items = RoomBuildingHelper.getLevelUpCostItems(buildingUid, newLevels)
	local _, enough = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		local specialItems = {}

		for i, item in ipairs(items) do
			if item.type == MaterialEnum.MaterialType.Item and item.id == RoomBuildingEnum.SpecialStrengthItemId then
				table.insert(specialItems, tabletool.copy(item))
			end
		end

		local _, specialEnough = ItemModel.instance:hasEnoughItems(specialItems)

		if not specialEnough then
			return false, -3
		else
			return false, -1
		end
	end

	return true
end

function RoomBuildingHelper.getLevelUpCostItems(buildingUid, newLevels)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingMO.buildingId)
	local levelGroups = buildingConfigParam.levelGroups
	local originalLevels = tabletool.copy(buildingMO.levels)
	local items = {}

	for i, newLevel in ipairs(newLevels) do
		if not originalLevels[i] then
			local originalLevel = 0
			local minLevel = math.min(originalLevel, newLevel)
			local maxLevel = math.max(originalLevel, newLevel)
			local rate = originalLevel < newLevel and 1 or -1

			for level = minLevel + 1, maxLevel do
				local cost = RoomBuildingHelper.getLevelUpCost(levelGroups[i], level)

				cost.quantity = rate * cost.quantity

				table.insert(items, cost)
			end
		end
	end

	return items
end

function RoomBuildingHelper.getLevelUpCost(levelGroup, level)
	local levelGroupConfig = RoomConfig.instance:getLevelGroupConfig(levelGroup, level)
	local cost = levelGroupConfig.cost
	local costParam = string.splitToNumber(cost, "#")

	return {
		type = costParam[1],
		id = costParam[2],
		quantity = costParam[3]
	}
end

function RoomBuildingHelper.getOccupyBuildingParam(hexPoint, temp)
	local allOccupyDict = RoomMapBuildingModel.instance:getAllOccupyDict()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()
	local occupyDict

	if tempBuildingMO and temp then
		occupyDict = RoomBuildingHelper.getOccupyDict(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, tempBuildingMO.rotate, tempBuildingMO.id)
	end

	if allOccupyDict[hexPoint.x] then
		local param = allOccupyDict[hexPoint.x][hexPoint.y]

		if not param and occupyDict then
			param = occupyDict[hexPoint.x] and occupyDict[hexPoint.x][hexPoint.y]
		end

		return param
	end
end

function RoomBuildingHelper.isJudge(hexPoint, blockId)
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return false
	end

	local pressBuildingUid = RoomBuildingController.instance:isPressBuilding()

	if not ((pressBuildingUid and pressBuildingUid == tempBuildingMO.id or nil) and RoomBuildingController.instance:getPressBuildingHexPoint()) then
		return false
	end

	if RoomBuildingHelper.isInInitBlock(hexPoint) then
		return false
	end

	local buildingParam = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

	if buildingParam and buildingParam.buildingUid ~= tempBuildingMO.id then
		return false
	end

	local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

	if not blockMO then
		return false
	end

	if not RoomBuildingHelper.checkBuildResId(tempBuildingMO.buildingId, blockMO:getResourceList(true)) then
		return false
	end

	if RoomTransportHelper.checkInLoadHexXY(hexPoint.x, hexPoint.y) then
		return false
	end

	return true
end

function RoomBuildingHelper.getNearCanPlaceHexPoint(buildingUid, hexPoint, mapBlockMODict, allOccupyDict)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()
	allOccupyDict = allOccupyDict or RoomMapBuildingModel.instance:getAllOccupyDict()

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	for distance = 0, 3 do
		local ranges = {}

		if distance == 0 then
			table.insert(ranges, hexPoint)
		else
			ranges = hexPoint:getOnRanges(distance)
		end

		for j = 0, 5 do
			for _, range in ipairs(ranges) do
				local rotate = RoomRotateHelper.rotateRotate(buildingMO.rotate, j)

				if RoomBuildingHelper.canTryPlace(buildingMO.buildingId, range, rotate) then
					return range, rotate
				end
			end
		end
	end

	return nil
end

function RoomBuildingHelper.isInInitBuildingOccupy(hexPoint)
	local occupyDict = RoomConfig.instance:getInitBuildingOccupyDict()

	return occupyDict[hexPoint.x] and occupyDict[hexPoint.x][hexPoint.y]
end

function RoomBuildingHelper.isInInitBlock(hexPoint)
	local initBlock = RoomConfig.instance:getInitBlockByXY(hexPoint.x, hexPoint.y)

	return not not initBlock
end

function RoomBuildingHelper.canContain(hexPointDict, buildingId)
	for x, dict1 in pairs(hexPointDict) do
		for y, _ in pairs(dict1) do
			for rotate = 1, 6 do
				local contain = true
				local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, HexPoint(x, y), rotate)

				for occupyX, dict2 in pairs(occupyDict) do
					for occupyY, _ in pairs(dict2) do
						if not hexPointDict[occupyX] or not hexPointDict[occupyX][occupyY] then
							contain = false

							break
						end
					end

					if not contain then
						break
					end
				end

				if contain then
					return true
				end
			end
		end
	end

	return false
end

function RoomBuildingHelper.findNearBlockHexPoint(hexPoint, buildingUid)
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local blockMO = tRoomMapBlockModel:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO and blockMO:isInMapBlock() and RoomBuildingHelper._checkBlockByHexPoint(hexPoint, buildingUid) then
		return hexPoint
	end

	blockMO = RoomBuildingHelper._findNearBlockMO(tRoomMapBlockModel:getFullBlockMOList(), hexPoint) or RoomBuildingHelper._findNearBlockMO(tRoomMapBlockModel:getEmptyBlockMOList(), hexPoint)

	return (blockMO or nil) and (blockMO.hexPoint or hexPoint)
end

function RoomBuildingHelper._findNearBlockMO(blockMOList, hexPoint, buildingUid)
	local nearBlockMO
	local nearDistance = 1000

	for i = 1, #blockMOList do
		local blockMO = blockMOList[i]

		if blockMO:isInMap() and RoomBuildingHelper._checkBlockByHexPoint(blockMO.hexPoint, buildingUid) then
			local distance = hexPoint:getDistance(blockMO.hexPoint)

			if not nearBlockMO or distance < nearDistance then
				nearBlockMO = blockMO
				nearDistance = distance
			end
		end
	end

	return nearBlockMO
end

function RoomBuildingHelper._checkBlockByHexPoint(hexPoint, buildingUid)
	local param = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

	if param and param.buildingUid ~= buildingUid or RoomBuildingHelper.isInInitBlock(hexPoint) then
		return false
	end

	return true
end

function RoomBuildingHelper.getCenterPosition(buildingGO)
	local centerGO = gohelper.findChild(buildingGO, "container/buildingGO/center")

	if centerGO then
		if not centerGO.transform.position then
			return buildingGO.transform.position
		end
	end
end

return RoomBuildingHelper
