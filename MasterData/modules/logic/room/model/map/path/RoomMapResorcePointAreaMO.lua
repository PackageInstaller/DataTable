-- chunkname: @modules/logic/room/model/map/path/RoomMapResorcePointAreaMO.lua

module("modules.logic.room.model.map.path.RoomMapResorcePointAreaMO", package.seeall)

local RoomMapResorcePointAreaMO = pureTable("RoomMapResorcePointAreaMO")

function RoomMapResorcePointAreaMO:init(id, resourceId)
	self.id = id
	self.resourceId = resourceId
	self._resPointMap = {}
	self._resPointList = {}
	self._directionConnectsDic = self._directionConnectsDic or {}
	self._areaIdMap = {}
	self._areaPointList = {}
	self._isNeedUpdateAreaIdMap = false
end

function RoomMapResorcePointAreaMO:addResPoint(resourcePoint)
	local x = resourcePoint.x
	local y = resourcePoint.y
	local direction = resourcePoint.direction
	local old = self:_getResPointValue(self._resPointMap, x, y, direction)

	if old then
		tabletool.removeValue(self._resPointList, old)
	else
		self._isNeedUpdateAreaIdMap = true
	end

	self:_addResPointValue(self._resPointMap, x, y, direction, resourcePoint)
	table.insert(self._resPointList, resourcePoint)
end

function RoomMapResorcePointAreaMO:removeByXYD(x, y, direction)
	local old = self:_getResPointValue(self._resPointMap, x, y, direction)

	if old then
		tabletool.removeValue(self._resPointList, old)

		self._isNeedUpdateAreaIdMap = true
	end
end

function RoomMapResorcePointAreaMO:removeByXY(x, y)
	if self._resPointMap[x] and self._resPointMap[x][y] then
		self._resPointMap[x][y] = nil

		local resPointList = self._resPointList
		local resPoint
		local count = #resPointList

		for i = count, 1, -1 do
			if resPointList[i].x == x and resPointList[i].y == y then
				resPointList[i] = resPointList[count]

				table.remove(resPointList, count)

				count = count - 1
			end
		end

		self._isNeedUpdateAreaIdMap = true
	end
end

function RoomMapResorcePointAreaMO:getAreaIdByXYD(x, y, direction)
	local areaIdMap = self:getAreaIdMap()

	return (self:_getResPointValue(areaIdMap, x, y, direction))
end

function RoomMapResorcePointAreaMO:getResorcePiontListByXYD(x, y, direction)
	local curAreaId = self:getAreaIdByXYD(x, y, direction)

	if curAreaId then
		return self._areaPointList[curAreaId]
	end

	return nil
end

function RoomMapResorcePointAreaMO:_checkUpdateArea()
	if self._isNeedUpdateAreaMap then
		return
	end

	local areaIdMap = {}
	local areaPointList = {}
	local resPointList = self._resPointList
	local resPointMap = self._resPointMap

	for i = 1, #resPointList do
		local resPoint = resPointList[i]

		self:_addResPointValue(areaIdMap, resPoint.x, resPoint.y, resPoint.direction, -1)
	end

	local areaId = 0

	for i = 1, #resPointList do
		local resPoint = resPointList[i]
		local curAreaId = self:_getResPointValue(areaIdMap, resPoint.x, resPoint.y, resPoint.direction)

		if curAreaId == -1 then
			areaId = areaId + 1

			local addList = {}

			table.insert(areaPointList, addList)
			self:_searchArea(areaId, resPoint, areaIdMap, resPointMap, addList)
		end
	end

	self._isNeedUpdateAreaMap = false
	self._areaIdMap = areaIdMap
	self._areaPointList = areaPointList
end

function RoomMapResorcePointAreaMO:getAreaIdMap()
	self:_checkUpdateArea()

	return self._areaIdMap
end

function RoomMapResorcePointAreaMO:findeArea()
	self:_checkUpdateArea()

	return self._areaPointList
end

function RoomMapResorcePointAreaMO:_searchArea(areaId, resPoint, areaMap, resPointMap, addList)
	local curAreaId = self:_getResPointValue(areaMap, resPoint.x, resPoint.y, resPoint.direction)

	if curAreaId == -1 then
		self:_addResPointValue(areaMap, resPoint.x, resPoint.y, resPoint.direction, areaId)

		if addList then
			table.insert(addList, resPoint)
		end

		local connectResourcePoints = self:getConnectsAll(resPoint.direction)

		for _, connectPoint in ipairs(connectResourcePoints) do
			local tempResPoint = self:_getResPointValue(resPointMap, resPoint.x + connectPoint.x, resPoint.y + connectPoint.y, connectPoint.direction)

			if tempResPoint then
				self:_searchArea(areaId, tempResPoint, areaMap, resPointMap, addList)
			end
		end
	end
end

function RoomMapResorcePointAreaMO:getConnectsAll(direction)
	if not self._directionConnectsDic[direction] then
		local resPoint = ResourcePoint(HexPoint(0, 0), direction)

		self._directionConnectsDic[direction] = resPoint:GetConnectsAll()
	end

	return self._directionConnectsDic[direction]
end

function RoomMapResorcePointAreaMO:_addResPointValue(dict, x, y, direction, value)
	dict[x] = dict[x] or {}
	dict[x][y] = dict[x][y] or {}
	dict[x][y][direction] = value
end

function RoomMapResorcePointAreaMO:_getResPointValue(dict, x, y, direction)
	return dict[x] and dict[x][y] and dict[x][y][direction]
end

return RoomMapResorcePointAreaMO
