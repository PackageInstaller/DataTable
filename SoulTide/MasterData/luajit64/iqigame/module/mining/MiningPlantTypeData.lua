-- chunkname: @IQIGame\\Module\\Mining\\MiningPlantTypeData.lua

local m = {
	num = 0,
	type = 0
}

function m.New(type, num)
	local o = Clone(m)

	o:Init(type, num)

	return o
end

function m:Init(type, num)
	self.type = type
	self.num = num
end

return m
