-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_break.lua

module("logic.config.t_equipment_break", package.seeall)

local title = {
	exp = 2,
	quality = 1,
	loss = 3,
	rank = 4
}
local dataList = {
	{
		"S",
		1000,
		90,
		{
			50,
			60,
			70,
			80,
			90,
			100
		}
	},
	{
		"A",
		500,
		90,
		{
			30,
			40,
			50,
			60,
			70,
			80
		}
	},
	{
		"B",
		150,
		90,
		{
			20,
			30,
			40,
			50,
			60,
			70
		}
	},
	{
		"C",
		50,
		90,
		{
			10,
			20,
			30,
			40,
			50,
			60
		}
	}
}
local t_equipment_break = {
	S = dataList[1],
	A = dataList[2],
	B = dataList[3],
	C = dataList[4]
}

t_equipment_break.dataList = dataList

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
	setmetatable(v, mt)
end

return t_equipment_break
