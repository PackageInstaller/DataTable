-- chunkname: @modules/logic/room/model/map/path/RoomMapPathPlanMO.lua

module("modules.logic.room.model.map.path.RoomMapPathPlanMO", package.seeall)

local RoomMapPathPlanMO = pureTable("RoomMapPathPlanMO")

function RoomMapPathPlanMO:init(id, resourceId, resourcePointList)
	self.id = id
	self.resourceId = resourceId
	self.resId = resourceId
	self._mapNodeDic, self._nodeList = self:_getMapPoint(resourcePointList, resourceId)
end

function RoomMapPathPlanMO:initHexPintList(id, resourceId, hexPointList)
	self.id = id
	self.resourceId = resourceId
	self.resId = resourceId
	self._mapNodeDic, self._nodeList = self:_getMapHexPointList(hexPointList, resourceId)
end

function RoomMapPathPlanMO:_getMapHexPointList(hexPointList, resId)
	local mapdic = {}
	local nodeList = {}

	for i = 1, #hexPointList do
		local hexPoint = hexPointList[i]
		local nodeMO = RoomHelper.get2KeyValue(mapdic, hexPoint.x, hexPoint.y)

		if nodeMO == nil then
			nodeMO = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(mapdic, hexPoint.x, hexPoint.y, nodeMO)
			nodeMO:init(i, hexPoint, resId)
			table.insert(nodeList, nodeMO)
		end

		self:_addLinkHexPoint(nodeMO, hexPointList[i - 1])
		self:_addLinkHexPoint(nodeMO, hexPointList[i + 1])
	end

	self:_updateNeighborParams(nodeList, mapdic)

	return mapdic, nodeList
end

function RoomMapPathPlanMO:_addLinkHexPoint(nodeMO, nextHexPoint)
	if nextHexPoint then
		local nextdir = RoomTransportPathLinkHelper.findLinkDirection(nodeMO.hexPoint, nextHexPoint)

		if nextdir then
			nodeMO:addDirection(nextdir)
		end
	end
end

function RoomMapPathPlanMO:_getMapPoint(resourcePointList, resId)
	if not resourcePointList or #resourcePointList <= 0 then
		return nil
	end

	local mapdic = {}
	local nodeList = {}
	local count = 0

	for i, resourcePoint in ipairs(resourcePointList) do
		local nodeMO = RoomHelper.get2KeyValue(mapdic, resourcePoint.x, resourcePoint.y)

		if nodeMO == nil then
			nodeMO = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(mapdic, resourcePoint.x, resourcePoint.y, nodeMO)

			count = count + 1

			nodeMO:init(count, HexPoint(resourcePoint.x, resourcePoint.y), resId)
			table.insert(nodeList, nodeMO)
		end

		nodeMO:addDirection(resourcePoint.direction)
	end

	self:_updateNeighborParams(nodeList, mapdic)

	return mapdic, nodeList
end

function RoomMapPathPlanMO:_updateNeighborParams(nodeList, mapdic)
	for i = 1, #nodeList do
		local nodeMO = nodeList[i]
		local neighborNum, connectNum = self:_findNeighborCount(nodeMO, mapdic)

		nodeMO.neighborNum = neighborNum
		nodeMO.connectNodeNum = connectNum
		nodeMO.hasBuilding = self:_isHasBuilding(nodeMO)
	end
end

function RoomMapPathPlanMO:_isHasBuilding(nodeMO)
	if RoomMapBuildingModel.instance:getBuildingParam(nodeMO.hexPoint.x, nodeMO.hexPoint.y) then
		return true
	end

	return false
end

function RoomMapPathPlanMO:_findNeighborCount(nodeMO, mapNodeDic)
	local count = 0
	local connect = 0
	local directionList = nodeMO.directionList

	for i = 1, #directionList do
		local direction = directionList[i]
		local neighborMO = self:_getNeighbor(nodeMO, mapNodeDic, direction)

		if neighborMO then
			count = count + 1

			if neighborMO:isHasDirection(nodeMO:getConnectDirection(direction)) then
				nodeMO:setConnctNode(direction, neighborMO)

				connect = connect + 1
			end
		end
	end

	return count, connect
end

function RoomMapPathPlanMO:_getNeighbor(nodeMO, mapNodeDic, direction)
	local neighbor = HexPoint.directions[direction]

	if neighbor then
		local x = nodeMO.hexPoint.x + neighbor.x
		local y = nodeMO.hexPoint.y + neighbor.y

		return mapNodeDic[x] and mapNodeDic[x][y]
	end

	return nil
end

function RoomMapPathPlanMO:getNodeList()
	return self._nodeList
end

function RoomMapPathPlanMO:getCount()
	return #self._nodeList
end

function RoomMapPathPlanMO:getNode(hexPoint)
	return self:getNodeByXY(hexPoint.x, hexPoint.y)
end

function RoomMapPathPlanMO:getNodeByXY(x, y)
	return self._mapNodeDic[x] and self._mapNodeDic[x][y]
end

return RoomMapPathPlanMO
