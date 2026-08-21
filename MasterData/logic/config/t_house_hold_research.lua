-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_research.lua

module("logic.config.t_house_hold_research", package.seeall)

local title = {
	score = 5,
	modulePoint = 4,
	point = 3,
	code = 1,
	level = 2
}
local dataList = {
	{
		101,
		0,
		100,
		1,
		1
	},
	{
		101,
		1,
		300,
		1,
		1.3
	},
	{
		101,
		2,
		600,
		1,
		1.6
	},
	{
		101,
		3,
		1000,
		1,
		1.9
	},
	{
		101,
		4,
		1500,
		1,
		2.2
	},
	{
		101,
		5,
		2100,
		1,
		2.5
	},
	{
		101,
		6,
		2800,
		1,
		2.8
	},
	{
		101,
		7,
		3600,
		1,
		3.1
	},
	{
		101,
		8,
		4500,
		1,
		3.4
	},
	{
		101,
		9,
		5500,
		1,
		3.7
	},
	{
		101,
		10,
		0,
		1,
		4
	},
	{
		102,
		0,
		200,
		1,
		1
	},
	{
		102,
		1,
		600,
		1,
		1.3
	},
	{
		102,
		2,
		1200,
		1,
		1.6
	},
	{
		102,
		3,
		2000,
		1,
		1.9
	},
	{
		102,
		4,
		3000,
		1,
		2.2
	},
	{
		102,
		5,
		4200,
		2,
		2.5
	},
	{
		102,
		6,
		5600,
		2,
		2.8
	},
	{
		102,
		7,
		7200,
		2,
		3.1
	},
	{
		102,
		8,
		9000,
		2,
		3.4
	},
	{
		102,
		9,
		11000,
		2,
		3.7
	},
	{
		102,
		10,
		0,
		3,
		4
	},
	{
		103,
		0,
		200,
		1,
		1
	},
	{
		103,
		1,
		600,
		1,
		1.3
	},
	{
		103,
		2,
		1200,
		1,
		1.6
	},
	{
		103,
		3,
		2000,
		1,
		1.9
	},
	{
		103,
		4,
		3000,
		1,
		2.2
	},
	{
		103,
		5,
		4200,
		2,
		2.5
	},
	{
		103,
		6,
		5600,
		2,
		2.8
	},
	{
		103,
		7,
		7200,
		2,
		3.1
	},
	{
		103,
		8,
		9000,
		2,
		3.4
	},
	{
		103,
		9,
		11000,
		2,
		3.7
	},
	{
		103,
		10,
		0,
		3,
		4
	}
}
local t_house_hold_research = {}

t_house_hold_research.dataList = dataList

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
	local parent1 = t_house_hold_research[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_hold_research[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_house_hold_research
