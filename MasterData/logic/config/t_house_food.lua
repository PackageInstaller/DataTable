-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_food.lua

module("logic.config.t_house_food", package.seeall)

local title = {
	id = 1,
	resName = 2
}
local dataList = {
	{
		1,
		"food002"
	},
	{
		2,
		"food002"
	},
	{
		3,
		"food002"
	},
	{
		4,
		"food002"
	},
	{
		5,
		"food002"
	},
	{
		6,
		"food002"
	},
	{
		7,
		"food002"
	},
	{
		8,
		"food002"
	},
	{
		9,
		"food002"
	},
	{
		10,
		"food002"
	},
	{
		11,
		"food002"
	},
	{
		12,
		"food002"
	},
	{
		13,
		"food002"
	},
	{
		14,
		"food002"
	},
	{
		15,
		"food002"
	},
	{
		16,
		"food002"
	},
	{
		17,
		"food002"
	},
	{
		18,
		"food002"
	},
	{
		19,
		"food002"
	},
	{
		20,
		"food002"
	},
	{
		21,
		"food002"
	},
	{
		22,
		"food002"
	},
	{
		23,
		"food002"
	},
	{
		24,
		"food002"
	},
	{
		25,
		"food002"
	},
	{
		26,
		"food002"
	},
	{
		27,
		"food002"
	},
	{
		28,
		"food002"
	},
	{
		29,
		"food002"
	},
	{
		30,
		"food002"
	},
	{
		31,
		"food002"
	},
	{
		32,
		"food002"
	},
	{
		33,
		"food002"
	},
	{
		34,
		"food002"
	},
	{
		35,
		"food002"
	},
	{
		36,
		"food002"
	},
	{
		37,
		"food002"
	},
	{
		38,
		"food002"
	},
	{
		39,
		"food002"
	},
	{
		40,
		"food002"
	},
	{
		41,
		"food002"
	},
	{
		42,
		"food002"
	},
	{
		43,
		"food002"
	},
	{
		44,
		"food002"
	},
	{
		45,
		"food002"
	},
	{
		46,
		"food002"
	},
	{
		47,
		"food002"
	},
	{
		48,
		"food002"
	},
	{
		49,
		"food002"
	},
	{
		50,
		"food002"
	},
	{
		51,
		"food002"
	},
	{
		52,
		"food002"
	},
	{
		53,
		"food002"
	},
	{
		54,
		"food002"
	}
}
local t_house_food = {}

t_house_food.dataList = dataList

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
	t_house_food[v[1]] = v

	setmetatable(v, mt)
end

return t_house_food
