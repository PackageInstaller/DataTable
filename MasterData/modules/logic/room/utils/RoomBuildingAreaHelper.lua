-- chunkname: @modules/logic/room/utils/RoomBuildingAreaHelper.lua

module("modules.logic.room.utils.RoomBuildingAreaHelper", package.seeall)

local RoomBuildingAreaHelper = {}

function RoomBuildingAreaHelper.checkBuildingArea(buildingId, hexPoint, rotate)
	local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if buildingCfg and RoomBuildingEnum.BuildingArea[buildingCfg.buildingType] and buildingCfg.isAreaMainBuilding == false then
		local areaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBType(buildingCfg.buildingType)

		if not areaMO then
			return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding
		end

		local points = RoomMapModel.instance:getBuildingPointList(buildingId, rotate)

		if points then
			local point

			for i = 1, #points do
				if areaMO:isInRangesByHexXY(points[i].x + hexPoint.x, points[i].y + hexPoint.y) then
					return true
				end
			end
		end

		return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding
	end

	return true
end

function RoomBuildingAreaHelper.isBuildingArea(buildingId)
	local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if buildingCfg and RoomBuildingEnum.BuildingArea[buildingCfg.buildingType] then
		return true
	end

	return false
end

function RoomBuildingAreaHelper.isAreaMainBuilding(buildingId)
	local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if buildingCfg and RoomBuildingEnum.BuildingArea[buildingCfg.buildingType] and buildingCfg.isAreaMainBuilding == true then
		return true
	end

	return false
end

function RoomBuildingAreaHelper.formatBuildingMOListNameStr(buildingMOList)
	if not buildingMOList or #buildingMOList < 1 then
		return ""
	end

	local buildingIdDict = {}

	for _, buildingMO in ipairs(buildingMOList) do
		local buildingId = buildingMO.buildingId

		buildingIdDict[buildingId] = not buildingIdDict[buildingId] and 1 or buildingIdDict[buildingId] + 1
	end

	local buildingNames = {}

	for buildingId, num in pairs(buildingIdDict) do
		local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

		if buildingCfg then
			if num == 1 then
				table.insert(buildingNames, buildingCfg.name)
			elseif num > 1 then
				table.insert(buildingNames, string.format("%s * %s", buildingCfg.name, num))
			end
		end
	end

	local connchar = luaLang("room_levelup_init_and1")

	return table.concat(buildingNames, connchar)
end

function RoomBuildingAreaHelper.findTempOutBuildingMOList(isUnUse)
	local tempAreaMO = RoomMapBuildingAreaModel.instance:getTempAreaMO()
	local moList

	if not tempAreaMO then
		return moList
	end

	local buildingType = tempAreaMO.buildingType
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i = 1, #buildingMOList do
		local buildingMO = buildingMOList[i]

		if buildingMO and buildingMO:checkSameType(buildingType) and not buildingMO:isAreaMainBuilding() and (isUnUse == true or not tempAreaMO:isInRangesByHexPoint(buildingMO.hexPoint)) then
			moList = moList or {}

			table.insert(moList, buildingMO)
		end
	end

	return moList
end

function RoomBuildingAreaHelper.isHasWorkingByType(buildingType)
	local buildingAreaMO = RoomMapBuildingAreaModel.instance:getAreaMOByBType(buildingType)

	if not buildingAreaMO then
		return false
	end

	local buildingMOList = buildingAreaMO:getBuildingMOList(true)

	for i = 1, #buildingMOList do
		local buildingMO = buildingMOList[i]

		if buildingMO:getManufactureState() ~= RoomManufactureEnum.SlotState.Stop then
			return true
		end
	end

	return false
end

function RoomBuildingAreaHelper.findTempOutTransportMOList(isUnUse)
	local tempAreaMO = RoomMapBuildingAreaModel.instance:getTempAreaMO()
	local moList

	if not tempAreaMO then
		return moList
	end

	local buildingType = tempAreaMO.buildingType
	local pathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for i = 1, #pathMOList do
		local pathMO = pathMOList[i]

		if pathMO and (pathMO.fromType == buildingType and (isUnUse == true or not tempAreaMO:isInRangesByHexPoint(pathMO:getFirstHexPoint())) or pathMO.toType == buildingType and (isUnUse == true or not tempAreaMO:isInRangesByHexPoint(pathMO:getLastHexPoint()))) then
			moList = moList or {}

			table.insert(moList, pathMO)
		end
	end

	return moList
end

function RoomBuildingAreaHelper.logTestAreaMO(areaMO)
	if not areaMO then
		return
	end

	local buildingConfig = areaMO:getMainBuildingCfg()

	if not buildingConfig then
		return
	end

	local rangsHexList = areaMO:getRangesHexPointList() or {}
	local listStr = string.format("name:%s id:%s -->", buildingConfig.name, buildingConfig.id)
	local hexPoint = areaMO.mainBuildingMO.hexPoint

	listStr = string.format("%s (%s,%s)  | ", listStr, hexPoint.x, hexPoint.y)

	for _, hexPoint in ipairs(rangsHexList) do
		if hexPoint then
			listStr = string.format("%s (%s,%s)", listStr, hexPoint.x, hexPoint.y)
		end
	end

	logNormal(listStr)
end

return RoomBuildingAreaHelper
