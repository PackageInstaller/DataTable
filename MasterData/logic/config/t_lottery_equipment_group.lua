-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_equipment_group.lua

module("logic.config.t_lottery_equipment_group", package.seeall)

local title = {
	floatWeight = 3,
	groupCode = 1,
	itemCode = 2,
	floatTimeRange = 4
}
local dataList = {
	{
		20001,
		1325001,
		0,
		""
	},
	{
		20001,
		1365002,
		0,
		""
	},
	{
		20001,
		1365003,
		0,
		""
	},
	{
		20001,
		1315003,
		0,
		""
	},
	{
		20001,
		1345003,
		0,
		""
	},
	{
		20001,
		1335001,
		0,
		""
	},
	{
		20002,
		1314002,
		0,
		""
	},
	{
		20002,
		1344002,
		0,
		""
	},
	{
		20002,
		1334002,
		0,
		""
	},
	{
		20002,
		1354001,
		0,
		""
	},
	{
		20002,
		1314001,
		0,
		""
	},
	{
		20002,
		1364002,
		0,
		""
	},
	{
		20002,
		1354002,
		0,
		""
	},
	{
		20002,
		1324002,
		0,
		""
	},
	{
		20002,
		1364003,
		0,
		""
	},
	{
		20002,
		1344001,
		0,
		""
	},
	{
		20003,
		1303004,
		0,
		""
	},
	{
		20003,
		1303003,
		0,
		""
	},
	{
		20003,
		1303006,
		0,
		""
	},
	{
		20003,
		1303002,
		0,
		""
	},
	{
		20003,
		1303005,
		0,
		""
	},
	{
		20003,
		1303008,
		0,
		""
	},
	{
		20003,
		1303011,
		0,
		""
	},
	{
		20003,
		1303014,
		0,
		""
	},
	{
		20004,
		1302001,
		0,
		""
	},
	{
		20004,
		1302003,
		0,
		""
	},
	{
		20004,
		1302004,
		0,
		""
	},
	{
		20004,
		1302005,
		0,
		""
	},
	{
		20004,
		1302006,
		0,
		""
	},
	{
		20004,
		1302007,
		0,
		""
	},
	{
		20004,
		1302008,
		0,
		""
	},
	{
		20004,
		1302009,
		0,
		""
	},
	{
		20004,
		1302010,
		0,
		""
	},
	{
		20004,
		1302011,
		0,
		""
	},
	{
		20010,
		1345004,
		100,
		"2023-01-01 05:00:00#2033-05-10 23:59:00"
	},
	{
		20020,
		1355002,
		100,
		"2023-01-01 05:00:00#2033-05-10 23:59:00"
	}
}
local t_lottery_equipment_group = {}

t_lottery_equipment_group.dataList = dataList

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
	local parent1 = t_lottery_equipment_group[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_lottery_equipment_group[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_lottery_equipment_group
