-- chunkname: @modules/logic/room/utils/RoomTransportHelper.lua

module("modules.logic.room.utils.RoomTransportHelper", package.seeall)

local RoomTransportHelper = {}

RoomTransportHelper._pathBuidingTypeList = nil
RoomTransportHelper._pathBuidingTypesDict = nil
RoomTransportHelper._stieBuidingTypeList = nil

function RoomTransportHelper._initPathParam()
	if not RoomTransportHelper._pathBuidingTypeList then
		local typesList = {
			{
				RoomBuildingEnum.BuildingType.Collect,
				RoomBuildingEnum.BuildingType.Process
			},
			{
				RoomBuildingEnum.BuildingType.Process,
				RoomBuildingEnum.BuildingType.Manufacture
			},
			{
				RoomBuildingEnum.BuildingType.Manufacture,
				RoomBuildingEnum.BuildingType.Collect
			}
		}

		RoomTransportHelper._pathBuidingTypeList = typesList
		RoomTransportHelper._pathBuidingTypesDict = {}
		RoomTransportHelper._stieBuidingTypeList = {}

		for _, types in ipairs(typesList) do
			local temps = {}
			local buildingType = types[1]

			tabletool.addValues(temps, types)

			RoomTransportHelper._pathBuidingTypesDict[buildingType] = temps

			table.insert(RoomTransportHelper._stieBuidingTypeList, buildingType)
		end
	end
end

function RoomTransportHelper.getPathBuildingTypesList()
	RoomTransportHelper._initPathParam()

	return RoomTransportHelper._pathBuidingTypeList
end

function RoomTransportHelper.getSiteBuildingTypeList()
	RoomTransportHelper._initPathParam()

	return RoomTransportHelper._stieBuidingTypeList
end

function RoomTransportHelper.getPathBuildingTypes(buildingType)
	RoomTransportHelper._initPathParam()

	return RoomTransportHelper._pathBuidingTypesDict[buildingType]
end

function RoomTransportHelper.getVehicleCfgByBuildingId(buildingId, buildingSkinId)
	local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if not buildingCfg then
		return
	end

	local skinCfg = RoomConfig.instance:getBuildingSkinConfig(buildingSkinId)

	if skinCfg then
		if not skinCfg.vehicleId then
			local vehicleId = buildingCfg.vehicleId
			local vehicleCfg = RoomConfig.instance:getVehicleConfig(vehicleId)

			if not vehicleCfg and buildingCfg.buildingType == RoomBuildingEnum.BuildingType.Transport then
				logError(string.format("运输建筑【%s %s】找不到交通工具配置[%s]", buildingCfg.name, buildingCfg.id, vehicleId))
			end

			return vehicleCfg
		end
	end
end

function RoomTransportHelper.getSiteFromToByType(buildingType)
	local types = RoomTransportHelper.getPathBuildingTypes(buildingType)

	if types then
		return types[1], types[2]
	end
end

function RoomTransportHelper.getSiltParamBy2PathMO(pathMO, bPathMO)
	local hexPoint, stieType
	local aFirstHexPoint = pathMO:getFirstHexPoint()
	local aLastHexPoint = pathMO:getLastHexPoint()
	local bFirstHexPoint = bPathMO:getFirstHexPoint()
	local bLastHexPoint = bPathMO:getLastHexPoint()

	if aFirstHexPoint == bFirstHexPoint or aFirstHexPoint == bLastHexPoint then
		hexPoint = aFirstHexPoint
	elseif aLastHexPoint == bFirstHexPoint or aLastHexPoint == bLastHexPoint then
		hexPoint = aLastHexPoint
	end

	if pathMO.fromType == bPathMO.fromType or pathMO.fromType == bPathMO.toType then
		stieType = pathMO.fromType
	elseif pathMO.toType == bPathMO.fromType or pathMO.toType == bPathMO.toType then
		stieType = pathMO.toType
	end

	local buildingAreaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBType(stieType)

	if hexPoint ~= nil and buildingAreaMO and buildingAreaMO:isInRangesByHexPoint(hexPoint) then
		return stieType, hexPoint
	end

	return nil, nil
end

function RoomTransportHelper.fromTo2SiteType(fromType, toType)
	local typesList = RoomTransportHelper.getSiteBuildingTypeList()

	for i, siteType in ipairs(typesList) do
		local fType, tType = RoomTransportHelper.getSiteFromToByType(siteType)

		if fType == fromType and tType == toType or tType == fromType and fType == toType then
			return siteType
		end
	end
end

function RoomTransportHelper.canPathByHexPoint(hexPoint, isRemoveBuilding)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.hexX, hexPoint.hexY)

	return RoomTransportHelper.canPathByBlockMO(blockMO, isRemoveBuilding)
end

function RoomTransportHelper.canPathByhexXY(hexX, hexY, isRemoveBuilding)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexX, hexY)

	return RoomTransportHelper.canPathByBlockMO(blockMO, isRemoveBuilding)
end

function RoomTransportHelper.canSiteByHexPoint(hexPoint, buildingType)
	if not hexPoint then
		return false
	end

	local buildingAreaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBType(buildingType)

	if buildingAreaMO and buildingAreaMO:isInRangesByHexPoint(hexPoint) then
		local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance
		local siteTypeList = RoomTransportHelper.getSiteBuildingTypeList()
		local flag = false

		for _, bType in ipairs(siteTypeList) do
			local siteHexPoint = tRoomMapTransportPathModel:getSiteHexPointByType(bType)

			if buildingType == bType then
				flag = true
			elseif siteHexPoint and HexPoint.Distance(siteHexPoint, hexPoint) < 2 then
				return false
			end
		end

		return flag
	end

	return false
end

function RoomTransportHelper.canPathByBlockMO(blockMO, isRemoveBuilding)
	if not blockMO or not blockMO:isInMapBlock() then
		return false
	end

	if blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
		return false
	end

	local hexPoint = blockMO.hexPoint

	if RoomBuildingHelper.isInInitBlock(hexPoint) then
		return false
	end

	local buildingParam = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

	if buildingParam then
		if isRemoveBuilding == nil then
			isRemoveBuilding = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
		end

		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingParam.buildingUid)
		local buildingCfg = buildingMO and buildingMO.config

		if buildingCfg and not RoomBuildingEnum.CanDateleBuildingType[buildingCfg.buildingType] then
			return false
		end

		if isRemoveBuilding ~= true then
			return false
		end
	end

	return true
end

function RoomTransportHelper.initTransportPathModel(model, roadInfos)
	local moList = {}

	if roadInfos then
		for i = 1, #roadInfos do
			local roadInfo = roadInfos[i]
			local pathMO = model:getById(roadInfo.id)

			pathMO = pathMO or RoomTransportPathMO.New()

			pathMO:setId(roadInfo.id)
			pathMO:setServerRoadInfo(roadInfo)
			table.insert(moList, pathMO)
		end
	end

	model:setList(moList)
end

function RoomTransportHelper.serverRoadInfo2Info(roadInfo)
	local info = {}
	local hexPointList = {}
	local var_14_0 = roadInfo.buildingDefineId

	if not roadInfo.buildingDefineId then
		var_14_0 = roadInfo.buildingId

		if not roadInfo.buildingId then
			local buildingId = 0

			if not roadInfo.skinId then
				info.fromType = roadInfo.fromType or 0
				info.toType = roadInfo.toType or 0
				info.critterUid = roadInfo.critterUid or 0
				info.buildingUid = roadInfo.buildingUid or 0
				info.blockCleanType = roadInfo.blockCleanType or 0
				info.buildingId = buildingId
				info.buildingSkinId = roadInfo.buildingSkinId
				info.hexPointList = hexPointList
				info.id = roadInfo.id

				local tRoomMapHexPointModel = RoomMapHexPointModel.instance

				if roadInfo.roadPoints then
					for i, roadPoint in ipairs(roadInfo.roadPoints) do
						table.insert(hexPointList, tRoomMapHexPointModel:getHexPoint(roadPoint.x, roadPoint.y))
					end
				end

				return info
			end
		end
	end
end

function RoomTransportHelper.findInfoInListByType(infoList, aType, bType)
	if not infoList or #infoList < 1 then
		return nil
	end

	for index = 1, #infoList do
		local info = infoList[index]

		if info.fromType == aType and info.toType == bType or info.fromType == bType and info.toType == aType then
			return info, index
		end
	end

	return nil
end

function RoomTransportHelper.getBuildingTypeListByHexPoint(hexPoint, typeList)
	local types = {}
	local isCheckType = typeList and #typeList > 0
	local siteType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(hexPoint)

	if siteType and siteType ~= 0 then
		if not isCheckType or tabletool.indexOf(typeList, siteType) then
			table.insert(types, siteType)
		end

		return types
	end

	local buildingAreaMOList = RoomMapBuildingAreaModel.instance:getList()

	for i = 1, #buildingAreaMOList do
		local buildingAreaMO = buildingAreaMOList[i]
		local buildingType = buildingAreaMO.buildingType

		if (not isCheckType or tabletool.indexOf(typeList, buildingType)) and buildingAreaMO:isInRangesByHexPoint(hexPoint) then
			table.insert(types, buildingType)
		end
	end

	for i = #types, 1, -1 do
		local siteHexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(types[i])

		if siteHexPoint and siteHexPoint ~= hexPoint then
			table.remove(types, i)
		end
	end

	return types
end

function RoomTransportHelper.getBuildingTypeByHexPoint(hexPoint, typeList)
	local areaMO = RoomTransportHelper.getBuildingAreaByHexPoint(hexPoint, typeList)

	return (areaMO or nil) and (areaMO.buildingType or 0)
end

function RoomTransportHelper.getBuildingAreaByHexPoint(hexPoint, typeList)
	local buildingAreaMOList = RoomMapBuildingAreaModel.instance:getList()
	local isCheckType = typeList and #typeList > 0

	for i = 1, #buildingAreaMOList do
		local buildingAreaMO = buildingAreaMOList[i]

		if (not isCheckType or tabletool.indexOf(typeList, buildingAreaMO.buildingType)) and buildingAreaMO:isInRangesByHexPoint(hexPoint) then
			return buildingAreaMO
		end
	end
end

function RoomTransportHelper.getBuildingAreaByHexXY(hexX, hexY)
	local buildingAreaMOList = RoomMapBuildingAreaModel.instance:getList()

	for i = 1, #buildingAreaMOList do
		local buildingAreaMO = buildingAreaMOList[i]

		if buildingAreaMO:isInRangesByHexXY(hexX, hexY) then
			return buildingAreaMO
		end
	end
end

function RoomTransportHelper.checkBuildingInLoad(buildingId, hexPoint, rotate)
	local points = RoomMapModel.instance:getBuildingPointList(buildingId, rotate)

	if points then
		local point

		for i = 1, #points do
			if RoomTransportHelper.checkInLoadHexXY(points[i].x + hexPoint.x, points[i].y + hexPoint.y) then
				return true
			end
		end
	end

	return false
end

function RoomTransportHelper.checkInLoadHexXY(x, y)
	local pathMOList = RoomTransportPathModel.instance:getTransportPathMOList()

	for pidx = 1, #pathMOList do
		if pathMOList[pidx]:checkHexXY(x, y) then
			return true
		end
	end

	return false
end

function RoomTransportHelper.saveQuickLink(siteType, isQuickLink)
	if siteType then
		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. siteType, isQuickLink and 1 or 0)
	end
end

function RoomTransportHelper.getIsQuickLink(siteType)
	if siteType and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. siteType) == 1 then
		return true
	end

	return false
end

return RoomTransportHelper
