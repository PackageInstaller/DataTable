-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkOneConnectBlockData.lua

local m = {
	State = 0,
	IsFirst = false,
	Y = 0,
	Index = 0,
	X = 0
}

function m.New(index, x, y)
	local o = Clone(m)

	o:Init(index, x, y)

	return o
end

function m:Init(index, x, y)
	self.Index = index
	self.X = tonumber(x)
	self.Y = tonumber(y)
end

return m
