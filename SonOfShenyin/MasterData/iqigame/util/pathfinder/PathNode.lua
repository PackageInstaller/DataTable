-- chunkname: @IQIGame\\Util\\PathFinder\\PathNode.lua

local m = {
	g = 0,
	isClose = false,
	h = 0,
	y = 0,
	id = 0,
	isOpen = false,
	x = 0
}

function m.New(id, x, y)
	local obj = Clone(m)

	obj:Ctor(id, x, y)

	return obj
end

function m:Ctor(id, x, y)
	self.id = id
	self.x = x
	self.y = y
end

function m:Equals(obj)
	if obj == nil then
		return false
	end

	if self == obj then
		return true
	end

	return self.x == obj.x and self.y == obj.y
end

return m
