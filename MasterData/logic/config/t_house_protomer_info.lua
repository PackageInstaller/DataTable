-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_protomer_info.lua

module("logic.config.t_house_protomer_info", package.seeall)

local title = {
	billboardicon = 10,
	billboardname = 9,
	billboardpath = 11,
	preferen = 4,
	unlockdesc = 12,
	serialnum = 6,
	touchname = 8,
	unlock = 2,
	prototype = 3,
	id = 1,
	serialdegree = 5,
	roomname = 7
}
local dataList = {
	{
		1901001,
		101,
		{
			1,
			2
		},
		{
			2,
			3
		},
		"A",
		"379",
		"厄运预告",
		{
			"音波分析",
			"维护工作",
			"压迫实验",
			"尝试沟通",
			"更换唱片",
			"请求预言"
		},
		{
			"推荐音波分析",
			"禁止音波分析",
			"推荐维护工作",
			"禁止维护工作",
			"推荐压迫实验",
			"禁止压迫实验",
			"推荐尝试沟通",
			"禁止尝试沟通",
			"推荐更换唱片",
			"禁止更换唱片",
			"推荐请求预言",
			"禁止请求预言"
		},
		{
			"1901001_01",
			"1901001_02",
			"1901001_03",
			"1901001_04",
			"1901001_05",
			"1901001_06",
			"1901001_07",
			"1901001_08",
			"1901001_09",
			"1901001_10",
			"1901001_11",
			"1901001_12"
		},
		{
			"s206_plane_ui",
			"s206_plane_ui (1)",
			"s206_plane_ui (2)"
		},
		{
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901002,
		101,
		{
			1
		},
		{
			2,
			0
		},
		"B",
		"0056",
		"测试异化物1",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901003,
		101,
		{
			2
		},
		{
			2,
			3
		},
		"B",
		"0057",
		"测试异化物2",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901004,
		101,
		{
			1,
			2
		},
		{
			2,
			3
		},
		"B",
		"0058",
		"测试异化物3",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901005,
		101,
		{
			1,
			2
		},
		{
			2,
			3
		},
		"B",
		"0059",
		"测试异化物4",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901006,
		101,
		{
			1,
			2
		},
		{
			2,
			3
		},
		"B",
		"0060",
		"测试异化物5",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	},
	{
		1901007,
		101,
		{
			1,
			2
		},
		{
			2,
			3
		},
		"B",
		"0061",
		"测试异化物6",
		[12] = {
			"解锁条件描述1",
			"解锁条件描述2"
		}
	}
}
local t_house_protomer_info = {}

t_house_protomer_info.dataList = dataList

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
	t_house_protomer_info[v[1]] = v

	setmetatable(v, mt)
end

return t_house_protomer_info
