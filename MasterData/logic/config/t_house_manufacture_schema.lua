-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_manufacture_schema.lua

module("logic.config.t_house_manufacture_schema", package.seeall)

local title = {
	store = 4,
	unlockLevel = 6,
	paper = 5,
	type = 2,
	id = 1,
	need = 3,
	limit = 7
}
local dataList = {
	{
		1702001,
		1,
		5000,
		1,
		0,
		1,
		0
	},
	{
		1702002,
		1,
		12000,
		2,
		0,
		3,
		1
	},
	{
		1702003,
		1,
		45000,
		3,
		0,
		6,
		2
	},
	{
		1705001,
		1,
		10000,
		2,
		0,
		2,
		1
	},
	{
		1003001,
		2,
		2500,
		1,
		0,
		1,
		1
	},
	{
		1003002,
		2,
		11000,
		2,
		0,
		4,
		0
	},
	{
		1003003,
		2,
		20000,
		3,
		0,
		7,
		0
	},
	{
		1004049,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004053,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004057,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004061,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004065,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004069,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1004073,
		2,
		20000,
		2,
		0,
		1,
		1
	},
	{
		1706001,
		3,
		10000,
		5,
		0,
		1,
		1
	}
}
local t_house_manufacture_schema = {}

t_house_manufacture_schema.dataList = dataList

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
	t_house_manufacture_schema[v[1]] = v

	setmetatable(v, mt)
end

return t_house_manufacture_schema
