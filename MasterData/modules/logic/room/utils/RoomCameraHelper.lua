-- chunkname: @modules/logic/room/utils/RoomCameraHelper.lua

module("modules.logic.room.utils.RoomCameraHelper", package.seeall)

local RoomCameraHelper = {}

function RoomCameraHelper.getConvexHull(points)
	return RoomCameraHelper.getSubConvexHull(points)
end

function RoomCameraHelper.getSubConvexHull(points)
	if not points then
		return {}
	end

	points = RoomCameraHelper.derepeat(points)

	local n = #points

	if n <= 2 then
		return points
	end

	local result = {}
	local polarIndex = 0

	for i, point in ipairs(points) do
		if i == 1 or point.y < points[polarIndex].y or point.y == points[polarIndex].y and point.x < points[polarIndex].x then
			polarIndex = i
		end
	end

	points[1], points[polarIndex] = points[polarIndex], points[1]

	local polar = points[1]

	table.sort(points, function(pA, pB)
		if pA == polar and pB ~= polar then
			return true
		elseif pA ~= polar and pB == polar then
			return false
		end

		local cross = RoomCameraHelper.getCross(pA, pB, polar)

		if cross ~= 0 then
			return cross > 0
		end

		if pA.y ~= pB.y then
			return pA.y > pB.y
		end

		return math.abs(pA.x - polar.x) > math.abs(pB.x - polar.x)
	end)

	points = RoomCameraHelper.collineation(points)
	n = #points

	local top = 1
	local index = 1

	while index <= n + 1 do
		local fixedIndex = (index - 1) % n + 1
		local point = points[fixedIndex]

		while top > 2 do
			local cross = RoomCameraHelper.getCross(result[top - 1], point, result[top - 2])

			if cross > 0 then
				break
			end

			top = top - 1
		end

		result[top] = index <= n and point or Vector2(point.x, point.y)
		top = top + 1
		index = index + 1
	end

	for i = #result, 1, -1 do
		if top <= i then
			table.remove(result, i)
		end
	end

	return result
end

function RoomCameraHelper.getCross(pA, pB, point)
	return (pA.x - point.x) * (pB.y - point.y) - (pA.y - point.y) * (pB.x - point.x)
end

function RoomCameraHelper.collineation(points)
	local newPoints = {}
	local polar = points[1]
	local deleteDict = {}
	local index = 2

	for i = 3, #points do
		local pA = points[index]
		local pB = points[i]

		if math.abs(RoomCameraHelper.getCross(pA, pB, polar)) < 1e-05 then
			if pA.y > pB.y or pA.y == pB.y and math.abs(pA.x - polar.x) > math.abs(pB.x - polar.x) then
				deleteDict[i] = true
			else
				deleteDict[index] = true
				index = i
			end
		else
			index = i
		end
	end

	for i, point in ipairs(points) do
		if not deleteDict[i] then
			table.insert(newPoints, point)
		end
	end

	return newPoints
end

function RoomCameraHelper.derepeat(points)
	local newPoints = {}
	local repeatDict = {}

	for _, point in ipairs(points) do
		if repeatDict[point.x] then
			if not repeatDict[point.x] then
				table.insert(newPoints, point)

				repeatDict[point.x] = repeatDict[point.x] or {}
				repeatDict[point.x][point.y] = true
			end
		end
	end

	return newPoints
end

function RoomCameraHelper.isPointInConvexHull(point, convexHull)
	if not point or not convexHull or #convexHull <= 2 then
		return true
	end

	local isInConvexHull = true
	local maxDistance = 0
	local maxPA, maxPB
	local count = 0

	for i = 1, #convexHull do
		local pA = convexHull[i]
		local pB = convexHull[i + 1]

		if pA and pB and RoomCameraHelper.getCross(pB, point, pA) < 0 then
			isInConvexHull = false

			local distance = RoomCameraHelper.getDistance(point, pA, pB)

			if maxDistance < distance or maxDistance == 0 then
				maxDistance = distance
				maxPA = pA
				maxPB = pB
			end

			count = count + 1
		end
	end

	return isInConvexHull, maxDistance, maxPA, maxPB, count
end

function RoomCameraHelper.getDistance(point, pA, pB)
	if pA == pB then
		return Vector2.Distance(pA, point)
	end

	if pA.y == pB.y then
		local b = pA.y

		return math.abs(point.y - b)
	end

	if pA.x == pB.x then
		local b = pA.x

		return math.abs(point.x - b)
	end

	local k = (pA.y - pB.y) / (pA.x - pB.x)
	local b = (pA.x * pB.y - pB.x * pA.y) / (pA.x - pB.x)

	return math.abs((k * point.x - point.y + b) / math.sqrt(k * k + 1))
end

function RoomCameraHelper.getDirection(point, pA, pB)
	local direction = Vector2.Normalize(pB - pA)

	return Vector2(-direction.y, direction.x)
end

function RoomCameraHelper.getOffsetPosition(currentPos, expectPos, convexHull)
	if RoomController.instance:isDebugMode() then
		return expectPos
	end

	if not convexHull or #convexHull <= 2 then
		return expectPos
	end

	local isInConvexHull, maxDistance, maxPA, maxPB, count = RoomCameraHelper.isPointInConvexHull(expectPos, convexHull)

	if isInConvexHull then
		return expectPos
	elseif count >= 2 then
		local direction = RoomCameraHelper.getDirection(expectPos, maxPA, maxPB)
		local offsetPos = expectPos + direction * (maxDistance + 0.0001)
		local isOffsetInConvexHull = RoomCameraHelper.isPointInConvexHull(offsetPos, convexHull)

		if isOffsetInConvexHull then
			return offsetPos
		else
			return currentPos
		end
	else
		local direction = RoomCameraHelper.getDirection(expectPos, maxPA, maxPB)

		return expectPos + direction * maxDistance
	end
end

function RoomCameraHelper.expandConvexHull(convexHull, expandDistance)
	local expandConvexHull = {}
	local count = #convexHull

	if count <= 0 then
		return convexHull
	end

	for i, point in ipairs(convexHull) do
		if i < count then
			if not convexHull[i - 1] then
				local pointA = convexHull[count - 1]
				local pointB = convexHull[i + 1]

				if pointA and pointB then
					local expandPoint = RoomCameraHelper.expandPoint(point, pointA, pointB, expandDistance)

					table.insert(expandConvexHull, expandPoint)
				end
			end
		end
	end

	local point = expandConvexHull[1]

	table.insert(expandConvexHull, Vector2(point.x, point.y))

	expandConvexHull = RoomCameraHelper.getConvexHull(expandConvexHull)

	return expandConvexHull
end

function RoomCameraHelper.expandPoint(point, pointA, pointB, expandDistance)
	local pa = Vector2.Normalize(pointA - point)
	local pb = Vector2.Normalize(pointB - point)

	if Mathf.Abs(Vector2.Dot(pa, pb)) <= 0.0001 then
		local op = point
		local up = Vector2(pa.y, pa.x)
		local down = -up

		if Vector2.Dot(op, up) > 0 then
			return point + up * expandDistance
		elseif Vector2.Dot(op, down) > 0 then
			return point + down * expandDistance
		end

		return point
	end

	local half = -Vector2.Normalize(pa + pb)
	local cos = Vector2.Dot(pa, pb)

	if cos < -1 then
		cos = -1
	elseif cos > 1 then
		cos = 1
	end

	local theta = Mathf.Acos(cos)
	local halfSin = Mathf.Sin(theta / 2)

	if halfSin == 0 then
		return point
	end

	local length = expandDistance / halfSin

	return point + half * length
end

function RoomCameraHelper.getConvexHexPointDict(convexHull)
	local hexPointDict = {}

	if not convexHull or #convexHull <= 2 then
		return hexPointDict
	end

	local closeHexPointDict = {}
	local openHexPointList = {
		HexPoint(0, 0)
	}

	closeHexPointDict[0] = closeHexPointDict[0] or {}
	closeHexPointDict[0][0] = true

	while #openHexPointList > 0 do
		local newOpenHexPointList = {}

		for i, openHexPoint in ipairs(openHexPointList) do
			local point = HexMath.hexToPosition(openHexPoint, RoomBlockEnum.BlockSize)

			if RoomCameraHelper.isPointInConvexHull(point, convexHull) then
				hexPointDict[openHexPoint.x] = hexPointDict[openHexPoint.x] or {}
				hexPointDict[openHexPoint.x][openHexPoint.y] = true

				local neighborHexPointList = openHexPoint:getNeighbors()

				for j, neighborHexPoint in ipairs(neighborHexPointList) do
					if not closeHexPointDict[neighborHexPoint.x] or not closeHexPointDict[neighborHexPoint.x][neighborHexPoint.y] then
						table.insert(newOpenHexPointList, neighborHexPoint)

						closeHexPointDict[neighborHexPoint.x] = closeHexPointDict[neighborHexPoint.x] or {}
						closeHexPointDict[neighborHexPoint.x][neighborHexPoint.y] = true
					end
				end
			end
		end

		openHexPointList = newOpenHexPointList
	end

	return hexPointDict
end

return RoomCameraHelper
