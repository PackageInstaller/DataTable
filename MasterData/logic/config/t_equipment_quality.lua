-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_quality.lua

module("logic.config.t_equipment_quality", package.seeall)

local title = {
	quality = 1,
	lossRate = 3,
	levelLimit = 2
}
local dataList = {
	{
		5,
		30,
		700
	},
	{
		4,
		20,
		1000
	},
	{
		3,
		10,
		1000
	},
	{
		2,
		10,
		1000
	}
}
local t_equipment_quality = {}

t_equipment_quality.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_equipment_quality[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_quality
