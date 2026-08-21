-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datastruct/Array2D.lua

module("logic.battle.datastruct.Array2D", package.seeall)

local Array2D = class("Array2D")

function Array2D:ctor(width, height)
	self._width = width
	self._height = height
	self._datas = {}
end

function Array2D:setWidthAndHeight(width, height)
	self:clear()

	self._width = width
	self._height = height
end

function Array2D:getElement(x, y)
	local index = self:_getIndex(x, y)

	return self._datas[index]
end

function Array2D:setElement(x, y, value)
	local index = self:_getIndex(x, y)

	self._datas[index] = value
end

function Array2D:clear()
	self._datas = {}
end

function Array2D:_getIndex(x, y)
	return 1 + x + y * self._width
end

function Array2D:ipairs()
	return ipairs(self._datas)
end

return Array2D
