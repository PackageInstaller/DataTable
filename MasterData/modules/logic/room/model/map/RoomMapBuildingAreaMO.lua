-- chunkname: @modules/logic/room/model/map/RoomMapBuildingAreaMO.lua

module("modules.logic.room.model.map.RoomMapBuildingAreaMO", package.seeall)

local RoomMapBuildingAreaMO = pureTable("RoomMapBuildingAreaMO")

function RoomMapBuildingAreaMO:init(buildingMO)
	self.id = buildingMO.uid
	self.buildingType = buildingMO.config.buildingType

	self:setMainBuildingMO(buildingMO)
end

function RoomMapBuildingAreaMO:setMainBuildingMO(buildingMO)
	self.mainBuildingMO = buildingMO

	self:clearRangesHexList()
	self:clearBuildingMOList()
end

function RoomMapBuildingAreaMO:getMainBuildingCfg()
	if self.mainBuildingMO then
		return self.mainBuildingMO.config
	end
end

function RoomMapBuildingAreaMO:getRangesHexPointList()
	if self.mainBuildingMO then
		local buildingId = self.mainBuildingMO.buildingId
		local hexPoint = self.mainBuildingMO.hexPoint
		local rotate = self.mainBuildingMO.rotate

		if not RoomBuildingEnum.BuildingAreaRange then
			if self._builingId ~= buildingId or self._rotate ~= rotate or self._hexPoint ~= hexPoint then
				self._builingId = buildingId
				self._hexPoint = hexPoint
				self._rotate = rotate
				self._rangsHexList = self:_findBuildingInRanges(buildingId, hexPoint, rotate, RoomBuildingEnum.BuildingAreaRange)
			end
		end
	else
		self:clearRangesHexList()
	end

	return self._rangsHexList
end

function RoomMapBuildingAreaMO:isInRangesByHexPoint(hexPoint)
	if hexPoint and self:isInRangesByHexXY(hexPoint.x, hexPoint.y) then
		return true
	end

	return false
end

function RoomMapBuildingAreaMO:isInRangesByHexXY(hexX, hexY)
	local hexPointList = self:getRangesHexPointList()
	local hexPoint

	for i = 1, #hexPointList do
		if hexPointList[i].x == hexX and hexPointList[i].y == hexY then
			return true
		end
	end

	return false
end

function RoomMapBuildingAreaMO:clearRangesHexList()
	if self._rangsHexList and #self._rangsHexList > 0 then
		self._rangsHexList = {}
	end

	self._builingId = 0
	self._rotate = 0
	self._hexPoint = nil
end

function RoomMapBuildingAreaMO:getBuildingMOList(withMainBuilding)
	if not self._buildingMOList then
		self._buildingMOList = self:_findMapBuildingMOList()
		self._buildingMOWithMainList = {
			self.mainBuildingMO
		}

		tabletool.addValues(self._buildingMOWithMainList, self._buildingMOList)
	end

	if withMainBuilding then
		return self._buildingMOWithMainList
	end

	return self._buildingMOList
end

function RoomMapBuildingAreaMO:clearBuildingMOList()
	self._buildingMOList = nil
end

function RoomMapBuildingAreaMO:_findMapBuildingMOList()
	local buildingMOList = {}

	if not self.mainBuildingMO then
		return buildingMOList
	end

	local hexPointList = self:getRangesHexPointList()
	local tRoomMapBuildingModel = RoomMapBuildingModel.instance

	for i = 1, #hexPointList do
		local hexPoint = hexPointList[i]

		if hexPoint then
			local buildingMO = tRoomMapBuildingModel:getBuildingMO(hexPoint.x, hexPoint.y)

			if buildingMO and buildingMO:checkSameType(self.buildingType) and not tabletool.indexOf(buildingMOList, buildingMO) then
				table.insert(buildingMOList, buildingMO)
			end
		end
	end

	return buildingMOList
end

function RoomMapBuildingAreaMO:getBuildingType()
	return self.buildingType
end

function RoomMapBuildingAreaMO:_findBuildingInRanges(buildingId, hexPoint, rotate, range)
	hexPoint = hexPoint or HexPoint(0, 0)
	rotate = rotate or 0
	range = range or 1

	local occupyList = {}
	local rangeList = {}
	local pointList = RoomMapModel.instance:getBuildingPointList(buildingId, rotate)

	for i = 1, #pointList do
		local worldPoint = hexPoint + pointList[i]

		table.insert(occupyList, worldPoint)
		tabletool.addValues(rangeList, worldPoint:inRanges(range, true))
	end

	for i = #rangeList, 1, -1 do
		if tabletool.indexOf(occupyList, rangeList[i]) then
			table.remove(rangeList, i)
		end
	end

	return rangeList
end

return RoomMapBuildingAreaMO
