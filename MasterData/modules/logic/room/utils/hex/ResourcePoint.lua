-- chunkname: @modules/logic/room/utils/hex/ResourcePoint.lua

module("modules.logic.room.utils.hex.ResourcePoint", package.seeall)

local ResourcePoint = {}

function ResourcePoint.New(param1, param2)
	local t

	if param1 and param2 then
		local hexPoint = param1
		local direction = param2

		t = {
			hexPoint = hexPoint,
			direction = direction
		}
	elseif param1 then
		local resourcePoint = param1

		t = {
			hexPoint = HexPoint(resourcePoint.x, resourcePoint.y),
			direction = resourcePoint.direction
		}
	end

	setmetatable(t, ResourcePoint)

	return t
end

ResourcePoint.new = ResourcePoint.New

local _new = ResourcePoint.New
local _get = {}

function _get.x(t)
	return t.hexPoint.x
end

function _get.y(t)
	return t.hexPoint.y
end

function _get.z(t)
	return t.hexPoint.z
end

function ResourcePoint.__index(t, k)
	local var

	if var == nil then
		var = rawget(ResourcePoint, k)
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

function ResourcePoint.Add(p, rotate)
	local direction = RoomRotateHelper.rotateDirection(p.direction, rotate)

	return _new(p.hexPoint, direction)
end

ResourcePoint.add = ResourcePoint.Add

local _add = ResourcePoint.Add

function ResourcePoint.Sub(p, rotate)
	local direction = RoomRotateHelper.rotateDirection(p.direction, -rotate)

	return _new(p.hexPoint, direction)
end

ResourcePoint.sub = ResourcePoint.Sub

local _sub = ResourcePoint.Sub

function ResourcePoint.Connects(p)
	local connects = {}

	if p.direction == 0 then
		for direction = 1, 6 do
			table.insert(connects, ResourcePoint(p.hexPoint, direction))
		end
	else
		table.insert(connects, ResourcePoint(p.hexPoint, 0))
		table.insert(connects, p + 1)
		table.insert(connects, p - 1)

		local neighborHexPoint = p.hexPoint:GetNeighbor(p.direction)

		table.insert(connects, ResourcePoint(neighborHexPoint, RoomRotateHelper.oppositeDirection(p.direction)))
	end

	return connects
end

ResourcePoint.connects = ResourcePoint.Connects
ResourcePoint.getConnects = ResourcePoint.Connects
ResourcePoint.GetConnects = ResourcePoint.Connects

function ResourcePoint.ConnectsAll(p)
	local connects = {}

	for direction = 0, 6 do
		if p.direction ~= direction then
			table.insert(connects, ResourcePoint(p.hexPoint, direction))
		end
	end

	if p.direction ~= 0 then
		local neighborHexPoint = p.hexPoint:GetNeighbor(p.direction)

		table.insert(connects, ResourcePoint(neighborHexPoint, RoomRotateHelper.oppositeDirection(p.direction)))
	end

	return connects
end

ResourcePoint.connectsAll = ResourcePoint.ConnectsAll
ResourcePoint.getConnectsAll = ResourcePoint.ConnectsAll
ResourcePoint.GetConnectsAll = ResourcePoint.ConnectsAll

function ResourcePoint.__add(p, rotate)
	return _add(p, rotate)
end

function ResourcePoint.__sub(p, rotate)
	return _sub(p, rotate)
end

function ResourcePoint.__unm(p)
	local direction = RoomRotateHelper.oppositeDirection(p.direction)

	return _new(p.hexPoint, direction)
end

function ResourcePoint.__eq(pA, pB)
	return pA.hexPoint == pB.hexPoint and pA.direction == pB.direction
end

function ResourcePoint:__tostring()
	return string.format("(x: %s, y: %s, direction: %s)", self.x, self.y, self.direction)
end

function ResourcePoint:__call(hexPoint, direction)
	return _new(hexPoint, direction)
end

setmetatable(ResourcePoint, ResourcePoint)

return ResourcePoint
