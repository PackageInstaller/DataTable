-- chunkname: @modules/logic/room/utils/RoomResourceHelper.lua

module("modules.logic.room.utils.RoomResourceHelper", package.seeall)

local RoomResourceHelper = {}

function RoomResourceHelper.getResourcePointAreaMODict(mapBlockMODict, resIds, noPlaceRes)
	local resAreaMOMap = {}
	local pathResDic
	local isAll = true

	if resIds and #resIds > 0 then
		isAll = false
		pathResDic = {}

		for _, resId in ipairs(resIds) do
			pathResDic[resId] = true
		end
	end

	if not mapBlockMODict then
		::label_1_0::

		local tempMapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

		for x, dict in pairs(tempMapBlockMODict) do
			for y, blockMO in pairs(dict) do
				for direction = 0, 6 do
					local defaultResId = blockMO:getResourceId(direction)
					local resIdList = noPlaceRes and {
						defaultResId
					} or RoomResourceHelper.getPlaceResIds(defaultResId, direction, x, y)

					for _, resourceId in ipairs(resIdList) do
						if isAll or pathResDic[resourceId] then
							local areaMO = resAreaMOMap[resourceId]

							if not areaMO then
								areaMO = RoomMapResorcePointAreaMO.New()

								areaMO:init(resourceId, resourceId)

								resAreaMOMap[resourceId] = areaMO
							end

							local resourcePoint = ResourcePoint(HexPoint(x, y), direction)

							areaMO:addResPoint(resourcePoint)
						end
					end
				end
			end
		end

		return resAreaMOMap
	end
end

function RoomResourceHelper.getAllResourceAreas(mapBlockMODict, temp, connectsAll)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()

	local closePointDict = {}
	local areaList = {}
	local resourceIdList = {}
	local chanceList = {}

	for x, dict in pairs(mapBlockMODict) do
		for y, blockMO in pairs(dict) do
			for i = 0, 6 do
				local resIdList = RoomResourceHelper._getResourceIds(blockMO, i, x, y)

				for _, resourceId in ipairs(resIdList) do
					local resourcePoint = ResourcePoint(HexPoint(x, y), i)

					if not RoomResourceHelper._getFromClosePointDict(closePointDict, resourcePoint, resourceId) then
						local areaPointList, chancePointList = RoomResourceHelper.getResourceArea(mapBlockMODict, {
							resourcePoint
						}, resourceId, closePointDict, temp, connectsAll)

						if #areaPointList > 0 then
							table.insert(areaList, areaPointList)
							table.insert(resourceIdList, resourceId)
							table.insert(chanceList, chancePointList)
						end
					end
				end
			end
		end
	end

	return areaList, resourceIdList, chanceList
end

function RoomResourceHelper.getResourceArea(mapBlockMODict, resourcePointList, resourceId, closePointDict, temp, connectsAll)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()

	local areaPointList = {}
	local chancePointList = {}

	closePointDict = closePointDict or {}

	if resourceId == RoomResourceEnum.ResourceId.None then
		return areaPointList, chancePointList
	end

	local connectPoints = {}

	for _, resourcePoint in ipairs(resourcePointList) do
		if not RoomResourceHelper._getFromClosePointDict(closePointDict, resourcePoint, resourceId) then
			if mapBlockMODict[resourcePoint.x] then
				local currentMO = mapBlockMODict[resourcePoint.x][resourcePoint.y]

				if currentMO and (currentMO.blockState == RoomBlockEnum.BlockState.Map or temp and currentMO.blockState == RoomBlockEnum.BlockState.Temp or currentMO.blockState == RoomBlockEnum.BlockState.Inventory) and currentMO:getResourceId(resourcePoint.direction) == resourceId then
					table.insert(areaPointList, resourcePoint)
					table.insert(connectPoints, resourcePoint)
				end

				RoomResourceHelper._addToClosePointDict(closePointDict, resourcePoint, resourceId)
			end
		end
	end

	while #connectPoints > 0 do
		local newConnectPoints = {}

		for _, connectPoint in ipairs(connectPoints) do
			local tempConnectPoints, chancePoints = RoomResourceHelper._getConnectResourcePoints(mapBlockMODict, connectPoint, resourceId, temp, connectsAll)

			for _, chancePoint in ipairs(chancePoints) do
				table.insert(chancePointList, chancePoint)
			end

			for _, tempConnectPoint in ipairs(tempConnectPoints) do
				if not RoomResourceHelper._getFromClosePointDict(closePointDict, tempConnectPoint, resourceId) then
					table.insert(areaPointList, tempConnectPoint)
					table.insert(newConnectPoints, tempConnectPoint)
				end

				RoomResourceHelper._addToClosePointDict(closePointDict, tempConnectPoint, resourceId)
			end
		end

		connectPoints = newConnectPoints
	end

	return areaPointList, chancePointList
end

function RoomResourceHelper._getConnectResourcePoints(mapBlockMODict, resourcePoint, resourceId, temp, connectsAll)
	mapBlockMODict = mapBlockMODict or RoomMapBlockModel.instance:getBlockMODict()

	local result = {}
	local chance = {}

	if mapBlockMODict[resourcePoint.x] then
		if not mapBlockMODict[resourcePoint.x] or mapBlockMODict[resourcePoint.x].blockState ~= RoomBlockEnum.BlockState.Map and (not temp or mapBlockMODict[resourcePoint.x].blockState ~= RoomBlockEnum.BlockState.Temp) and mapBlockMODict[resourcePoint.x].blockState ~= RoomBlockEnum.BlockState.Inventory then
			return result, chance
		end

		local connectResourcePoints

		for _, connectResourcePoint in ipairs(connectsAll and resourcePoint:GetConnectsAll() or resourcePoint:GetConnects()) do
			if mapBlockMODict[connectResourcePoint.x] then
				if mapBlockMODict[connectResourcePoint.x] and (mapBlockMODict[connectResourcePoint.x].blockState == RoomBlockEnum.BlockState.Map or temp and mapBlockMODict[connectResourcePoint.x].blockState == RoomBlockEnum.BlockState.Temp or mapBlockMODict[connectResourcePoint.x].blockState == RoomBlockEnum.BlockState.Inventory) then
					if RoomResourceHelper._isCanConnect(mapBlockMODict[connectResourcePoint.x], connectResourcePoint.direction, resourceId, connectResourcePoint.x, connectResourcePoint.y) then
						table.insert(result, connectResourcePoint)
					end
				elseif not mapBlockMODict[connectResourcePoint.x] or mapBlockMODict[connectResourcePoint.x].blockState == RoomBlockEnum.BlockState.Water then
					table.insert(chance, connectResourcePoint)
				end
			end
		end

		return result, chance
	end
end

function RoomResourceHelper.getPlaceResIds(defaultResId, direction, x, y)
	local param = RoomMapBuildingModel.instance:getBuildingParam(x, y)

	if param and param.isCrossload and param.replacResPoins then
		local ids = {}
		local dirIndex = RoomRotateHelper.rotateDirection(direction, -param.blockRotate)

		for _, placeResPointDic in pairs(param.replacResPoins) do
			if not placeResPointDic[dirIndex] then
				if not tabletool.indexOf(ids, placeResPointDic[dirIndex]) then
					table.insert(ids, placeResPointDic[dirIndex])
				end
			end
		end

		if #ids < 1 then
			table.insert(ids, defaultResId)
		end

		return ids
	end

	return {
		defaultResId
	}
end

function RoomResourceHelper._getResourceIds(blockMO, direction, x, y)
	local defaultResId = blockMO:getResourceId(direction)

	return RoomResourceHelper.getPlaceResIds(defaultResId, direction, x, y)
end

function RoomResourceHelper._isCanConnect(blockMO, direction, resourceId, x, y)
	local defaultResId = blockMO:getResourceId(direction)
	local ids = RoomResourceHelper.getPlaceResIds(defaultResId, direction, x, y)

	if tabletool.indexOf(ids, resourceId) then
		return true
	end

	return false
end

function RoomResourceHelper._addToClosePointDict(closePointDict, resourcePoint, resourceId)
	closePointDict[resourcePoint.x] = closePointDict[resourcePoint.x] or {}
	closePointDict[resourcePoint.x][resourcePoint.y] = closePointDict[resourcePoint.x][resourcePoint.y] or {}
	closePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction] = closePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction] or {}
	closePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction][resourceId] = true
end

function RoomResourceHelper._getFromClosePointDict(closePointDict, resourcePoint, resourceId)
	return closePointDict[resourcePoint.x] and closePointDict[resourcePoint.x][resourcePoint.y] and closePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction] and closePointDict[resourcePoint.x][resourcePoint.y][resourcePoint.direction][resourceId]
end

return RoomResourceHelper
