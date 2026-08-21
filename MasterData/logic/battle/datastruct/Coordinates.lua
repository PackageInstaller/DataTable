-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datastruct/Coordinates.lua

module("logic.battle.datastruct.Coordinates", package.seeall)

local Coordinates = class("Coordinates", AbstractGlobalReusable)

function Coordinates:createFromString(str)
	local arr = string.splitToNumber(str, ",")

	return self:createInstance(arr[1], arr[2])
end

function Coordinates:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function Coordinates:ctor(x, z)
	self._values = {
		0,
		0
	}

	self:setXZ(x, z)
end

function Coordinates:reuse(x, z)
	self:setXZ(x, z)
end

function Coordinates:reset()
	self:setXZ(0, 0)
end

function Coordinates:destroy()
	self._values = nil
end

function Coordinates:setX(x)
	if x then
		self._values[1] = x
	end
end

function Coordinates:setZ(z)
	if z then
		self._values[2] = z
	end
end

function Coordinates:setXZ(x, z)
	if x and z then
		self._values[1] = x
		self._values[2] = z
	end
end

function Coordinates:getXZ()
	return self._values[1], self._values[2]
end

function Coordinates:getX()
	return self._values[1]
end

function Coordinates:getZ()
	return self._values[2]
end

function Coordinates:isEqual(x, z)
	local values = self._values

	return values[1] == x and values[2] == z
end

function Coordinates:toString()
	return string.format("[%s,%s]", self:getXZ())
end

return Coordinates
