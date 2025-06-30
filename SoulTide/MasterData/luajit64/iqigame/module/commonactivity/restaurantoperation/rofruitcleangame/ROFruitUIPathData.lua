-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROFruitCleanGame\\ROFruitUIPathData.lua

local m = {
	x = 0,
	y = 0,
	dir = {}
}

function m.New(x, y, dir)
	local o = Clone(m)

	o:Init(x, y, dir)

	return o
end

function m:Init(x, y, dir)
	self.x = x
	self.y = y
	self.dir = dir
end

return m
