-- chunkname: @modules/logic/room/utils/hex/HexMath.lua

module("modules.logic.room.utils.hex.HexMath", package.seeall)

local HexMath = {}
local sqrt3 = math.sqrt(3)
local v2_right = Vector2(1, 0)

function HexMath.hexToPosition(hexPoint, size)
	local positionX, positionY = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, size)

	return Vector2(positionX, positionY)
end

function HexMath.hexXYToPosXY(hexX, hexY, size)
	local q = hexX
	local r = hexY

	size = size or 1

	local positionX = size * (3 * q / 2)
	local positionY = size * (-sqrt3 * q / 2 - sqrt3 * r)

	return positionX, positionY
end

function HexMath.point2HexDistance(pos, center, size)
	local direction = Vector2.Normalize(pos - center)
	local theta = math.acos(Vector2.Dot(direction, v2_right) / Vector2.Magnitude(direction))

	theta = theta % (math.pi / 3)

	if theta > math.pi / 6 then
		theta = math.pi / 3 - theta
	end

	local distance = sqrt3 / 2 / math.cos(theta) * size

	return Vector2.Distance(pos, center) - distance, direction
end

function HexMath.positionToHex(vector2, size)
	local x, y = HexMath.posXYToHexXY(vector2.x, vector2.y, size)

	return HexPoint(x, y)
end

function HexMath.posXYToHexXY(posX, posY, size)
	size = size or 1

	local x = 0.6666666666666666 * posX / size
	local y = (-0.3333333333333333 * posX - sqrt3 / 3 * posY) / size

	return x, y
end

function HexMath.positionToRoundHex(vector2, size)
	local hexX, hexY = HexMath.posXYToHexXY(vector2.x, vector2.y, size)
	local rx, ry, rz, direction = HexMath._roundXYZD(hexX, hexY)

	return HexPoint(rx, ry), direction
end

function HexMath.posXYToRoundHexYX(posX, posY, size)
	local hexX, hexY = HexMath.posXYToHexXY(posX, posY, size)
	local rx, ry, rz, direction = HexMath._roundXYZD(hexX, hexY)

	return rx, ry, direction
end

function HexMath.round(hexPoint)
	local rx, ry, rz, direction = HexMath._roundXYZD(hexPoint.x, hexPoint.y, hexPoint.z)

	return HexPoint(rx, ry), direction
end

function HexMath.roundXY(hexX, hexY)
	local rx, ry, rz, direction = HexMath._roundXYZD(hexX, hexY)

	return rx, ry, direction
end

function HexMath._roundXYZD(hexX, hexY, hexZ)
	if hexZ == nil then
		hexZ = -hexX - hexY
	end

	local rx = Mathf.Round(hexX)
	local ry = Mathf.Round(hexY)
	local rz = Mathf.Round(hexZ)
	local xDiff = math.abs(rx - hexX)
	local yDiff = math.abs(ry - hexY)
	local zDiff = math.abs(rz - hexZ)

	if yDiff < xDiff and zDiff < xDiff then
		rx = -ry - rz
	elseif zDiff < yDiff then
		ry = -rx - rz
	else
		rz = -rx - ry
	end

	local direction = 0
	local q = hexX - rx
	local r = hexY - ry
	local s = hexZ - rz

	if q >= 0 and r >= 0 then
		direction = r <= q and 3 or 4
	elseif r >= 0 and s >= 0 then
		direction = s <= r and 5 or 6
	elseif s >= 0 and q >= 0 then
		direction = q <= s and 1 or 2
	elseif q < 0 and r < 0 then
		direction = q < r and 6 or 1
	elseif r < 0 and s < 0 then
		direction = r < s and 2 or 3
	elseif s < 0 and q < 0 then
		direction = s < q and 4 or 5
	end

	return rx, ry, rz, direction
end

function HexMath.resourcePointToPosition(resourcePoint, size, offset)
	local hexPoint = HexMath.resourcePointToHexPoint(resourcePoint, offset)

	return (HexMath.hexToPosition(hexPoint, size))
end

function HexMath.resourcePointToHexPoint(resourcePoint, offset)
	local directionHexPoint = HexPoint.directions[resourcePoint.direction]

	return (HexPoint(resourcePoint.x + directionHexPoint.x * offset, resourcePoint.y + directionHexPoint.y * offset))
end

function HexMath.zeroRadius(hexX, hexY)
	return (math.abs(hexX) + math.abs(hexY) + math.abs(hexX - hexY)) / 2
end

function HexMath.countByRadius(inRadius)
	return (inRadius > 0 or nil) and 1 + (inRadius + 1) * inRadius * 3
end

function HexMath.hexXYToSpiralIndex(hexX, hexY)
	local radius = HexMath.zeroRadius(hexX, hexY)

	if radius < 1 then
		return 1
	end

	local index = HexMath.countByRadius(radius - 1)
	local hexDistances = HexPoint.directions
	local dirHex = hexDistances[5]
	local dirX = dirHex.x * radius
	local dirY = dirHex.y * radius

	for i = 1, 6 do
		for j = 1, radius do
			index = index + 1

			local hexPoint = hexDistances[i]

			dirX = dirX + hexPoint.x
			dirY = dirY + hexPoint.y

			if hexY == dirY and hexX == dirX then
				return index
			end
		end
	end

	return index
end

return HexMath
