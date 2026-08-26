-- chunkname: @modules/logic/room/utils/hex/HexPoint.lua

module("modules.logic.room.utils.hex.HexPoint", package.seeall)

local HexPoint = {}

function HexPoint.New(x, y, z)
	local nilCount = 0

	if x == nil then
		nilCount = nilCount + 1
	end

	if y == nil then
		nilCount = nilCount + 1
	end

	if z == nil then
		nilCount = nilCount + 1
	end

	if nilCount > 1 then
		logError("HexPoint: xyz需要至少两个值")

		z = 0
		y = 0
		x = 0
	elseif x == nil then
		x = -y - z
	elseif y == nil then
		y = -z - x
	elseif z == nil then
		z = -x - y
	end

	local t = {
		x = x,
		y = y
	}

	setmetatable(t, HexPoint)

	return t
end

HexPoint.new = HexPoint.New

local _new = HexPoint.New
local _get = {}

function _get.z(t)
	if t.x == 0 and t.y == 0 then
		return 0
	end

	return -t.x - t.y
end

function _get.q(t)
	return t.x
end

function _get.r(t)
	return t.y
end

function _get.s(t)
	return _get.z(t)
end

function HexPoint.__index(t, k)
	local var

	if var == nil then
		var = rawget(HexPoint, k)
	end

	if var == nil then
		var = rawget(t, k)
	end

	if var == nil then
		var = rawget(_get, k)

		if var ~= nil then
			return var(t)
		end
	end

	return var
end

HexPoint.directions = {
	[0] = HexPoint.New(0, 0),
	HexPoint.New(0, -1),
	HexPoint.New(1, -1),
	HexPoint.New(1, 0),
	HexPoint.New(0, 1),
	HexPoint.New(-1, 1),
	(HexPoint.New(-1, 0))
}

function HexPoint.Add(pA, pB)
	return _new(pA.x + pB.x, pA.y + pB.y)
end

HexPoint.add = HexPoint.Add

local _add = HexPoint.Add

function HexPoint.Sub(pA, pB)
	return _new(pA.x - pB.x, pA.y - pB.y)
end

HexPoint.sub = HexPoint.Sub

local _sub = HexPoint.Sub

function HexPoint.Mul(p, m)
	return HexMath.round(_new(p.x * m, p.y * m))
end

HexPoint.mul = HexPoint.Mul

local _mul = HexPoint.Mul

function HexPoint.Div(p, d)
	return HexMath.round(_new(p.x / d, p.y / d))
end

HexPoint.div = HexPoint.Div

local _div = HexPoint.Div

function HexPoint.Distance(pA, pB)
	return (math.abs(pA.x - pB.x) + math.abs(pA.y - pB.y) + math.abs(pA.z - pB.z)) / 2
end

HexPoint.distance = HexPoint.Distance
HexPoint.getDistance = HexPoint.Distance
HexPoint.GetDistance = HexPoint.Distance

function HexPoint.DirectDistance(pA, pB)
	local posA = HexMath.hexToPosition(pA)
	local posB = HexMath.hexToPosition(pB)

	return Vector2.Distance(posA, posB)
end

HexPoint.directDistance = HexPoint.DirectDistance
HexPoint.getDirectDistance = HexPoint.DirectDistance
HexPoint.GetDirectDistance = HexPoint.DirectDistance

function HexPoint.InRanges(p, range, withoutSelf)
	local ranges = {}

	range = math.abs(range or 0)

	for x = -range, range do
		for y = math.max(-range, -x - range), math.min(range, -x + range) do
			if not withoutSelf or x ~= 0 or y ~= 0 then
				table.insert(ranges, _add(p, _new(x, y)))
			end
		end
	end

	return ranges
end

HexPoint.inRanges = HexPoint.InRanges
HexPoint.getInRanges = HexPoint.InRanges
HexPoint.GetInRanges = HexPoint.InRanges

function HexPoint.OnRanges(p, range)
	local ranges = {}

	range = math.abs(range or 0)

	local current = HexPoint.directions[5] * range + p

	for i = 1, 6 do
		for j = 1, range do
			table.insert(ranges, current)

			current = current + HexPoint.directions[i]
		end
	end

	return ranges
end

HexPoint.onRanges = HexPoint.OnRanges
HexPoint.getOnRanges = HexPoint.OnRanges
HexPoint.GetOnRanges = HexPoint.OnRanges

function HexPoint.Neighbors(p)
	local neighbors = {}

	for i = 1, 6 do
		local neighbor = p + HexPoint.directions[i]

		table.insert(neighbors, neighbor)
	end

	return neighbors
end

HexPoint.neighbors = HexPoint.Neighbors
HexPoint.getNeighbors = HexPoint.Neighbors
HexPoint.GetNeighbors = HexPoint.Neighbors

function HexPoint.Neighbor(p, index)
	if index < 1 or index > 6 then
		logError("HexPoint: Neighbor index需要在1~6之间")

		return nil
	end

	return p + HexPoint.directions[index]
end

HexPoint.neighbor = HexPoint.Neighbor
HexPoint.getNeighbor = HexPoint.Neighbor
HexPoint.GetNeighbor = HexPoint.Neighbor

function HexPoint.IntersectingRanges(pA, pB, rangeA, rangeB, withoutSelf)
	local ranges = {}

	rangeA = math.abs(rangeA or 0)
	rangeB = rangeB and math.abs(rangeB) or rangeA

	logError("HexPoint: 未实现IntersectingRanges")

	return ranges
end

HexPoint.intersectingRanges = HexPoint.IntersectingRanges
HexPoint.getIntersectingRanges = HexPoint.IntersectingRanges
HexPoint.GetIntersectingRanges = HexPoint.IntersectingRanges

function HexPoint.Rotate(p, center, step, isClockwise)
	center = center or _new(0, 0)
	step = RoomRotateHelper.getMod(step, 6)

	local x = p.x - center.x
	local y = p.y - center.y

	for i = 1, step do
		if isClockwise then
			y = x + y
			x = -y
		else
			y = -x
			x = x + y
		end
	end

	return _new(x + center.x, y + center.y)
end

HexPoint.rotate = HexPoint.Rotate
HexPoint.getRotate = HexPoint.Rotate
HexPoint.GetRotate = HexPoint.Rotate

function HexPoint.ConvertToOffsetCoordinates(p)
	local q, r = p.x, p.y
	local col = q + (r - RoomRotateHelper.getMod(r, 2)) / 2
	local row = r

	return Vector2(col, row)
end

HexPoint.convertToOffsetCoordinates = HexPoint.ConvertToOffsetCoordinates
HexPoint.getConvertToOffsetCoordinates = HexPoint.ConvertToOffsetCoordinates
HexPoint.GetConvertToOffsetCoordinates = HexPoint.ConvertToOffsetCoordinates

function HexPoint.OnLine(pA, pB)
	local distance = HexPoint.Distance(pA, pB)
	local onLines = {}
	local dict = {}

	for i = 0, distance do
		local onLine = HexMath.round(HexPoint.lerp(pA, pB, i / distance))

		if not dict[tostring(onLine)] then
			table.insert(onLines, onLine)

			dict[tostring(onLine)] = true
		end
	end

	return onLines
end

function HexPoint.lerp(pA, pB, t)
	return _new(pA.x + (pB.x - pA.x) * t, pA.y + (pB.y - pA.y) * t)
end

function HexPoint.__add(pA, pB)
	return _add(pA, pB)
end

function HexPoint.__sub(pA, pB)
	return _sub(pA, pB)
end

function HexPoint.__mul(p, m)
	return _mul(p, m)
end

function HexPoint.__div(p, d)
	return _div(p, d)
end

function HexPoint.__unm(p)
	return _new(-p.x, -p.y)
end

function HexPoint.__eq(pA, pB)
	return pA.x == pB.x and pA.y == pB.y
end

function HexPoint:__tostring()
	return string.format("(%s, %s, %s)", self.x, self.y, self.z)
end

function HexPoint:__call(x, y, z)
	return _new(x, y, z)
end

setmetatable(HexPoint, HexPoint)

HexPoint.Zero = HexPoint.New(0, 0)
HexPoint.Up = HexPoint.New(0, -1)
HexPoint.TopRight = HexPoint.New(1, -1)
HexPoint.BottomRight = HexPoint.New(1, 0)
HexPoint.Down = HexPoint.New(0, 1)
HexPoint.BottomLeft = HexPoint.New(-1, 1)
HexPoint.TopLeft = HexPoint.New(-1, 0)
HexPoint.zero = HexPoint.Zero
HexPoint.up = HexPoint.Up
HexPoint.topRight = HexPoint.TopRight
HexPoint.bottomRight = HexPoint.BottomRight
HexPoint.down = HexPoint.Down
HexPoint.bottomLeft = HexPoint.BottomLeft
HexPoint.topLeft = HexPoint.TopLeft

return HexPoint
