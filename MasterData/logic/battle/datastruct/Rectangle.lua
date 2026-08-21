-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datastruct/Rectangle.lua

module("logic.battle.datastruct.Rectangle", package.seeall)

local Rectangle = class("Rectangle", AbstractGlobalReusable)

function Rectangle:createInfiniteMin()
	local min = BattleMathUtil.INT_MIN
	local max = BattleMathUtil.INT_MAX

	return Rectangle:createInstance(max, min, max, min)
end

function Rectangle:ctor(xmin, xmax, zmin, zmax)
	self._values = {
		0,
		0,
		0,
		0
	}

	self:setRanges(xmin, xmax, zmin, zmax)
end

function Rectangle:reuse(xmin, xmax, zmin, zmax)
	self:setRanges(xmin, xmax, zmin, zmax)
end

function Rectangle:reset()
	self:setRanges(0, 0, 0, 0)
end

function Rectangle:destroy()
	self._values = nil
end

function Rectangle:setRanges(xmin, xmax, zmin, zmax)
	if xmin and xmax and zmin and zmax then
		local values = self._values

		values[1] = xmin
		values[2] = xmax
		values[3] = zmin
		values[4] = zmax
	end
end

function Rectangle:getCenterXZ()
	local centerX = (self:getMinx() + self:getMaxx()) / 2
	local centerZ = (self:getMinz() + self:getMaxx()) / 2

	return centerX, centerZ
end

function Rectangle:setMinx(x)
	self._values[1] = x
end

function Rectangle:setMaxx(x)
	self._values[2] = x
end

function Rectangle:setMinz(z)
	self._values[3] = z
end

function Rectangle:setMaxz(z)
	self._values[4] = z
end

function Rectangle:getMinx()
	return self._values[1]
end

function Rectangle:getMaxx()
	return self._values[2]
end

function Rectangle:getMinz()
	return self._values[3]
end

function Rectangle:getMaxz()
	return self._values[4]
end

function Rectangle:getRanges()
	return self._values[1], self._values[2], self._values[3], self._values[4]
end

function Rectangle:inRectangle(x, z)
	return x >= self._values[1] and x <= self._values[2] and z >= self._values[3] and z <= self._values[4]
end

function Rectangle:union(rectangle)
	self._values[1] = math.min(self._values[1], rectangle._values[1])
	self._values[2] = math.max(self._values[2], rectangle._values[2])
	self._values[3] = math.min(self._values[3], rectangle._values[3])
	self._values[4] = math.max(self._values[4], rectangle._values[4])
end

function Rectangle:toString()
	local values = self._values

	return string.format("[%s,%s,%s,%s]", values[1], values[2], values[3], values[4])
end

return Rectangle
