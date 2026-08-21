-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_protomer.lua

module("logic.config.t_house_hold_protomer", package.seeall)

local title = {
	shelterRoomType = 4,
	echoRange = 7,
	research = 9,
	degree = 2,
	pressureRange = 5,
	module = 8,
	goodsReward = 14,
	researchReward = 13,
	evaluate = 12,
	productivity = 3,
	breakdownRange = 6,
	echoReward = 15,
	id = 1,
	touch = 11,
	attr = 10
}
local dataList = {
	{
		1901001,
		1,
		10000,
		2,
		{
			3,
			6
		},
		{
			3,
			5
		},
		{
			3,
			5
		},
		101,
		103,
		101,
		101,
		101,
		30,
		1502101,
		1303005
	},
	{
		1901002,
		2,
		3000,
		1,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		103,
		102,
		102,
		102,
		60,
		1001,
		1315001
	},
	{
		1901003,
		3,
		10000,
		0,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		103,
		103,
		103,
		101,
		60,
		1001,
		1315001
	},
	{
		1901004,
		3,
		10000,
		0,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		103,
		101,
		101,
		101,
		60,
		1001,
		1315001
	},
	{
		1901005,
		3,
		10000,
		0,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		103,
		102,
		102,
		101,
		60,
		1001,
		1315001
	},
	{
		1901006,
		1,
		10000,
		0,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		103,
		103,
		103,
		101,
		60,
		1001,
		1315001
	},
	{
		1901007,
		2,
		10000,
		0,
		{
			3,
			7
		},
		{
			3,
			7
		},
		{
			3,
			7
		},
		101,
		102,
		101,
		101,
		101,
		80,
		1001,
		1314001
	}
}
local t_house_hold_protomer = {}

t_house_hold_protomer.dataList = dataList

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
	t_house_hold_protomer[v[1]] = v

	setmetatable(v, mt)
end

return t_house_hold_protomer
