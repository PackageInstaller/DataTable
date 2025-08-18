-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResEquipBaptize.lua

local RT = {}

RT[1] = {
	11,
	13,
	24,
	12,
	14,
	25,
	4,
	3,
	23,
	26
}
RT[2] = {
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
}
RT[3] = {
	1,
	1,
	1,
	1,
	1,
	1
}

local Data = {
	{
		pos = 1,
		sub_attr_num = 10,
		repeat_num = 1,
		sub_attr_range = RT[1],
		sub_attr_weight = RT[2]
	},
	{
		pos = 2,
		sub_attr_num = 10,
		repeat_num = 1,
		sub_attr_range = RT[1],
		sub_attr_weight = RT[2]
	},
	{
		pos = 3,
		sub_attr_num = 6,
		repeat_num = 2,
		sub_attr_range = {
			11,
			12,
			4,
			3,
			23,
			26
		},
		sub_attr_weight = RT[3]
	},
	{
		pos = 4,
		sub_attr_num = 10,
		repeat_num = 1,
		sub_attr_range = RT[1],
		sub_attr_weight = RT[2]
	},
	{
		pos = 5,
		sub_attr_num = 10,
		repeat_num = 1,
		sub_attr_range = RT[1],
		sub_attr_weight = RT[2]
	},
	{
		pos = 6,
		sub_attr_num = 6,
		repeat_num = 2,
		sub_attr_range = {
			13,
			24,
			14,
			25,
			23,
			26
		},
		sub_attr_weight = RT[3]
	}
}

return Data
