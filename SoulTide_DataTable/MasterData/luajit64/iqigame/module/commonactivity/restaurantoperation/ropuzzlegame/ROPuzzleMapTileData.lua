-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROPuzzleGame\\ROPuzzleMapTileData.lua

local m = {
	index = 0,
	blockId = 0,
	x = 0,
	y = 0
}

function m.New(index, x, y, id)
	local o = Clone(m)

	o:Init(index, x, y, id)

	return o
end

function m:Init(index, x, y, id)
	self.index = index
	self.x = x
	self.y = y
	self.blockId = id
end

return m
